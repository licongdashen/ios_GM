//
//  UIImage+Color.m
//  cacwallte
//
//  Created by King on 17/4/26.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+ (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)shotImageFromView:(UIView*)view
{
    // 1. 开启图形上下文
    UIGraphicsBeginImageContextWithOptions(view.size, NO
                                           , 1.0);
    // 2. 将手势解锁缩略图渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    // 3. 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 4. 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)shotImageFromImage:(UIImage*)image desRect:(CGRect)desImageRect
{
    // 1.获取源图片的CGImage
    CGImageRef srcImageRef = image.CGImage;
    // 2.获取一张子图片
    CGImageRef subImageRef = CGImageCreateWithImageInRect(srcImageRef, desImageRect);
    // 3.开启图形上下文
    UIGraphicsBeginImageContext(desImageRect.size);
    // 4.获取当前上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 5.绘制新图片
    CGContextDrawImage(context, desImageRect, subImageRef);
    // 6.获取新图片
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    // 7.关闭上下文
    UIGraphicsEndImageContext();
    
    return smallImage;
}

+ (UIImage*)resizeImageWithImage:(UIImage*)image
{
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = top;
    CGFloat right = left;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
}

@end

