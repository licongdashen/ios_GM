//
//  LoginViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/3.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *uTf;

@property (nonatomic, weak) UITextField *pTf;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftBtn.hidden = YES;
    self.rightBtn.hidden = YES;
    
    self.lineView.hidden = YES;
    
    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_RESIZE_UI(69) + DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, 35)];
    nameLb.font = DEF_MyBoldFont(34);
    nameLb.textColor = DEF_UICOLORFROMRGB(0x4b4948);
    nameLb.text = @"您好";
    nameLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLb];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, nameLb.bottom + DEF_RESIZE_UI(14), DEF_DEVICE_WIDTH, 17)];
    titleLb.textColor = DEF_UICOLORFROMRGB(0x4b4948);
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"欢迎打开雪佛兰试车宝";
    titleLb.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLb];
    
    UIImageView *leftImagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(55),titleLb.bottom + DEF_RESIZE_UI(69), DEF_RESIZE_UI(107), DEF_RESIZE_UI(107))];
    leftImagv.image = DEF_IMAGE(@"Group-1");
    [self.view addSubview:leftImagv];

    UIImageView *centerImagv = [[UIImageView alloc]initWithFrame:CGRectMake(leftImagv.right, titleLb.bottom + DEF_RESIZE_UI(108), DEF_RESIZE_UI(53), DEF_RESIZE_UI(30))];
    centerImagv.image = DEF_IMAGE(@"123");
    centerImagv.contentMode = UIViewContentModeCenter;
    [self.view addSubview:centerImagv];
    
    UIImageView *rightImagv = [[UIImageView alloc]initWithFrame:CGRectMake(leftImagv.right + DEF_RESIZE_UI(53), titleLb.bottom + DEF_RESIZE_UI(69), DEF_RESIZE_UI(107), DEF_RESIZE_UI(107))];
    rightImagv.image = DEF_IMAGE(@"Group Copy");
    [self.view addSubview:rightImagv];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), DEF_RESIZE_UI(504), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"打开掌上4S店授权" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(16);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.centerX = self.view.centerX;
    [loginBtn addTarget:self action:@selector(shouquan) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    
}

-(void)shouquan
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"chevy://"]]) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"chevy://"]];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
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
