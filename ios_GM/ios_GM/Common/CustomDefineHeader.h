//
//  CustomDefineHeader.h
//  cacwallet
//
//  Created by Queen on 2017/4/19.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "UIImage+Color.h"

#ifndef CustomDefineHeader_h
#define CustomDefineHeader_h

//Debug模式下打印日志,当前行,函数名
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

/**
 *适配
 */
#define DEF_RESIZE_UI(float)                   ((float)/375.0f*DEF_DEVICE_WIDTH)
#define DEF_RESIZE_UI_Landscape(float)         ((float)/375.0f*DEF_DEVICE_HEIGHT)
#define DEF_RESIZE_UI_Portrait(float)         ((float)/667.0f*DEF_DEVICE_HEIGHT)

#define DEF_RESIZE_FRAME(frame)      CGRectMake(DEF_RESIZE_UI (frame.origin.x), DEF_RESIZE_UI (frame.origin.y), DEF_RESIZE_UI (frame.size.width), DEF_RESIZE_UI (frame.size.height))
#define DEF_AGAINST_RESIZE_UI(float) (float/DEF_DEVICE_WIDTH*320)

/**
 *创建controller
 */
#define DEF_VIEW_CONTROLLER_INIT(controllerName) [[NSClassFromString(controllerName) alloc] init]

/**
 *推controller
 */
#define DEF_PUSH_VIEW_CONTROLLER(name)          UIViewController *vc = DEF_VIEW_CONTROLLER_INIT(name); [DEF_MyAppDelegate.mainNav pushViewController:vc animated:YES];
#define DEF_PUSH_VIEW_CONTROLLER_WITH_XIB(name) UIViewController *vc = DEF_VIEW_CONTROLLER_INIT_WITH_XIB(name); [DEF_MyAppDelegate.mainNav pushViewController:vc animated:YES];

/**
 *字符串去左右空格
 */
#define DEF_DROP_WHITESPACE(x) [x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

//字体大小
#define HelveticaNeue_Font(_size)   [UIFont systemFontOfSize:_size]
#define Normal_Font(_size)          [UIFont systemFontOfSize:_size]
#define Bold_Font(_size)            [UIFont fontWithName:@"HelveticaNeue-Regular" size:_size]

//三方字体
#define Roboto_Condensed_Font(_size)   [UIFont fontWithName:@"Roboto-Condensed" size:_size]
#define Roboto_Regular_Font(_size)     [UIFont fontWithName:@"Roboto-Regular" size:_size]
#define Roboto_Medium_Font(_size)      [UIFont fontWithName:@"Roboto-Medium" size:_size]

#define TEXTFIELD_TEXT_SIZE             Normal_Font(15)
#define BUTTON_TEXT_SIZE                Normal_Font(18)

/**
 *字体
 */
#define DEF_MyFont(x)     [UIFont systemFontOfSize:x]
#define DEF_MyBoldFont(x) [UIFont boldSystemFontOfSize:x]

/**
 *设置图片
 */
#define DEF_IMAGENAME(name)         [UIImage imageNamed:name]
#define DEF_BUNDLE_IMAGE(name,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]]

/**
 *根据RGB获取color
 */
#define DEF_COLOR_RGBA(r,g,b,a)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define DEF_COLOR_RGB(r,g,b)         [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]
#define DEF_UICOLORFROMRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//通过颜色获得图片
#define GET_IMAGE_FOR_COLOR(_color)     [UIImage createImageWithColor:_color]

/**
 *获取AppDelegate
 */
#define DEF_MyAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define DEF_MyUIWindow [[[UIApplication sharedApplication] delegate] window] //获得window

/**
 *获取APP当前版本号
 */
#define DEF_AppCurrentVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


/**
 *获取APP当前版本号
 */
#define DEF_App_BundleId [[NSBundle mainBundle] bundleIdentifier]
/**
 *Document路径
 */
#define DEF_DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/**
 *NSUserDefault
 */
#define DEF_UserDefaults [NSUserDefaults standardUserDefaults]

