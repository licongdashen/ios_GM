//
//  BossSoundViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BossSoundViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BossSound1ViewController.h"
#import "BossSound2ViewController.h"
#import "BossSound3ViewController.h"

@interface BossSoundViewController ()<CBCentralManagerDelegate,AVAudioPlayerDelegate>
{
    AVPlayer *player;
}
@property (nonatomic, weak)UIButton *btn;
@property (nonatomic,strong)CBCentralManager *centralManager;
@property (nonatomic) dispatch_source_t timer;
@property int count;
@property BOOL blueToothOpen;

@end

@implementation BossSoundViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"音响体验";
    self.carView.hidden = NO;
    self.carLb.text = self.dic[@"name"];
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"sound"];
    animation.frame = CGRectMake(0, self.carView.bottom + DEF_RESIZE_UI(54), DEF_RESIZE_UI(282), DEF_RESIZE_UI(282));
    animation.centerX = self.view.centerX;
    animation.loopAnimation = YES;
    animation.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animation];
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, animation.bottom, DEF_DEVICE_WIDTH, 17)];
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"请选择您想体验的效果";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = DEF_UICOLORFROMRGB(0x848484);
    [self.view addSubview:titleLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(11), titleLb.bottom + DEF_RESIZE_UI(15), DEF_RESIZE_UI(112), DEF_RESIZE_UI(136))];
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(kaishi) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.borderColor = DEF_IMAGE_BACKGROUND_COLOR.CGColor;
    [self.view addSubview:loginBtn];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(30), DEF_RESIZE_UI(29), DEF_RESIZE_UI(52), DEF_RESIZE_UI(52))];
    imagv.image = DEF_IMAGE(@"真实音效");
    [loginBtn addSubview:imagv];
    
    UILabel *titeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, imagv.bottom + DEF_RESIZE_UI(22), loginBtn.width, 15)];
    titeLb.text = @"真实音效";
    titeLb.textAlignment = NSTextAlignmentCenter;
    titeLb.font = DEF_MyFont(14);
    titeLb.textColor = DEF_APP_MAIN_TITLECOLOR;
    [loginBtn addSubview:titeLb];
    
    UIButton *loginBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(loginBtn.right + DEF_RESIZE_UI(8), titleLb.bottom + DEF_RESIZE_UI(15), DEF_RESIZE_UI(112), DEF_RESIZE_UI(136))];
    loginBtn1.layer.cornerRadius = 8;
    loginBtn1.layer.masksToBounds = YES;
    [loginBtn1 addTarget:self action:@selector(kaishi1) forControlEvents:UIControlEventTouchUpInside];
    loginBtn1.layer.borderWidth = 1;
    loginBtn1.layer.borderColor = DEF_IMAGE_BACKGROUND_COLOR.CGColor;
    [self.view addSubview:loginBtn1];
    
    UIImageView *imagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(30), DEF_RESIZE_UI(29), DEF_RESIZE_UI(52), DEF_RESIZE_UI(52))];
    imagv1.image = DEF_IMAGE(@"环境音效");
    [loginBtn1 addSubview:imagv1];
    
    UILabel *titeLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, imagv1.bottom + DEF_RESIZE_UI(22), loginBtn.width, 15)];
    titeLb1.text = @"环绕音效";
    titeLb1.textAlignment = NSTextAlignmentCenter;
    titeLb1.font = DEF_MyFont(14);
    titeLb1.textColor = DEF_APP_MAIN_TITLECOLOR;
    [loginBtn1 addSubview:titeLb1];
    
    UIButton *loginBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(loginBtn1.right +  DEF_RESIZE_UI(8), titleLb.bottom + DEF_RESIZE_UI(15), DEF_RESIZE_UI(112), DEF_RESIZE_UI(136))];
    loginBtn2.layer.cornerRadius = 8;
    loginBtn2.layer.masksToBounds = YES;
    [loginBtn2 addTarget:self action:@selector(kaishi2) forControlEvents:UIControlEventTouchUpInside];
    loginBtn2.layer.borderWidth = 1;
    loginBtn2.layer.borderColor = DEF_IMAGE_BACKGROUND_COLOR.CGColor;
    [self.view addSubview:loginBtn2];
    
    UIImageView *imagv2 = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(30), DEF_RESIZE_UI(29), DEF_RESIZE_UI(52), DEF_RESIZE_UI(52))];
    imagv2.image = DEF_IMAGE(@"高低音效");
    [loginBtn2 addSubview:imagv2];
    
    UILabel *titeLb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, imagv2.bottom + DEF_RESIZE_UI(22), loginBtn.width, 15)];
    titeLb2.text = @"高低音效";
    titeLb2.textAlignment = NSTextAlignmentCenter;
    titeLb2.font = DEF_MyFont(14);
    titeLb2.textColor = DEF_APP_MAIN_TITLECOLOR;
    [loginBtn2 addSubview:titeLb2];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, animation.bottom + DEF_RESIZE_UI(208), 268, 20)];
    [btn setTitle:@"请使用蓝牙或数据线连接车载音响" forState:0];
    btn.titleLabel.font = DEF_MyFont(14);
    [btn setImage:DEF_IMAGE(@"蓝牙") forState:0];
    btn.centerX = self.view.centerX;
    [self.view addSubview:btn];
    self.btn = btn;
    
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    self.count = 1000000;
    
    [self playav];
}

-(void)playav
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BOSE_1 选择页面" ofType:@"wav"];
    // (2)把音频文件转化成url格式
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    player = [[AVPlayer alloc] initWithPlayerItem:item];
//    [player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playFinished:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:player.currentItem];
    [player play];
}

-(void)playFinished:(NSNotification *)obj
{
    [player pause];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        switch (player.status) {
            case AVPlayerStatusUnknown:
            {
                NSLog(@"未知转态");
            }
                break;
            case AVPlayerStatusReadyToPlay:
            {
                NSLog(@"准备播放");
            }
                break;
            case AVPlayerStatusFailed:
            {
                NSLog(@"加载失败");
            }
                break;
                
            default:
                break;
        }
        
    }
}

-(void)startCountDown
{
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
    
    @weakify(self);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            if (self.count %2 == 0) {
                [self.btn setTitleColor:DEF_UICOLORFROMRGB(0x898989) forState:0];
            }else{
                [self.btn setTitleColor:[UIColor redColor] forState:0];
            }
            self.count --;
        });
    });
    dispatch_resume(self.timer);
}

-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    //第一次打开或者每次蓝牙状态改变都会调用这个函数
    if(central.state==CBCentralManagerStatePoweredOn)
    {
        NSLog(@"蓝牙设备开着");
        self.blueToothOpen = YES;
        if (self.timer) {
            dispatch_source_cancel(self.timer);
        }
        [self.btn setTitleColor:DEF_UICOLORFROMRGB(0x898989) forState:0];
        
    }
    else
    {
        NSLog(@"蓝牙设备关着");
        self.blueToothOpen = NO;
        [self startCountDown];
    }
}

-(void)kaishi
{
    [player pause];
    BossSound1ViewController *vc = [[BossSound1ViewController alloc]init];
    vc.dic = self.dic;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)kaishi1
{
    [player pause];
    BossSound2ViewController *vc = [[BossSound2ViewController alloc]init];
    vc.dic = self.dic;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)kaishi2
{
    [player pause];
    BossSound3ViewController *vc = [[BossSound3ViewController alloc]init];
    vc.dic = self.dic;
    [self.navigationController pushViewController:vc animated:YES];
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
