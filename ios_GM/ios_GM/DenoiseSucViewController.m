//
//  DenoiseSucViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "DenoiseSucViewController.h"
#import "MainViewController.h"
@interface DenoiseSucViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}
@end

@implementation DenoiseSucViewController

-(void)dealloc
{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"降噪体验";
    self.carView.hidden = NO;
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(27), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(63), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(27*2), DEF_RESIZE_UI(348))];
    imagv.layer.cornerRadius = 5;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imagv];
    
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
    
    if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"迈瑞宝XL"]) {
        [self playav:@"降噪体验_5（迈锐宝XL）"];
        imagv.image = DEF_IMAGE(@"降噪迈锐宝XL");
        
    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"探界者"]){
        [self playav:@"降噪体验_4（探界者）"];
        imagv.image = DEF_IMAGE(@"降噪探界者");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"迈瑞宝"]){
        [self playav:@"降噪体验_7（迈锐宝）"];
        imagv.image = DEF_IMAGE(@"降噪迈锐宝");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科鲁兹"]){
        [self playav:@"降噪体验_8（科鲁兹&科鲁兹两厢）"];
        imagv.image = DEF_IMAGE(@"降噪科鲁兹");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科鲁兹两厢"]){
        [self playav:@"降噪体验_8（科鲁兹&科鲁兹两厢）"];
        imagv.image = DEF_IMAGE(@"降噪科鲁兹两厢");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科沃兹"]){
        [self playav:@"降噪体验_9（科沃兹）"];
        imagv.image = DEF_IMAGE(@"降噪科沃兹");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"创酷"]){
        [self playav:@"降噪体验_6（创酷）"];
        imagv.image = DEF_IMAGE(@"降噪创酷");

    }else{
        [self playav:@"降噪体验_6（创酷）"];
        imagv.image = DEF_IMAGE(@"降噪创酷");
    }
}

-(void)playav:(NSString *)str
{
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"wav"];
    // (2)把音频文件转化成url格式
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    player = [[AVPlayer alloc] initWithPlayerItem:item];
//    [player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(playFinished:)
//                                                 name:AVPlayerItemDidPlayToEndTimeNotification
//                                               object:player.currentItem];
    [player play];
}

//-(void)playFinished:(NSNotification *)obj
//{
//    [player pause];
//
//}
//
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"status"]) {
//        switch (player.status) {
//            case AVPlayerStatusUnknown:
//            {
//                NSLog(@"未知转态");
//            }
//                break;
//            case AVPlayerStatusReadyToPlay:
//            {
//                NSLog(@"准备播放");
//            }
//                break;
//            case AVPlayerStatusFailed:
//            {
//                NSLog(@"加载失败");
//            }
//                break;
//
//            default:
//                break;
//        }
//
//    }
//}


-(void)jieshu
{
    [DEF_UserDefaults setObject:@"1" forKey:@"3333"];
    
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
