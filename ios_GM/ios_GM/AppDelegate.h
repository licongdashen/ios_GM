//
//  AppDelegate.h
//  ios_GM
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) CACBaseNavigationController *mainNav;

@property (weak, nonatomic)CACTabBarViewController *tabBar;

@property (nonatomic, strong) NSDictionary *loginDic;


- (void)loadingHomeController;


@end

