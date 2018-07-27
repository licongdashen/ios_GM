//
//  SuspendBeginViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SuspendBeginViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "SuspendSucViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface SuspendBeginViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager *_manger;
}

@property (nonatomic) CMMotionManager *motionManager;

@property (nonatomic) CMAccelerometerData *data;
@property (nonatomic, strong) NSMutableArray *musicArr1;
@property (nonatomic, strong) NSMutableArray *musicArr2;
@property (nonatomic, strong) NSMutableArray *musicArr3;
@property (nonatomic, strong) NSMutableArray *musicArr4;

@property (nonatomic, weak)UIImageView *musicImagv1;

@property int shuiwei;

@property (nonatomic, strong) NSString* stability;

@property CLLocation *fristLocation;

@property CLLocation *endLocation;

@property BOOL isfrist;

@property (nonatomic) dispatch_source_t timer;

@property int timeCount;

@end

@implementation SuspendBeginViewController

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"data"];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.motionManager stopAccelerometerUpdates];
    [_manger stopUpdatingLocation];

    dispatch_source_cancel(self.timer);
}

-(void)kaishi
{
    CLLocation *loc1=[[CLLocation alloc]initWithLatitude:self.fristLocation.coordinate.latitude longitude:self.fristLocation.coordinate.longitude];
    CLLocation *loc2=[[CLLocation alloc]initWithLatitude:self.endLocation.coordinate.latitude longitude:self.endLocation.coordinate.longitude];
    CLLocationDistance distance=[loc1 distanceFromLocation:loc2];
    NSLog(@"距离=%fM",distance);
    
    dispatch_source_cancel(self.timer);
    [self.motionManager stopAccelerometerUpdates];
    [_manger stopUpdatingLocation];
    SuspendSucViewController *vc = [[SuspendSucViewController alloc]init];
    vc.score = [NSString stringWithFormat:@"%d",self.shuiwei];
    vc.uid = DEF_MyAppDelegate.loginDic[@"access_token"];
    vc.carid = DEF_MyAppDelegate.carDic[@"id"];
    vc.fousname = DEF_MyAppDelegate.loginDic[@"storeShortName"];
    vc.stability = self.stability;
    vc.time = [NSString stringWithFormat:@"%f",(float)self.timeCount/(float)60];
    float sudu = (float)distance/(float)self.timeCount * 3.6;
    vc.speed = [NSString stringWithFormat:@"%f",sudu];
    
    DEF_MyAppDelegate.baogaoDic = @{@"uid":DEF_MyAppDelegate.loginDic[@"access_token"],
                                    @"carid":[NSString stringWithFormat:@"%@",DEF_MyAppDelegate.carDic[@"id"]],
                                    @"fousname":DEF_MyAppDelegate.loginDic[@"storeShortName"],
                                    @"time":[NSString stringWithFormat:@"%.2f",(float)self.timeCount/(float)60],
                                    @"speed":[NSString stringWithFormat:@"%.2f",sudu],
                                    @"stability":self.stability,
                                    };
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isfrist = YES;
    
    self.titleLb.text = @"底盘悬挂体验";
    self.carView.hidden = NO;
    
    self.shuiwei = 100;
    
    self.stability = @"4";
    
    self.musicArr1 = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 143; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"water%d",i]];
        [self.musicArr1 addObject:image];
    }
    
    self.musicArr2 = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 143; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [self.musicArr2 addObject:image];
    }
    
    UIImageView *musicImagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,  DEF_RESIZE_UI(167), DEF_RESIZE_UI(232), DEF_RESIZE_UI(251))];
    musicImagv1.centerX = self.view.centerX;
    musicImagv1.contentMode = UIViewContentModeScaleAspectFill;
    musicImagv1.animationRepeatCount = 1;
    [self.view addSubview:musicImagv1];
    [musicImagv1 startAnimating];
    self.musicImagv1 = musicImagv1;
    self.musicImagv1.image = DEF_IMAGE(@"water1");

    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(463), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"结束试驾" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(kaishi) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, loginBtn.bottom + DEF_RESIZE_UI(21), 268, 20)];
    [btn setTitle:@"驾驶时请系好安全带" forState:0];
    [btn setTitleColor:DEF_UICOLORFROMRGB(0x848484) forState:0];
    btn.titleLabel.font = DEF_MyFont(14);
    [btn setImage:DEF_IMAGE(@"提示") forState:0];
    btn.centerX = self.view.centerX;
    [self.view addSubview:btn];
    
    self.motionManager = [[CMMotionManager alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    //如果CMMotionManager支持获取加速度数据
    if (self.motionManager.accelerometerAvailable) {
        //设置CMMotionManager的加速度数据更新频率为0.1秒
        self.motionManager.accelerometerUpdateInterval = 0.1;
        //使用代码块开始获取加速度数据
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            //如果发生了错误，error不为空
            if (error) {
                //停止获取加速度数据
                [self.motionManager stopAccelerometerUpdates];
            } else {
                self.data = accelerometerData;
            }
        }];
    } else {
        NSLog(@"该设备不支持获取加速度数据！");
    }
    
    [self addObserver: self forKeyPath: @"data" options: NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];


    _manger = [[CLLocationManager alloc] init];
    
    //设置位置管理者对象的代理
    _manger.delegate = self;
    
    //设置定位精度（精度越高越耗电，定位时间越长）
    _manger.desiredAccuracy = kCLLocationAccuracyBest;
    
    //设置定位间隔（每移动多远获取一次定位信息）
    // _manger.distanceFilter = 10;
    
    //设置定位授权
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
    {
        _manger.allowsBackgroundLocationUpdates = YES;
    }
    [_manger requestWhenInUseAuthorization];
    [_manger startUpdatingLocation];
    [_manger location];
    
