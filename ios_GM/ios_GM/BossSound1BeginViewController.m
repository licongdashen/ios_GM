//
//  BossSound1BeginViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BossSound1BeginViewController.h"
#import "BossSound1SucViewController.h"

@interface BossSound1BeginViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}

@property (nonatomic, weak)UIImageView *centerImagv;
@property (nonatomic, weak)UIImageView *zhengqueImagv;
@property (nonatomic, weak)UIImageView *zhengqueImagv1;
@property (nonatomic, weak)UIImageView *zhengqueImagv2;
@property (nonatomic, weak)UIButton *loginBtn11;
@property (nonatomic, weak)UILabel *errLb;
@property (nonatomic, weak)LOTAnimationView *animation;

@end

@implementation BossSound1BeginViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [player pause];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"真实音效体验";
    self.carView.hidden = NO;
    
    UIImageView *centerImagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.carView.bottom + 12, DEF_RESIZE_UI(282), DEF_RESIZE_UI(282))];
    centerImagv.image = DEF_IMAGE(@"播放按钮");
    centerImagv.contentMode = UIViewContentModeCenter;
    centerImagv.centerX = self.view.centerX;
    centerImagv.userInteractionEnabled = YES;
    [self.view addSubview:centerImagv];
    self.centerImagv = centerImagv;
    self.centerImagv.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        self.centerImagv.hidden = YES;
        self.animation.hidden = NO;
        [self playav];
    }];
    [centerImagv addGestureRecognizer:tap];
    
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"play"];
    animation.frame = CGRectMake(0, self.carView.bottom + 12, DEF_RESIZE_UI(282), DEF_RESIZE_UI(282));
    animation.centerX = self.view.centerX;
    animation.loopAnimation = YES;
    animation.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animation];
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
    self.animation = animation;
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, centerImagv.bottom + DEF_RESIZE_UI(10), DEF_DEVICE_WIDTH, 17)];
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"请选择您听到的声音";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = DEF_UICOLORFROMRGB(0x848484);
    [self.view addSubview:titleLb];
    
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(11), titleLb.bottom + DEF_RESIZE_UI(15), DEF_RESIZE_UI(112), DEF_RESIZE_UI(136))];
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(kaishi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(30), DEF_RESIZE_UI(29), DEF_RESIZE_UI(52), DEF_RESIZE_UI(52))];
    imagv.image = DEF_IMAGE(@"Group666");
    [loginBtn addSubview:imagv];
    
    UIImageView *zhengqueImagv = [[UIImageView alloc]initWithFrame:CGRectMake(imagv.width - 5, 0, 20, 20)];
    zhengqueImagv.image = DEF_IMAGE(@"正确");
    [imagv addSubview:zhengqueImagv];
    zhengqueImagv.hidden = YES;
    self.zhengqueImagv = zhengqueImagv;
    
    UILabel *titeLb = [[UILabel alloc]initWithFrame:CGRectMake(0, imagv.bottom + DEF_RESIZE_UI(22), loginBtn.width, 15)];
    titeLb.text = @"翻滚的海浪";
    titeLb.textAlignment = NSTextAlignmentCenter;
    titeLb.font = DEF_MyFont(14);
    titeLb.textColor = DEF_APP_MAIN_TITLECOLOR;
    [loginBtn addSubview:titeLb];
    
    UIButton *loginBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(loginBtn.right + DEF_RESIZE_UI(8), titleLb.bottom + DEF_RESIZE_UI(15), DEF_RESIZE_UI(112), DEF_RESIZE_UI(136))];
    loginBtn1.layer.cornerRadius = 8;
    loginBtn1.layer.masksToBounds = YES;
    [loginBtn1 addTarget:self action:@selector(kaishi1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn1];
    
    UIImageView *imagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(30), DEF_RESIZE_UI(29), DEF_RESIZE_UI(52), DEF_RESIZE_UI(52))];
    imagv1.image = DEF_IMAGE(@"风");
    [loginBtn1 addSubview:imagv1];
    
    UIImageView *zhengqueImagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(imagv1.width - 5, 0, 20, 20)];
    zhengqueImagv1.image = DEF_IMAGE(@"错误");
    [imagv1 addSubview:zhengqueImagv1];
    zhengqueImagv1.hidden = YES;
    self.zhengqueImagv1 = zhengqueImagv1;
    
    UILabel *titeLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, imagv1.bottom + DEF_RESIZE_UI(22), loginBtn.width, 15)];
    titeLb1.text = @"呼啸的风声";
    titeLb1.textAlignment = NSTextAlignmentCenter;
    titeLb1.font = DEF_MyFont(14);
    titeLb1.textColor = DEF_APP_MAIN_TITLECOLOR;
    [loginBtn1 addSubview:titeLb1];
    
    UIButton *loginBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(loginBtn1.right +  DEF_RESIZE_UI(8), titleLb.bottom + DEF_RESIZE_UI(15), DEF_RESIZE_UI(112), DEF_RESIZE_UI(136))];
    loginBtn2.layer.cornerRadius = 8;
    loginBtn2.layer.masksToBounds = YES;
    [loginBtn2 addTarget:self action:@selector(kaishi2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn2];
    
    UIImageView *imagv2 = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(30), DEF_RESIZE_UI(29), DEF_RESIZE_UI(52), DEF_RESIZE_UI(52))];
    imagv2.image = DEF_IMAGE(@"Combined Shape");
    [loginBtn2 addSubview:imagv2];
    
    UIImageView *zhengqueImagv2 = [[UIImageView alloc]initWithFrame:CGRectMake(imagv2.width - 5, 0, 20, 20)];
    zhengqueImagv2.image = DEF_IMAGE(@"错误");
    [imagv2 addSubview:zhengqueImagv2];
    zhengqueImagv2.hidden = YES;
    self.zhengqueImagv2 = zhengqueImagv2;
    
    UILabel *titeLb2 = [[UILabel alloc]initWithFrame:CGRectMake(0, imagv2.bottom + DEF_RESIZE_UI(22), loginBtn.width, 15)];
    titeLb2.text = @"涌动的岩浆";
    titeLb2.textAlignment = NSTextAlignmentCenter;
    titeLb2.font = DEF_MyFont(14);
    titeLb2.textColor = DEF_APP_MAIN_TITLECOLOR;
    [loginBtn2 addSubview:titeLb2];
    
    UILabel *errLb = [[UILabel alloc]initWithFrame:CGRectMake(0, centerImagv.bottom + DEF_RESIZE_UI(205 - 25), DEF_DEVICE_WIDTH, 15)];
    errLb.font = DEF_MyFont(14);
    errLb.textColor = DEF_UICOLORFROMRGB(0xff5353);
    errLb.text = @"再想一想，重新选择";
    errLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:errLb];
    self.errLb = errLb;
    self.errLb.hidden = YES;
    
    UIButton *loginBtn11 = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), centerImagv.bottom + DEF_RESIZE_UI(205), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn11 setTitle:@"提交答案" forState:0];
    [loginBtn11 setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn11.titleLabel.font = DEF_MyFont(22);
    loginBtn11.layer.cornerRadius = DEF_RESIZE_UI(8);
    loginBtn11.layer.masksToBounds = YES;
    [loginBtn11 addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    loginBtn11.centerX = self.view.centerX;
    loginBtn11.backgroundColor = DEF_IMAGE_BACKGROUND_COLOR;
    loginBtn11.enabled = NO;
    [self.view addSubview:loginBtn11];
    self.loginBtn11 = loginBtn11;

    [self playav];
}


-(void)kaishi
{
    self.loginBtn11.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    self.loginBtn11.enabled = YES;
    
    self.zhengqueImagv.hidden = NO;
    self.zhengqueImagv1.hidden = YES;
    self.zhengqueImagv2.hidden = YES;
    
    self.errLb.hidden = YES;
}

-(void)kaishi1
{
    self.loginBtn11.backgroundColor = DEF_IMAGE_BACKGROUND_COLOR;
    self.loginBtn11.enabled = NO;
    
    self.zhengqueImagv.hidden = YES;
    self.zhengqueImagv1.hidden = NO;
    self.zhengqueImagv2.hidden = YES;
    
    self.errLb.hidden = NO;
}

-(void)kaishi2
{
    self.loginBtn11.backgroundColor = DEF_IMAGE_BACKGROUND_COLOR;
    self.loginBtn11.enabled = NO;
    
    self.zhengqueImagv.hidden = YES;
    self.zhengqueImagv1.hidden = YES;
    self.zhengqueImagv2.hidden = NO;
    
    self.errLb.hidden = NO;
}


-(void)playav
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"真实音效 海浪_15s" ofType:@"mp3"];
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
    self.centerImagv.hidden = NO;
    self.animation.hidden = YES;
}

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
    [player pause];
    
    BossSound1SucViewController *vc = [[BossSound1SucViewController alloc]init];
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
