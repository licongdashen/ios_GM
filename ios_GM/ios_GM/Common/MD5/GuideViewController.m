//
//  GuideViewController.m
//  chaoaicai
//
//  Created by Queen on 15/6/29.
//  Copyright (c) 2015年 WFX. All rights reserved.
//

#import "GuideViewController.h"

#define MAX_LENGTH  3

@interface GuideViewController () <UIScrollViewDelegate>

// 引导视图
@property (nonatomic, weak) UIScrollView *scrollView;

// 立即体验按钮
@property (nonatomic, weak) UIButton *finishBtn;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    // 引导视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(DEF_DEVICE_WIDTH * MAX_LENGTH, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    for (int i=0; i<MAX_LENGTH; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * DEF_DEVICE_WIDTH, 0, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        NSString *imageName = nil;
        imageName = [NSString stringWithFormat:@"启动copy%d", i + 2];
        imageView.image = [UIImage imageNamed:imageName];
    }

    // 立即体验按钮
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:finishBtn];
    self.finishBtn = finishBtn;
    finishBtn.size = CGSizeMake(DEF_DEVICE_WIDTH, DEF_RESIZE_UI(120));
    finishBtn.bottom = DEF_DEVICE_HEIGHT - DEF_RESIZE_UI(20);

    finishBtn.centerX = scrollView.centerX;
    finishBtn.layer.cornerRadius = finishBtn.height * 0.5;
    finishBtn.backgroundColor = [UIColor clearColor];
    finishBtn.hidden = YES;
    [finishBtn addTarget:self action:@selector(introDidFinish:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - EAIntroDelegate
- (void)introDidFinish:(UIButton *)introView
{
    [CACVersionUpdateKit saveCurrentVersion];
    
    [DEF_MyAppDelegate loadingHomeController];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = 10;
    NSInteger count = (int)((scrollView.contentOffset.x + offset) / DEF_DEVICE_WIDTH);
    self.finishBtn.hidden = !(count == (MAX_LENGTH - 1));
}


@end
