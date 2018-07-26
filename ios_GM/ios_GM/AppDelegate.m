//
//  AppDelegate.m
//  ios_GM
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "GuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
     [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [DEF_UserDefaults setObject:@"0" forKey:@"1111"];
    [DEF_UserDefaults setObject:@"0" forKey:@"1112"];
    [DEF_UserDefaults setObject:@"0" forKey:@"1113"];
    [DEF_UserDefaults setObject:@"0" forKey:@"1114"];
    [DEF_UserDefaults setObject:@"0" forKey:@"2222"];
    [DEF_UserDefaults setObject:@"0" forKey:@"3333"];
    [DEF_UserDefaults setObject:@"0" forKey:@"4444"];

//    self.loginDic = @{@"access_token"   : @"bb20320c9898263fee62a0ae3eb81208",
//                      @"accountName"    : @"陈杰",
//                      @"storeShortName" : @"宜兴汇通"
//                      };
    [self performSelector:@selector(panduan) withObject:nil afterDelay:0.1];
    

    return YES;
}

-(void)panduan
{
    if (self.loginDic) {
        [self loadingHomeController];
        
    }else{
        
        UIViewController *vc = [[UIViewController alloc]init];
        vc.view.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = vc;
        
        UIAlertView *WXinstall=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请打开母APP授权登录"delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        WXinstall.delegate = self;
        [WXinstall show];
    }
    [self.window makeKeyAndVisible];

}

-(void)loadingHomeController
{
    
    if ([CACVersionUpdateKit existNewVersion]) {
        // 跳转引导页
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window.rootViewController = guideVC;
    } else {
        
        HomeViewController *tabBar = [[HomeViewController alloc]init];
        CACBaseNavigationController *Nav = [[CACBaseNavigationController alloc]initWithRootViewController:tabBar];
        self.window.rootViewController = Nav;
        self.mainNav = Nav;
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSLog(@"URL:%@ Options:%@",url,sourceApplication);
    [self loadingHomeController];

    return YES;
}

-(NSString *)decodeString:(NSString*)encodedString

{
    
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     
                                                                                                                     CFSTR(""),
                                                                                                                     
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
    
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options{
    
    
    NSString *str = [url query];
    NSString *aaa = [self decodeString:str];
    
    NSString * subString2 = [aaa substringFromIndex:5];
    NSData *jsonData = [subString2 dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    self.loginDic = dic;
    NSLog(@"loginDic:%@",dic);
    

    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]initWithDictionary:self.loginDic];
    [dic1 removeObjectForKey:@"skipName"];
    [dic1 removeObjectForKey:@"skipImage"];

    [RequestOperationManager getValidImgParametersDic:dic1 success:^(NSMutableDictionary *result) {

        if (result == nil) {
            return;
        }
        if ([result[@"code"] intValue] != 1) {
            return;
        }

    } failture:^(id result) {
        
    }];
    
    [self loadingHomeController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
