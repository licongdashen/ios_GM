//
//  CACBaseViewController.m
//  cacwallet
//
//  Created by Queen on 2017/4/21.
//  Copyright © 2017年 licong. All rights reserved.
//

#import "CACBaseViewController.h"
#import "FeedbackViewController.h"

@interface CACBaseViewController ()

@end

@implementation CACBaseViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.view bringSubviewToFront:self.navBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    self.navBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, DEF_NAVIGATIONBAR_HEIGHT)];
    self.navBar.backgroundColor = [UIColor whiteColor];
    self.navBar.alpha = 1;
    [self.view addSubview:self.navBar];

    self.titleLb = [[UILabel alloc] initWithFrame:CGRectMake(41, 32 + SafeAreaTopHeight, DEF_DEVICE_WIDTH - 60*2, 36)];
    self.titleLb.textColor = DEF_UICOLORFROMRGB(0x292929);
    self.titleLb.backgroundColor = [UIColor clearColor];
//    self.titleLb.textAlignment = NSTextAlignmentCenter;
    self.titleLb.font = DEF_MyBoldFont(18.0);
    [self.navBar addSubview:self.titleLb];

    self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 32 + SafeAreaTopHeight, 52, 36)];
    [self.leftBtn setImage:[UIImage imageNamed:@"左箭头"] forState:UIControlStateNormal];
    [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.leftBtn.imageView.contentMode = UIViewContentModeCenter;
    [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = DEF_MyFont(14.0f);
    [self.navBar addSubview:self.leftBtn];

    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.navBar.width - 47, 32 + SafeAreaTopHeight, 52, 36)];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.rightBtn.imageView.clipsToBounds = YES;
    self.rightBtn.titleLabel.font = self.leftBtn.titleLabel.font;
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:self.rightBtn];
    [self.rightBtn setImage:DEF_IMAGE(@"意见反馈") forState:0];
    
//    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navBar.height - 0.5, self.navBar.width, 0.5)];
//    self.lineView.backgroundColor = DEF_UICOLORFROMRGB(0xe3e4e4);
//    [self.navBar addSubview:self.lineView];

    if (self.navigationController.visibleViewController == DEF_MyAppDelegate.tabBar) {
        //是tabBar 的viewcontroller 左边按钮隐藏
        self.leftBtn.hidden = YES;
    }else
    {
        //是tabBar 的viewcontroller 左边按钮隐藏
        self.leftBtn.hidden = NO;
    }
    
    UIView *carView = [[UIView alloc]initWithFrame:CGRectMake(40, self.navBar.bottom, 200, 25)];
    [self.view addSubview:carView];
    self.carView = carView;
    carView.hidden = YES;
    
    UIImageView *carImagv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    carImagv.image = DEF_IMAGE(@"车型-1");
    carImagv.contentMode = UIViewContentModeCenter;
    [carView addSubview:carImagv];
    
    UILabel *carLb = [[UILabel alloc]initWithFrame:CGRectMake(carImagv.right, 0, 175, 25)];
    carLb.font = DEF_MyFont(14);
    carLb.textColor = DEF_APP_MAIN_TITLECOLOR;
    carLb.text = DEF_MyAppDelegate.carDic[@"name"];
    [carView addSubview:carLb];
    self.carLb = carLb;
    
}

/**
 *  左边按钮响应方法
 */
-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  右边按钮响应方法
 */
-(void)rightBtnClick
{
    FeedbackViewController *vc = [[FeedbackViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

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
