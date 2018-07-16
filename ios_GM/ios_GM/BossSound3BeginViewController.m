//
//  BossSound3BeginViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/11.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BossSound3BeginViewController.h"
#import "BossSound3SucViewController.h"

@interface BossSound3BeginViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, weak)UIView *backView1;
@property (nonatomic, weak)UIView *backView2;
@property (nonatomic, strong) NSArray *imagvArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *musicArr;
@property (nonatomic, strong) NSMutableArray *musicArr1;

@property (nonatomic, weak) UILabel *titleLb1;
@property (nonatomic, weak) UIImageView *musicImagv;
@property int count;
@property (nonatomic) dispatch_source_t timer;
@property (nonatomic, strong)AVPlayer *player;
@property (nonatomic, strong)UISlider *progress;
@property id timeObserve;

@end

@implementation BossSound3BeginViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    if (self.timeObserve) {
        [self.player removeTimeObserver:self.timeObserve];
        self.timeObserve = nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagvArr = @[@"玛丽莲凯丽",@"阿黛尔",@"惠妮休斯顿"];
    self.titleArr = @[@"Hero",@"Someone Like You",@"I Will Always Love You"];
    self.musicArr = @[@"Mariah+Carey+-+Hero",@"Adele（阿黛尔）+-+Someone+Like+You",@"I Will Always Love You"];
    self.musicArr1 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 201; i ++) {
        [self.musicArr1 addObject:DEF_IMAGE([NSString stringWithFormat:@"合成 1_00%d"])];
    }
    self.titleLb.text = @"高低音效体验";
    self.carView.hidden = NO;
    
    UIView *backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(75), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(463))];
    [self.view addSubview:backView1];
    self.backView1 = backView1;
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0,DEF_RESIZE_UI(75), DEF_DEVICE_WIDTH, 17 + 25)];
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"任意选择一首歌曲播放\n感受bose音响的高低音效";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.numberOfLines = 2;
    titleLb.textColor = DEF_UICOLORFROMRGB(0x848484);
    [backView1 addSubview:titleLb];
    
    UIScrollView *scro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleLb.bottom + DEF_RESIZE_UI(26), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(180 + 80))];
    scro.contentSize = CGSizeMake(DEF_RESIZE_UI(190)*3, DEF_RESIZE_UI(180 + 80));
    [backView1 addSubview:scro];
    
    int x = 0;
    for (int i = 0; i < 3; i++) {
        UIButton *musicbtn = [[UIButton alloc]initWithFrame:CGRectMake(x, 0, DEF_RESIZE_UI(180), DEF_RESIZE_UI(180))];
        musicbtn.layer.cornerRadius = 4;
        musicbtn.layer.masksToBounds = YES;
        [musicbtn setImage:DEF_IMAGE(self.imagvArr[i]) forState:0];
        musicbtn.tag = 200 + i;
        [musicbtn addTarget:self action:@selector(kaishi:) forControlEvents:UIControlEventTouchUpInside];
        [scro addSubview:musicbtn];
        
        UIImageView *kaishiImagv = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0, DEF_RESIZE_UI(50), DEF_RESIZE_UI(50))];
        kaishiImagv.center = musicbtn.center;
        kaishiImagv.image = DEF_IMAGE(@"播放按钮");
        [scro addSubview:kaishiImagv];
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(x, musicbtn.bottom, DEF_RESIZE_UI(180), DEF_RESIZE_UI(80))];
        titleLb.font = DEF_MyFont(14);
        titleLb.textColor = DEF_UICOLORFROMRGB(0x848484);
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.text = self.titleArr[i];
        [scro addSubview:titleLb];

        x += DEF_RESIZE_UI(190);
        
    }
    
    UIView *backView2 = [[UIView alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(75), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(463))];
    backView2.hidden = YES;
    [self.view addSubview:backView2];
    self.backView2 = backView2;
    
    UILabel *titleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(69), DEF_DEVICE_WIDTH, 15)];
    titleLb1.font = DEF_MyFont(14);
    titleLb1.textColor = DEF_UICOLORFROMRGB(0x848484);
    titleLb1.textAlignment = NSTextAlignmentCenter;
    [backView2 addSubview:titleLb1];
    self.titleLb1 = titleLb1;
    
    UIImageView *musicImagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleLb1.bottom + DEF_RESIZE_UI(10), DEF_RESIZE_UI(270), DEF_RESIZE_UI(270))];
    musicImagv.layer.cornerRadius = 6;
    musicImagv.layer.masksToBounds = YES;
    musicImagv.centerX = self.view.centerX;
    [backView2 addSubview:musicImagv];
    self.musicImagv = musicImagv;

    UIImageView *musicImagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, titleLb1.bottom + DEF_RESIZE_UI(10), DEF_RESIZE_UI(270), DEF_RESIZE_UI(270))];
    musicImagv1.centerX = self.view.centerX;
    musicImagv1.contentMode = UIViewContentModeCenter;
