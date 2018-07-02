//
//  CACTabBarViewController.m
//  cacwallet
//
//  Created by Queen on 2017/4/21.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "CACTabBarViewController.h"
#import "CACBaseNavigationController.h"
//#import "HomeViewController.h"
//#import "NoticeViewController.h"
//#import "MessageViewController.h"
//#import "PerformanceViewController.h"

@interface CACTabBarViewController ()

@end

@implementation CACTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
    [self.tabBar setShadowImage:[UIImage new]];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        self.tabBarController.tabBar.subviews[0].subviews[1].hidden = YES;
    }
    
//    //首页
//    HomeViewController *HomeVc = DEF_VIEW_CONTROLLER_INIT(@"HomeViewController");
//    [self addChildVCWith:HomeVc title:@"课程" nmlImgName:@"课程暗" selImgName:@"课程亮"];
//
////    //产品
////    NoticeViewController *ProductVc = DEF_VIEW_CONTROLLER_INIT(@"NoticeViewController");
////    [self addChildVCWith:ProductVc title:@"教务公告" nmlImgName:@"icon-教务公告-未选中" selImgName:@"icon-教务公告-选中"];
//
//    //发现
//    MessageViewController *FinancialVc = DEF_VIEW_CONTROLLER_INIT(@"MessageViewController");
//    [self addChildVCWith:FinancialVc title:@"考试" nmlImgName:@"考试暗" selImgName:@"考试亮"];
//
//    //我的
//    PerformanceViewController *MineVc = DEF_VIEW_CONTROLLER_INIT(@"PerformanceViewController");
//    [self addChildVCWith:MineVc title:@"我的" nmlImgName:@"我的暗" selImgName:@"我的亮"];
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];

}

-(void)addChildVCWith:(UIViewController *)vc title:(NSString *)title nmlImgName:(NSString *)nmlImgName selImgName:(NSString *)selImgName {
    
    [self addChildViewController:vc];
    //设置标题
    vc.tabBarItem.title = title;
    
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           DEF_RGB(0, 102, 251), NSForegroundColorAttributeName,
                                           nil] forState:UIControlStateSelected];
    
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                           DEF_UICOLORFROMRGB(0x999999), NSForegroundColorAttributeName,
                                           nil] forState:UIControlStateNormal];
    
    //设置普通状态图片
    vc.tabBarItem.image = [UIImage imageNamed:nmlImgName];
    UIImage *selImg = [UIImage imageNamed:selImgName];
    selImg = [selImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImg;
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    _tabbarItemIndex = [tabBarController.viewControllers indexOfObject:viewController];
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
