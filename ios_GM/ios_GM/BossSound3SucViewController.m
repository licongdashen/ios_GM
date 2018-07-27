//
//  BossSound3SucViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BossSound3SucViewController.h"
#import "MainViewController.h"

@interface BossSound3SucViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}
@end

@implementation BossSound3SucViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"高低音效体验";
    self.carView.hidden = NO;
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(27), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(63), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(27*2), DEF_RESIZE_UI(348))];
    imagv.image = DEF_IMAGE(@"非bose");
    imagv.layer.cornerRadius = 5;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imagv];
    
    UIImageView *cardImagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(117), DEF_RESIZE_UI(118), DEF_RESIZE_UI(90), DEF_RESIZE_UI(40))];
    cardImagv.image = DEF_IMAGE(@"汽车");
    cardImagv.contentMode = UIViewContentModeCenter;
    [imagv addSubview:cardImagv];
    
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(0, cardImagv.bottom + DEF_RESIZE_UI(12), imagv.width, DEF_RESIZE_UI(84))];
    contentLb.textAlignment = NSTextAlignmentCenter;
    contentLb.textColor = [UIColor whiteColor];
    contentLb.numberOfLines = 3;
    contentLb.font = DEF_MyBoldFont(DEF_RESIZE_UI(18));
    contentLb.text = @"您可手动调节BOSE音响的\n高，中，低音\n让耳朵去找到您最舒适的那个声音";
    [imagv addSubview:contentLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), imagv.bottom + DEF_RESIZE_UI(52), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"体验其他项目" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = DEF_RESIZE_UI(8);
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    [self playav];
}

-(void)playav
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BOSE_9 高低音效 结束" ofType:@"wav"];
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


-(void)jieshu
{
    [DEF_UserDefaults setObject:@"1" forKey:@"1114"];
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MainViewController class]]) {
            [player pause];
            [self.navigationController popToViewController:vc animated:YES];
            return;
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
