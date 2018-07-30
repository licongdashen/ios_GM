//
//  BossSound1ViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BossSound1ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BossSound1BeginViewController.h"

@interface BossSound1ViewController ()<CBCentralManagerDelegate,AVAudioPlayerDelegate,UIAlertViewDelegate>
{
    AVPlayer *player;
}
@property (nonatomic,strong)CBCentralManager *centralManager;

@property BOOL blueToothOpen;
@property (nonatomic) dispatch_source_t timer;
@property int count;
@property (nonatomic, weak)UIButton *btn;

@end

@implementation BossSound1ViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLb.text = @"真实音效体验";
    self.carView.hidden = NO;
    self.carLb.text = self.dic[@"name"];
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"real"];
    animation.frame = CGRectMake(0, self.carView.bottom + DEF_RESIZE_UI(54), DEF_RESIZE_UI(282), DEF_RESIZE_UI(282));
    animation.centerX = self.view.centerX;
    animation.loopAnimation = YES;
    animation.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animation];
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, animation.bottom + DEF_RESIZE_UI(75), DEF_DEVICE_WIDTH, 17 + 25)];
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"即将播放一段声音\n您觉得他们来自哪里";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.numberOfLines = 2;
    titleLb.textColor = DEF_UICOLORFROMRGB(0x848484);
    [self.view addSubview:titleLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), titleLb.bottom + DEF_RESIZE_UI(16), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"开始体验" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = DEF_RESIZE_UI(8);
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(kaishi) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, loginBtn.bottom + DEF_RESIZE_UI(28), 268, 20)];
    [btn setTitle:@"请使用蓝牙或数据线连接车载音响" forState:0];
    [btn setTitleColor:DEF_UICOLORFROMRGB(0x898989) forState:0];
    btn.titleLabel.font = DEF_MyFont(14);
    [btn setImage:DEF_IMAGE(@"蓝牙") forState:0];
    btn.centerX = self.view.centerX;
    [self.view addSubview:btn];
    self.btn = btn;
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    self.count = 1000000;

    [self playAv];
}

-(void)playAv
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BOSE_3 真实音效 开始" ofType:@"wav"];
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


//监听点击事件 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"确定"]) {
        [player pause];
        BossSound1BeginViewController *vc = [[BossSound1BeginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([btnTitle isEqualToString:@"去支付"] ) {
        
    }
}

-(void)kaishi
{
    if (self.blueToothOpen == NO) {
        UIAlertView *WXinstall=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请打开蓝牙连接车载设备"delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        WXinstall.delegate = self;
        [WXinstall show];
        
    }else{
        [player pause];
        BossSound1BeginViewController *vc = [[BossSound1BeginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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
