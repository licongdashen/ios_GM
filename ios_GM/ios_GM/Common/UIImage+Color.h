//
//  UIImage+Color.h
//  cacwallte
//
//  Created by King on 17/4/26.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage*)createImageWithColor:(UIColor*)color;

/**
 *  获取view截图
 *
 *  @param view 被截图的view
 *
 *  @return 返回图片
 */
+ (UIImage *)shotImageFromView:(UIView*)view;

/**
 *  根据给定的图片截图目标图片
 *
 *  @param image        被截的图片
 *  @param desImageRect 目标区域
 *
 *  @return 截出的新图片
 */
+ (UIImage *)shotImageFromImage:(UIImage*)image desRect:(CGRect)desImageRect;
/**
 *  跳转图片大小，从中心点跳转尺寸
 *
 *  @param image 要跳转的图片
 *
 *  @return 新图片
 */
+ (UIImage*)resizeImageWithImage:(UIImage*)image;

@end

