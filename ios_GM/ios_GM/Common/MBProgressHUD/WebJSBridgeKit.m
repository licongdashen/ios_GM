//
//  WebJSBridgeKit.m
//  cacbos
//
//  Created by Apple on 2017/10/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "WebJSBridgeKit.h"
#import "RiskAppraisalViewController.h"

@interface WebJSBridgeKit ()

@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation WebJSBridgeKit

- (id)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

-(void)signOut
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.viewController.navigationController popViewControllerAnimated:YES];
 
    });
}

/** 被踢（退出并跳转到登录页） */
- (void)logoutAndPushLogin{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //更新UI操作
//        [UserDefaultUtils clearLoginUserData];
//
//        AppDelegate *delegate = DEF_MyAppDelegate;
//        [delegate loadingHomeAndPushLoginController];
    });
    
}

/** 登录 */
- (void)pushLogin
{
    NSLog(@"=======转到登录页=======");
}

//   风险测评交互方法
- (void)closeOrBackOperation{
    
    NSLog(@"=======返回或者关闭页面=======");
    dispatch_async(dispatch_get_main_queue(), ^{
        //更新UI操作
        [(RiskAppraisalViewController *)self.viewController closeOrBackOperation];
    });
    
    
}

@end
