//
//  BossSound2BeginViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BossSound2BeginViewController.h"
#import "BossSound2SucViewController.h"

@interface BossSound2BeginViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}

@property (nonatomic, weak)UIImageView *centerImagv;

@end

@implementation BossSound2BeginViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLb.text = @"环绕音效体验";
    self.carView.hidden = NO;
    
    UIImageView *centerImagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.carView.bottom + 12, DEF_RESIZE_UI(282), DEF_RESIZE_UI(282))];
    centerImagv.image = DEF_IMAGE(@"播放");
    centerImagv.contentMode = UIViewContentModeCenter;
    centerImagv.centerX = self.view.centerX;
    centerImagv.userInteractionEnabled = YES;
    [self.view addSubview:centerImagv];
    self.centerImagv = centerImagv;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        centerImagv.image = DEF_IMAGE(@"播放");
        [self playav];
    }];
    [centerImagv addGestureRecognizer:tap];
    
//    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, centerImagv.bottom + DEF_RESIZE_UI(100), DEF_DEVICE_WIDTH, 17)];
//    titleLb.font = DEF_MyFont(16);
//    titleLb.text = @"来感受一下吧";
//    titleLb.textAlignment = NSTextAlignmentCenter;
//    titleLb.textColor = DEF_UICOLORFROMRGB(0x848484);
//    [self.view addSubview:titleLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), centerImagv.bottom + DEF_RESIZE_UI(138), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"结束体验" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
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
    
    [self playav];
}

-(void)playav
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Introduction" ofType:@"wav"];
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
    
    self.centerImagv.image = DEF_IMAGE(@"播放按钮");
    
    
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


-(void)jieshu
{
    [player pause];
    
    BossSound2SucViewController *vc = [[BossSound2SucViewController alloc]init];
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