//    musicImagv1.animationImages =
    [backView2 addSubview:musicImagv1]
    
    UIButton *nexBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(74), musicImagv.bottom + DEF_RESIZE_UI(24), 16, 16)];
    [nexBtn setImage:DEF_IMAGE(@"切歌") forState:0];
    [nexBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [backView2 addSubview:nexBtn];

    self.progress = [[UISlider alloc]initWithFrame:CGRectMake(nexBtn.right + DEF_RESIZE_UI(20), musicImagv.bottom + DEF_RESIZE_UI(25), DEF_RESIZE_UI(200), 20)];
    self.progress.minimumValue = 0.0;//下限
    self.progress.maximumValue = 1;//上限
    [self.progress addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.progress.continuous = NO;//当放开手., 值才确定下来
    self.progress.minimumTrackTintColor = DEF_UICOLORFROMRGB(0xffbe17);
    [backView2 addSubview:self.progress ];
    
    
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
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, loginBtn.bottom + DEF_RESIZE_UI(28), 268, 20)];
    [btn setTitle:@"请使用蓝牙或数据线连接车载音响" forState:0];
    [btn setTitleColor:DEF_UICOLORFROMRGB(0x898989) forState:0];
    btn.titleLabel.font = DEF_MyFont(14);
    [btn setImage:DEF_IMAGE(@"蓝牙") forState:0];
    btn.centerX = self.view.centerX;
    [self.view addSubview:btn];
    
}

-(void)jieshu
{
    [self.player pause];
    
    BossSound3SucViewController *vc = [[BossSound3SucViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)sliderValueChanged:(UISlider *)paramSender{
    if ([paramSender isEqual:self.progress]) {
        NSLog(@"New value=%f",paramSender.value);
        
        float time = CMTimeGetSeconds(self.player.currentItem.duration)*paramSender.value;
        CMTime changedTime = CMTimeMakeWithSeconds(time, 1.0);
        
        [self.player seekToTime:changedTime];
        
    }
}

-(void)playAv:(int)index;
{
    NSString *path = [[NSBundle mainBundle] pathForResource:self.titleArr[index] ofType:@"mp3"];
    // (2)把音频文件转化成url格式
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playFinished:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
    [self.player play];
    
    
//    @weakify(self);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),0.1*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(self.timer, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            @strongify(self);
//            self.progress.value = CMTimeGetSeconds(self.player.currentItem.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
//        });
//    });
//    dispatch_resume(self.timer);
    
    @weakify(self);
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        @strongify(self);
        self.progress.value = CMTimeGetSeconds(self.player.currentItem.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
    }];
    
    
}

-(void)playFinished:(NSNotification *)obj
{
    [self.player pause];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
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

-(void)next
{
    self.count ++;

    if (self.count == 3) {
        self.count = 0;
    }
    [self updataUI:self.count];

}

-(void)updataUI:(int)index;
{
    self.titleLb1.text = self.titleArr[index];
    self.musicImagv.image = DEF_IMAGE(self.imagvArr[index]);
    
    [self playAv:index];
    
}

-(void)kaishi:(UIButton *)sender
{
    self.backView1.hidden = YES;
    self.backView2.hidden = NO;

    self.count = (int)(sender.tag - 200);
    
    [self updataUI:(int)(sender.tag - 200)];
    
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
