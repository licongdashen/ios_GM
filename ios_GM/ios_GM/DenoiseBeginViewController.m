//
//  DenoiseBeginViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/12.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "DenoiseBeginViewController.h"
#import "DecibelMeterHelper.h"
#import "DenoiseSucViewController.h"

#define TIME 120


@interface DenoiseBeginViewController ()<AVAudioPlayerDelegate>
{
    AVPlayer *player;
}

@property (nonatomic) dispatch_source_t timer;
@property (nonatomic) CAShapeLayer*progressLayer;
@property int count;

@property int time;

@property (nonatomic, strong) DecibelMeterHelper           *dbHelper;

@property (nonatomic, weak) UIButton *loginBtn;

@property BOOL isFrist;

@property (nonatomic, weak)UILabel *titleLb1;

@property (nonatomic, weak) NSString *first;
@property (nonatomic, weak) NSString *second;

@end

@implementation DenoiseBeginViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.dbHelper stopMeasuring];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFrist = YES;
    
    self.time = 5;
    
    self.titleLb.text = @"降噪体验";
    self.carView.hidden = NO;
    
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_RESIZE_UI(262), DEF_RESIZE_UI(262))];
    centerView.center = CGPointMake(self.view.centerX, DEF_RESIZE_UI(92) + DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(131));
    centerView.backgroundColor = DEF_RGB(134, 134, 134);
    centerView.layer.cornerRadius = DEF_RESIZE_UI(262)/2;
    [self.view addSubview:centerView];
    
    UILabel *dbLb = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(52), centerView.width, DEF_RESIZE_UI(111))];
    dbLb.font = DEF_MyBoldFont(DEF_RESIZE_UI(110));
    dbLb.adjustsFontSizeToFitWidth = YES;
    dbLb.textColor = [UIColor whiteColor];
    dbLb.textAlignment = NSTextAlignmentCenter;
    [centerView addSubview:dbLb];
    
    UILabel *dbLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(48), centerView.width - DEF_RESIZE_UI(30), 25)];
    dbLb1.textColor = [UIColor whiteColor];
    dbLb1.textAlignment = NSTextAlignmentRight;
    dbLb1.text = @"db";
    dbLb1.font = DEF_MyBoldFont(24);
    [centerView addSubview:dbLb1];
    
    UIBezierPath* progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.centerX, DEF_RESIZE_UI(92) + DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(131)) radius:DEF_RESIZE_UI(131) startAngle: - M_PI/2 - M_PI/2 endAngle:M_PI/2 + M_PI/2 clockwise:YES];
    self.progressLayer = [CAShapeLayer new];
    [self.view.layer addSublayer:self.progressLayer];
    self.progressLayer.fillColor = nil;
    self.progressLayer.strokeColor = DEF_UICOLORFROMRGB(0xffbe17).CGColor;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.path = progressPath.CGPath;
    self.progressLayer.lineWidth = 10;
    self.progressLayer.frame = self.view.bounds;
    
    self.dbHelper = [[DecibelMeterHelper alloc]init];
    __weak typeof(self) weakSelf = self;
    self.dbHelper.decibelMeterBlock = ^(double dbSPL){
        
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"ccccc%@",[NSString stringWithFormat:@"%.2lf",dbSPL]);
            strongSelf.count =  TIME - (int)dbSPL;
            UIBezierPath* progressPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(strongSelf.view.center.x, DEF_RESIZE_UI(92) + DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(131)) radius:DEF_RESIZE_UI(131) startAngle: - M_PI/2 - M_PI/2 endAngle:-M_PI/2 + (M_PI*(TIME-strongSelf.count)/(TIME/2)) - M_PI/2 clockwise:YES];
            strongSelf.progressLayer.path = progressPath.CGPath;
            
            dbLb.text = [NSString stringWithFormat:@"%d",(int)dbSPL];
            
            if (strongSelf.isFrist == YES) {
                strongSelf.first = [NSString stringWithFormat:@"%d",(int)dbSPL];
            }else{
                strongSelf.second = [NSString stringWithFormat:@"%d",(int)dbSPL];
            }
        });
        
    };
    [self.dbHelper startMeasuringWithIsSaveVoice:NO];

    UILabel *titleLb1 = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(404), DEF_DEVICE_WIDTH, 17 + 25)];
    titleLb1.font = DEF_MyFont(16);
    titleLb1.textAlignment = NSTextAlignmentCenter;
    titleLb1.numberOfLines = 2;
    titleLb1.textColor = DEF_UICOLORFROMRGB(0x848484);
    [self.view addSubview:titleLb1];
    self.titleLb1 = titleLb1;
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), titleLb1.bottom + DEF_RESIZE_UI(16), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"再次测试" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(kaishi) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    self.loginBtn.enabled = NO;
    
    [self startCountDown];
}

-(void)playav:(NSString *)str{
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"wav"];
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
    if (self.isFrist == YES) {
        [player pause];
        self.time = 5;
        [self.dbHelper startMeasuringWithIsSaveVoice:NO];
        [self startCountDown];
        [self.loginBtn setTitle:@"结束测试" forState:0];
        self.titleLb1.text = @"";
        self.isFrist = NO;
        self.loginBtn.enabled = NO;
    }else{
        [player pause];
        
        DenoiseSucViewController *vc = [[DenoiseSucViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
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
            if (self.time == 0) {

                [self.dbHelper stopMeasuring];
                
                if (self.isFrist == YES) {
                    self.titleLb1.text = @"当前环境较为嘈杂\n现在请关闭车窗再次测试";
                    [self playav:@"降噪体验_2 再次测试"];

                }else{
                    int db = [self.first intValue] - [self.second intValue];
                    self.titleLb1.text = [NSString stringWithFormat:@"当前分贝比开窗时降低了%d\n您当前身处静谧的空间内",db];
                    [self playav:@"降噪体验_3 结束测试"];
                }

                self.loginBtn.enabled = YES;
                dispatch_source_cancel(self.timer);
            }else{
                self.time --;
            }
        });
    });
    dispatch_resume(self.timer);
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
