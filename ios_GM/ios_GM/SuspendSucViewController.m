//
//  SuspendSucViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SuspendSucViewController.h"
#import "MainViewController.h"
#import "ReportViewController.h"

@interface SuspendSucViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}
@end

@implementation SuspendSucViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLb.text = @"底盘悬挂体验";
    self.carView.hidden = NO;
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(27), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(63), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(27*2), DEF_RESIZE_UI(348))];
    imagv.layer.cornerRadius = 5;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imagv];
    
    UIImageView *cardImagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(117), DEF_RESIZE_UI(118), DEF_RESIZE_UI(90), DEF_RESIZE_UI(40))];
    cardImagv.image = DEF_IMAGE(@"水杯2");
    cardImagv.contentMode = UIViewContentModeCenter;
    [imagv addSubview:cardImagv];
    
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(20, cardImagv.bottom + DEF_RESIZE_UI(12), imagv.width - 40, DEF_RESIZE_UI(100))];
    contentLb.textAlignment = NSTextAlignmentCenter;
    contentLb.textColor = [UIColor whiteColor];
    contentLb.numberOfLines = 4;
    contentLb.font = DEF_MyBoldFont(DEF_RESIZE_UI(18));
    [imagv addSubview:contentLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), imagv.bottom + DEF_RESIZE_UI(52), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"查看试驾报告" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = DEF_RESIZE_UI(48)/2;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    NSString *str;
    if ([self.score intValue] < 100) {
        str = [NSString stringWithFormat:@"即使颠簸路面仍能完美操控驾驶，水杯中的水还剩余%@%%",self.score];
    }else{
        str = @"即使百公里加速，也能做到滴水不洒！水杯中的水还剩余100%.";
    }
    if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"迈锐宝XL"]) {
        [self playav:@"试驾体验_4（迈锐宝XL）"];
        contentLb.text = [NSString stringWithFormat:@"全框式副车架，确保底盘刚性的同时，带来驾·无所限的动力和操控体验。%@",str];
        imagv.image = DEF_IMAGE(@"迈锐宝XL底盘");
        
    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"探界者"]){
        [self playav:@"试驾体验_2（探界者）"];
        contentLb.text = [NSString stringWithFormat:@"基于通用汽车全球平台，以优化的底盘结构、更富操控感的悬挂调校，表现出强大的驾控能力。%@",str];
        imagv.image = DEF_IMAGE(@"探界者底盘");
        
    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"迈锐宝"]){
        [self playav:@"试驾体验_5（迈锐宝）"];
        contentLb.text = [NSString stringWithFormat:@"美式运动底盘辅以CCI动态调校，搭配高效动能组合，为您带来完美平衡优化的操控体验。%@",str];
        imagv.image = DEF_IMAGE(@"迈锐宝XL底盘");
        
    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科鲁兹"]){
        [self playav:@"试驾体验_6（科鲁兹&科鲁兹两厢）"];
        contentLb.text = [NSString stringWithFormat:@"纽博格林赛道底盘调校，拥有WTCC三冠王荣耀，全框式副车架配合增强型瓦特连杆，带来超越期待的驾乘乐趣。%@",str];
        imagv.image = DEF_IMAGE(@"科鲁兹底盘");
        
    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科鲁兹两厢"]){
        [self playav:@"试驾体验_6（科鲁兹&科鲁兹两厢）"];
        contentLb.text = [NSString stringWithFormat:@"纽博格林赛道底盘调校，拥有WTCC三冠王荣耀，全框式副车架配合增强型瓦特连杆，带来超越期待的驾乘乐趣。%@",str];
        imagv.image = DEF_IMAGE(@"科鲁兹两厢底盘");
        
    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"科沃兹"]){
        [self playav:@"试驾体验_7（科沃兹）"];
        contentLb.text = [NSString stringWithFormat:@"美式运动底盘，加上家族式运动基因调校，为您带来更精准更稳健的驾驶体验。%@",str];
        imagv.image = DEF_IMAGE(@"科鲁兹底盘");
        
    }else if ([DEF_MyAppDelegate.carDic[@"name"] isEqualToString:@"创酷"]){
        [self playav:@"试驾体验_3（创酷）"];
        contentLb.text = [NSString stringWithFormat:@"采用运动化底盘调教，麦弗逊独立悬挂搭配EPS电子随速助力转向系统，带给您舒适的驾乘体验。%@",str];
        imagv.image = DEF_IMAGE(@"创酷底盘");
        
    }else{
        [self playav:@"试驾体验_3（创酷）"];
        contentLb.text = [NSString stringWithFormat:@"全框式副车架，确保底盘刚性的同时，带来驾·无所限的动力和操控体验。%@",str];
        imagv.image = DEF_IMAGE(@"迈锐宝XL底盘");
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
    [DEF_UserDefaults setObject:@"1" forKey:@"4444"];
    [player pause];

    ReportViewController *vc = [[ReportViewController alloc]init];
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
