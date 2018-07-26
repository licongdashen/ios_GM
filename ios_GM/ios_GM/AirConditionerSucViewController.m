//
//  AirConditionerSucViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AirConditionerSucViewController.h"
#import "MainViewController.h"

@interface AirConditionerSucViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}
@end

@implementation AirConditionerSucViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"空调体验";
    self.carView.hidden = NO;
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(27), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(63), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(27*2), DEF_RESIZE_UI(348))];
    imagv.layer.cornerRadius = 5;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imagv];
    
    UIImageView *cardImagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(117), DEF_RESIZE_UI(118), DEF_RESIZE_UI(90), DEF_RESIZE_UI(40))];
    cardImagv.image = DEF_IMAGE(@"汽车");
    cardImagv.contentMode = UIViewContentModeCenter;
    [imagv addSubview:cardImagv];
    
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(20, cardImagv.bottom + DEF_RESIZE_UI(12), imagv.width - 40, DEF_RESIZE_UI(100))];
    contentLb.textAlignment = NSTextAlignmentCenter;
    contentLb.textColor = [UIColor whiteColor];
    contentLb.numberOfLines = 4;
    contentLb.font = DEF_MyBoldFont(DEF_RESIZE_UI(18));
    [imagv addSubview:contentLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), imagv.bottom + DEF_RESIZE_UI(52), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"体验其他项目" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = DEF_RESIZE_UI(48)/2;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"迈锐宝XL"]) {
        [self playav:@"空调体验_3（探界者&迈锐宝XL）"];
        contentLb.text = @"双区控温与后排出风口，轻轻一扭制冷热;同时为了您的呼吸健康，我们配备了PM2.5过滤系统";
        imagv.image = DEF_IMAGE(@"shutterstock_774468421");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"探界者"]){
        [self playav:@"空调体验_3（探界者&迈锐宝XL）"];
        contentLb.text = @"双区控温与后排出风口，轻轻一扭制冷热;同时为了您的呼吸健康，我们配备了PM2.5过滤系统";
        imagv.image = DEF_IMAGE(@"shutterstock_774468421");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"迈锐宝"]){
        [self playav:@"空调体验_5（迈锐宝）"];
        contentLb.text = @"双区控温与后排出风口，轻轻一扭制冷热";
        imagv.image = DEF_IMAGE(@"shutterstock_774468421");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科鲁兹"]){
        [self playav:@"空调体验_6（科鲁兹&科鲁兹两厢）"];
        contentLb.text = @"双区控温与后排出风口，轻轻一扭制冷热";
        imagv.image = DEF_IMAGE(@"shutterstock_774468421");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科鲁兹两厢"]){
        [self playav:@"空调体验_6（科鲁兹&科鲁兹两厢）"];
        contentLb.text = @"双区控温与后排出风口，轻轻一扭制冷热";
        imagv.image = DEF_IMAGE(@"shutterstock_774468421");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科沃兹"]){
        [self playav:@"空调体验_7（科沃兹）"];
        contentLb.text = @"强劲的空调系统，快速制冷热，体贴您的冷暖；为了让您呼吸更健康的空气，我们配备了PM2.5过滤系统。";
        imagv.image = DEF_IMAGE(@"shutterstock_774468421");

    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"创酷"]){
        [self playav:@"空调体验_4（创酷）"];
        contentLb.text = @"我有多快，营造冷暖空间的速度就有多快";
        imagv.image = DEF_IMAGE(@"shutterstock_774468421");

    }else{
        [self playav:@"空调体验_4（创酷）"];
        contentLb.text = @"我有多快，营造冷暖空间的速度就有多快";
        imagv.image = DEF_IMAGE(@"汽车");
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
    [DEF_UserDefaults setObject:@"1" forKey:@"2222"];
    
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