//    [self countDistance];
    
    @weakify(self);
   [[RACObserve(self, shuiwei)skip:1] subscribeNext:^(id x) {
        @strongify(self);
        int count = [x intValue];
        NSLog(@"shu%d",count);
        if (count < 100 && count >= 90) {
            self.stability = @"4";
            dispatch_async(dispatch_get_main_queue(), ^{
                self.musicImagv1.image = DEF_IMAGE(@"water1");
                self.musicImagv1.animationImages = self.musicArr1;
                [self.musicImagv1 startAnimating];
            });
        }else if (count < 90 && count >= 80){
            self.stability = @"3";

            dispatch_async(dispatch_get_main_queue(), ^{
                self.musicImagv1.image = DEF_IMAGE(@"water1");
                self.musicImagv1.animationImages = self.musicArr1;
                [self.musicImagv1 startAnimating];
            });
        }else if (count < 80 && count >= 70){
            self.stability = @"2";

            dispatch_async(dispatch_get_main_queue(), ^{
                self.musicImagv1.image = DEF_IMAGE(@"water1");
                self.musicImagv1.animationImages = self.musicArr1;
                [self.musicImagv1 startAnimating];
            });
        }else{
            self.stability = @"1";
            dispatch_async(dispatch_get_main_queue(), ^{
                self.musicImagv1.image = DEF_IMAGE(@"water1");
                self.musicImagv1.animationImages = self.musicArr1;
                [self.musicImagv1 startAnimating];
            });
        }
    }];
    
    self.timeCount = 0;
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue1);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.timeCount ++;
        });
    });
    dispatch_resume(self.timer);
    
}

//当定位权限的授权状态发生改变时调用该方法
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
            //1、尚未确定是否授权
        case kCLAuthorizationStatusNotDetermined:
            
            NSLog(@"用户尚未确定是否授权！");
//            [CACUtility showTips:@"用户尚未确定是否授权！"];

            break;
            
            //2、访问权限受限
        case kCLAuthorizationStatusRestricted:
            
            NSLog(@"获取定位权限授权状态受限！");
            [CACUtility showTips:@"获取定位权限授权状态受限！"];

            break;
            
            //3、获取定位权限被拒绝
        case kCLAuthorizationStatusDenied:
            
            // 定位服务是否可用（用户是否开启了手机上的定位开关）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"手机定位功能开启，但被拒绝");
                [CACUtility showTips:@"手机定位功能开启，但被拒绝"];

            }
            
            else
            {
                NSLog(@"手机定位功能关闭，不可用");
                [CACUtility showTips:@"手机定位功能关闭，不可用"];

            }
            
            break;
            
            //4、获取前台定位权限
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            
            NSLog(@"获取了前台定位权限！");
//            [CACUtility showTips:@"获取了前台定位权限！"];

            break;
            
            //5、获取后台定位权限
        case kCLAuthorizationStatusAuthorizedAlways:
            
            NSLog(@"获取了后台定位权限！");
//            [CACUtility showTips:@"获取了后台定位权限！"];

            break;
            
    }
}

-(void)countDistance
{
    CLLocation *loc1=[[CLLocation alloc]initWithLatitude:40 longitude:116];
    CLLocation *loc2=[[CLLocation alloc]initWithLatitude:41 longitude:116];
    CLLocationDistance distance=[loc1 distanceFromLocation:loc2];
     NSLog(@"(%@)和(%@)的距离=%fM",loc1,loc2,distance);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [CACUtility showTips:@"获取位置信息失败！"];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = (CLLocation *)[locations lastObject];
 
    if (self.isfrist == YES) {
        self.fristLocation =currentLocation;
        self.isfrist = NO;
        NSLog(@"纬度1=%f，经度1=%f",self.fristLocation.coordinate.latitude,self.fristLocation.coordinate.longitude);

    }
    self.endLocation = currentLocation;
    NSLog(@"纬度2=%f，经度2=%f",self.endLocation.coordinate.latitude,self.endLocation.coordinate.longitude);

}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"data"]) {

        id newName = [change objectForKey:NSKeyValueChangeNewKey];
        if (![DEF_OBJECT_TO_STIRNG(newName) isEqualToString:@""]) {
            CMAccelerometerData * _Nullable newaccelerometerData = newName;
//            NSLog(@"newName-----------%@",[NSString stringWithFormat:@"加速度为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",newaccelerometerData.acceleration.x,newaccelerometerData.acceleration.y,newaccelerometerData.acceleration.z]);
            
            double x = fabs(newaccelerometerData.acceleration.x);
            double y = fabs(newaccelerometerData.acceleration.y);
            double z = fabs(newaccelerometerData.acceleration.z);

            if (x > 1.1 || y > 1.1 || z > 1.1) {
               
                self.shuiwei -= 2;
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
