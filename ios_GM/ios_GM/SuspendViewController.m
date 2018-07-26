//
//  SuspendViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SuspendViewController.h"
#import "SuspendBeginViewController.h"

@interface SuspendViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}
@end

@implementation SuspendViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"底盘悬挂体验";
    self.carView.hidden = NO;
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"pan"];
    animation.frame = CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(34), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(139));
    animation.centerX = self.view.centerX;
    animation.loopAnimation = YES;
    animation.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animation];
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, animation.bottom + DEF_RESIZE_UI(34), DEF_DEVICE_WIDTH, 25)];
    titleLb.font = DEF_MyBoldFont(24);
    titleLb.text = @"欢迎参加雪佛兰试驾";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = DEF_APP_MAIN_TITLECOLOR;
    [self.view addSubview:titleLb];
    
    UILabel *titleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLb.bottom + DEF_RESIZE_UI(11), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(100))];
    titleLb1.font = DEF_MyBoldFont(DEF_RESIZE_UI(16));
    titleLb1.text = @"画面中有盛满水的水杯\n洒水程度取决于\n您的驾驶情况哦！";
    titleLb1.textAlignment = NSTextAlignmentCenter;
    titleLb1.textColor = DEF_UICOLORFROMRGB(0x909090);
    titleLb1.numberOfLines = 3;
    [self.view addSubview:titleLb1];
    
    UIImageView *centerImagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleLb1.bottom + DEF_RESIZE_UI(12), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(54))];
    centerImagv1.image = DEF_IMAGE(@"水杯");
    centerImagv1.contentMode = UIViewContentModeScaleAspectFit;
    centerImagv1.centerX = self.view.centerX;
    [self.view addSubview:centerImagv1];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), centerImagv1.bottom + DEF_RESIZE_UI(56), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"立刻出发" forState:0];
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
    [btn setTitleColor:[UIColor redColor] forState:0];
    btn.titleLabel.font = DEF_MyFont(14);
    [btn setImage:DEF_IMAGE(@"提示") forState:0];
    btn.centerX = self.view.centerX;
    [self.view addSubview:btn];
    
    [self playav];
    
}

-(void)playav
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"试驾体验_1 准备出发" ofType:@"wav"];
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

-(void)kaishi
{
    [player pause];
    
    SuspendBeginViewController *vc = [[SuspendBeginViewController alloc]init];
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
