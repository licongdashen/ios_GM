//
//  CACProgressHUD.m
//  cacbos
//
//  Created by Apple on 2017/10/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "CACProgressHUD.h"

@interface CACProgressHUD () <MBProgressHUDDelegate>

@end

@implementation CACProgressHUD

#pragma mark -

+ (instancetype)shareInstance
{
    static CACProgressHUD *_instance = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance;
}

#pragma mark -
- (MBProgressHUD *)showProgressHUDInView:(UIView *)view
{
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.delegate = self;
    //    HUD.mode = MBProgressHUDModeIndeterminate;
    [view addSubview:HUD];
    
    //自定义loading动画
    NSMutableArray *aniImages = [NSMutableArray array];
    for (int i = 1; i<= 50; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_%d",i]];
        [aniImages addObject:image];
    }
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.bounds = CGRectMake(0, 0, 55, 25);
    imgView.animationDuration = 1.2;
    imgView.animationRepeatCount = 0;
    imgView.animationImages = aniImages;
    [imgView startAnimating];
    
    HUD.customView = imgView;
    HUD.bezelView.color = [UIColor clearColor];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.text = @"加载中...";
    HUD.label.textColor = DEF_UICOLORFROMRGB(0xcccccc);
    HUD.label.font = Normal_Font(14.0);
    
    [HUD showAnimated:YES];
    
    return HUD;
}

- (void)removeProgressHUD:(MBProgressHUD *)hud
{
    [hud hideAnimated:NO];
}

- (void)showHUDWithText:(NSString *)text inView:(UIView *)view deley:(NSTimeInterval)time
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.detailsLabel.text = text;
    HUD.margin = 20.0;
    HUD.removeFromSuperViewOnHide = YES;
    
    [HUD hideAnimated:YES afterDelay:DEF_ERROR_MESSAGE_SHOW_TIME];
}

+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg
{
    if (!_targetView) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:_targetView];
        progressHUD.mode = MBProgressHUDModeIndeterminate;
        [progressHUD showAnimated:YES];
        progressHUD.label.text = _msg;
        [_targetView addSubview:progressHUD];
    });
}

+ (void)hideMBProgress:(UIView*)_targetView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:_targetView animated:YES];
    });
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

@end
