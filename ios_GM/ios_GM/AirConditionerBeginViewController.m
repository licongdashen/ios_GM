//
//  AirConditionerBeginViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AirConditionerBeginViewController.h"
#import "DecibelMeterHelper.h"
#import "AirConditionerSucViewController.h"

@interface AirConditionerBeginViewController ()
{
    AVPlayer *player;
}
@property (strong, nonatomic)AVPlayer *myPlayer;//播放器
@property (strong, nonatomic)AVPlayerItem *item;//播放单元
@property (strong, nonatomic)AVPlayerLayer *playerLayer;//播放界面（layer）
@property (nonatomic, strong) DecibelMeterHelper           *dbHelper;

@end

@implementation AirConditionerBeginViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.dbHelper stopMeasuring];
    [player pause];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.myPlayer.currentItem];
    
    [self.item removeObserver:self forKeyPath:@"status"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"空调体验";
    self.carView.hidden = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"蒲公英" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.item = [AVPlayerItem playerItemWithURL:url];
    self.myPlayer = [AVPlayer playerWithPlayerItem:self.item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.myPlayer];
    self.playerLayer.frame = CGRectMake(DEF_RESIZE_UI(63), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(98), DEF_RESIZE_UI(250), DEF_RESIZE_UI(250));
    self.playerLayer.cornerRadius = DEF_RESIZE_UI(250)/2;
    self.playerLayer.masksToBounds = YES;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.playerLayer.borderColor = DEF_RGB(111, 117, 119).CGColor;
    self.playerLayer.borderWidth = 8;
    [self.view.layer addSublayer:self.playerLayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.myPlayer.currentItem];
    [self.item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0,DEF_RESIZE_UI(400) + DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, 17 + 25)];
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"您看，蒲公英\n正在随着风量增大而加速飘散";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.numberOfLines = 2;
    titleLb.textColor = DEF_UICOLORFROMRGB(0x848484);
    [self.view addSubview:titleLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), DEF_DEVICE_HEIGHT - DEF_RESIZE_UI(78)- DEF_RESIZE_UI(48), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"结束体验" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    self.dbHelper = [[DecibelMeterHelper alloc]init];
    __weak typeof(self) weakSelf = self;
    self.dbHelper.decibelMeterBlock = ^(double dbSPL){
        
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"ccccc%@",[NSString stringWithFormat:@"%.2lf",dbSPL]);
            if (dbSPL > 20) {
                [strongSelf.dbHelper stopMeasuring];
                [strongSelf.myPlayer play];
                [strongSelf playav];
            }else{
            }
        });
        
    };
    [self.dbHelper startMeasuringWithIsSaveVoice:NO];

}

-(void)jieshu
{
    [self.myPlayer pause];
    [self.dbHelper stopMeasuring];
    [player pause];
    
    AirConditionerSucViewController *vc = [[AirConditionerSucViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)playav
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"8270" ofType:@"mp3"];
    // (2)把音频文件转化成url格式
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    player = [[AVPlayer alloc] initWithPlayerItem:item];
    [player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
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

-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    [self.myPlayer seekToTime:CMTimeMake(0, 1)];
    [self.myPlayer play];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
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
