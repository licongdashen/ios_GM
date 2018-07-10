//
//  CACVersionUpdateKit.h
//  cacwallte
//
//  Created by Gandalf on 2017/4/26.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACVersionUpdateKit : NSObject

/**
 检测是否有新版本

 @return YES：有  NO：没有
 */
+ (BOOL)existNewVersion;

/**
 保存新版本
 */
+ (void)saveCurrentVersion;

@end
