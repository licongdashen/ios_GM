//
//  NoBossSoundSucViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NoBossSoundSucViewController.h"
#import "MainViewController.h"

@interface NoBossSoundSucViewController ()

@end

@implementation NoBossSoundSucViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = @"音响体验";
    self.carView.hidden = NO;
    self.carLb.text = self.dic[@"name"];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(27), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(63), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(27*2), DEF_RESIZE_UI(348))];
    imagv.image = DEF_IMAGE(@"非bose");
    imagv.layer.cornerRadius = 5;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imagv];
    
    UIImageView *cardImagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(117), DEF_RESIZE_UI(118), DEF_RESIZE_UI(90), DEF_RESIZE_UI(40))];
    cardImagv.image = DEF_IMAGE(@"汽车");
    cardImagv.contentMode = UIViewContentModeCenter;
    [imagv addSubview:cardImagv];
    
    UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(70.5), cardImagv.bottom + DEF_RESIZE_UI(12), DEF_RESIZE_UI(190), DEF_RESIZE_UI(84))];
    contentLb.textAlignment = NSTextAlignmentCenter;
    contentLb.textColor = [UIColor whiteColor];
    contentLb.numberOfLines = 3;
    contentLb.font = DEF_MyBoldFont(DEF_RESIZE_UI(18));
    contentLb.text = @"原厂定制剧院级音响\n6扬声器豪华配置\n为你把剧院搬进车里来";
    [imagv addSubview:contentLb];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), imagv.bottom + DEF_RESIZE_UI(52), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"体验其他项目" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
}

-(void)jieshu
{
    [DEF_UserDefaults setObject:@"1" forKey:@"1111"];

    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[MainViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
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
