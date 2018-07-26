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
    
    self.lineView.hidden = YES;
    
    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(23, DEF_RESIZE_UI(29) + DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH/2, 35)];
    nameLb.font = DEF_MyBoldFont(34);
    nameLb.textColor = DEF_UICOLORFROMRGB(0x4b4948);
    nameLb.text = @"您好,";
    [self.view addSubview:nameLb];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(23, nameLb.bottom + DEF_RESIZE_UI(14), DEF_DEVICE_WIDTH - 23, 17)];
    titleLb.textColor = DEF_UICOLORFROMRGB(0x4b4948);
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"欢迎打开雪佛兰体验小魔盒";
    [self.view addSubview:titleLb];
    
    UITextField *uTf = [[UITextField alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(23), titleLb.bottom + DEF_RESIZE_UI(66), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(23*2), DEF_RESIZE_UI(35))];
    uTf.delegate = self;
    uTf.placeholder = @"请输入您的账号";
    [self.view addSubview:uTf];
    self.uTf = uTf;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(uTf.x, uTf.bottom, uTf.width, 0.5)];
    lineView.backgroundColor = DEF_UICOLORFROMRGB(0xe5e5e5);
    [self.view addSubview:lineView];
    
    UITextField *pTf = [[UITextField alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(23), lineView.bottom + DEF_RESIZE_UI(20), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(23*2), DEF_RESIZE_UI(35))];
    pTf.delegate = self;
    pTf.placeholder = @"请输入您的密码";
    [self.view addSubview:pTf];
    self.pTf = pTf;
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(pTf.x, pTf.bottom, pTf.width, 0.25)];
    lineView1.backgroundColor = DEF_UICOLORFROMRGB(0xe5e5e5);
    [self.view addSubview:lineView1];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), lineView1.bottom + DEF_RESIZE_UI(197), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"登录" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, loginBtn.bottom + DEF_RESIZE_UI(28), 150, 20)];
    [btn setTitle:@"打开掌上4S店授权" forState:0];
    [btn setTitleColor:DEF_UICOLORFROMRGB(0x4b4948) forState:0];
    btn.titleLabel.font = DEF_MyFont(16);
    [btn addTarget:self action:@selector(shouquan) forControlEvents:UIControlEventTouchUpInside];
    btn.centerX = self.view.centerX;
    [self.view addSubview:btn];
    
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