/**
 *获取屏幕宽高
 */
#define DEF_DEVICE_WIDTH                [UIScreen mainScreen].bounds.size.width
#define DEF_DEVICE_HEIGHT               (DEF_IOS7 ? [UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.height - 20)
#define DEF_CONTENT_INTABBAR_HEIGHT     (DEF_IOS7 ? ([UIScreen mainScreen].bounds.size.height - 49):([UIScreen mainScreen].bounds.size.height - 69))
#define DEF_NAVIGATIONBAR_HEIGHT        (DEF_DEVICE_HEIGHT == 812.0 ? 88 : 64)
#define DEF_TABBAR_HEIGHT               (DEF_DEVICE_HEIGHT == 812.0 ? 83 : 49)
#define SafeAreaTopHeight (DEF_DEVICE_HEIGHT == 812.0 ? 20 : 0)
#define SafeAreaBottomHeight (DEF_DEVICE_HEIGHT == 812.0 ? 34 : 0)

/**
 *屏幕去掉导航栏的frame
 */
#define MAIN_VIEW_FRAME                  CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - DEF_NAVIGATIONBAR_HEIGHT)

/**
 *获取iphone
 */
#define DEF_DEVICE_IphoneX               (([[UIScreen mainScreen] bounds].size.height-812.0)?NO:YES)
#define DEF_DEVICE_Iphone6p              (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)
#define DEF_DEVICE_Iphone6               (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)
#define DEF_DEVICE_Iphone5               (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define DEF_DEVICE_Iphone4               (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)

//app常用功能
#define DEF_APP_NAME    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define DEF_APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define DEF_APP_OS      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"DTPlatformVersion"]

//Tim添加，计算二级页面的content的高度
#define DEF_CONTENT_WITHOUTTABBAR_HEIGHT (DEF_IOS7 ? ([UIScreen mainScreen].bounds.size.height - 64):([UIScreen mainScreen].bounds.size.height - 84))

/**
 *所有类型转化成String(防止出现nill值显示在UI)
 */
#define DEF_OBJECT_TO_STIRNG(object) ((object && object != (id)[NSNull null])?([object isKindOfClass:[NSString class]]?object:[NSString stringWithFormat:@"%@",object]):@"")

/* *
 *iOS版本
 */
#define DEF_IOS7         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)
#define DEF_IOS7Dot0     ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0 ? YES : NO)
#define DEF_IOS8         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#define DEF_IOS9         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)
#define DEF_IOS10         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 ? YES : NO)
#define DEF_IOS11         ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES : NO)

/**
 *设备方向
 */
#define DEF_Portrait            ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortrait ? YES : NO)
#define DEF_PortraitUpsideDown  ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationPortraitUpsideDown ? YES : NO)
#define DEF_LandscapeLeft       ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeLeft ? YES : NO)
#define DEF_LandscapeRight      ([[UIDevice currentDevice] orientation]==UIInterfaceOrientationLandscapeRight ? YES : NO)


//UITextFiled clearButton
#define TEXTFIELD_CLEARBUTTON(_tf)  \
UIButton *clearButton = [_tf valueForKey:@"_clearButton"];  \
[clearButton setImage:[UIImage imageNamed:@"ic_Clear"] forState:UIControlStateNormal];    \
[clearButton setImage:[UIImage imageNamed:@"ic_Clear"] forState:UIControlStateHighlighted];

#ifndef	BLOCK_SAFE
#define BLOCK_SAFE(block)           if(block)block
#endif

/**
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 * 示例：
 * @weakify_self
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif
#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif

/*
 * 在主线程执行block操作
 */
#define DispatchOnMainThread(block, ...) if(block) dispatch_async(dispatch_get_main_queue(), ^{ block(__VA_ARGS__); })

/*
 *
 */
#define DEF_IMAGE(_imageName)                 ([UIImage imageNamed:_imageName])

//错误信息显示时间
#define DEF_ERROR_MESSAGE_SHOW_TIME     1.5

#define DEF_PAGESIZE                  @"10"

#endif /* CustomDefineHeader_h */
