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

@interface SuspendBeginViewController ()

@property (nonatomic) CMMotionManager *motionManager;

@property (nonatomic) CMAccelerometerData *data;

@end

@implementation SuspendBeginViewController

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"data"];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.motionManager stopAccelerometerUpdates];
}

-(void)kaishi
{
    [self.motionManager stopAccelerometerUpdates];

    SuspendSucViewController *vc = [[SuspendSucViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLb.text = @"底盘悬挂体验";
    self.carView.hidden = NO;
    
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


}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"data"]) {
//        id oldName = [change objectForKey:NSKeyValueChangeOldKey];
//        if (![DEF_OBJECT_TO_STIRNG(oldName) isEqualToString:@""]) {
//            CMAccelerometerData * _Nullable oldaccelerometerData = oldName;
//            NSLog(@"oldName----------%@",[NSString stringWithFormat:@"加速度为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",oldaccelerometerData.acceleration.x,oldaccelerometerData.acceleration.y,oldaccelerometerData.acceleration.z]);
//        }
        
        id newName = [change objectForKey:NSKeyValueChangeNewKey];
        if (![DEF_OBJECT_TO_STIRNG(newName) isEqualToString:@""]) {
            CMAccelerometerData * _Nullable newaccelerometerData = newName;
            NSLog(@"newName-----------%@",[NSString stringWithFormat:@"加速度为\n---------\nX轴：%+.2f\nY轴：%+.2f\nZ轴：%+.2f",newaccelerometerData.acceleration.x,newaccelerometerData.acceleration.y,newaccelerometerData.acceleration.z]);
            
            double x = fabs(newaccelerometerData.acceleration.x);
            double y = fabs(newaccelerometerData.acceleration.y);
            double z = fabs(newaccelerometerData.acceleration.z);

            if (x > 1.6 || y > 1.6 || z > 2.6) {
                NSLog(@">>>>>>>>>>>>>>>");
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
