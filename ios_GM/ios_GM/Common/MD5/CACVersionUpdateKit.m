//
//  CACVersionUpdateKit.m
//  cacwallte
//
//  Created by Gandalf on 2017/4/26.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "CACVersionUpdateKit.h"

@implementation CACVersionUpdateKit

+ (BOOL)existNewVersion
{
    // 获取沙盒中版本号
    NSString *lastVersion = [UserDefaultsTool getStringWithKey:DEF_LAST_APP_VERSION];
    // 获取当前的版本号
    NSString *currentVersion = DEF_APP_VERSION;
    
    if ([lastVersion isEqualToString:currentVersion]) {
        return NO;
    } else {
        return YES;
    }
}

+ (void)saveCurrentVersion
{
    // 获取当前的版本号
    NSString *currentVersion = DEF_APP_VERSION;
    
    [DEF_UserDefaults setObject:currentVersion forKey:DEF_LAST_APP_VERSION];
    [DEF_UserDefaults synchronize];
}

@end
