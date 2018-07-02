//
//  CACProgressHUD.h
//  cacbos
//
//  Created by Apple on 2017/10/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface CACProgressHUD : NSObject

+ (instancetype)shareInstance;

- (MBProgressHUD *)showProgressHUDInView:(UIView *)view;

- (void)removeProgressHUD:(MBProgressHUD *)hud;

- (void)showHUDWithText:(NSString *)text  inView:(UIView *)view deley:(NSTimeInterval)time;

/**
 *  风火轮
 *
 *  @param _targetView 显示提示框的视图
 *  @param _msg 内容
 */
+ (void)showMBProgress:(UIView *)_targetView message:(NSString *)_msg;

//隐藏风火轮
+ (void)hideMBProgress:(UIView*)_targetView;

@end
