//
//  FeedbackViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/18.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *tv2;
@property (nonatomic, strong) UILabel *ploaderLb1;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rightBtn.hidden = YES;
    self.titleLb.text = @"意见反馈";
    

    self.tv2 = [[UITextView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(40), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(40), DEF_DEVICE_WIDTH - DEF_RESIZE_UI(80), DEF_RESIZE_UI(137))];
    self.tv2.delegate = self;
    [self.view addSubview:self.tv2];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(22), self.tv2.bottom, DEF_DEVICE_WIDTH - DEF_RESIZE_UI(22)*2, 1)];
    lineView.backgroundColor = DEF_UICOLORFROMRGB(0xf7f7f7);
    [self.view addSubview:lineView];

    self.ploaderLb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 6, 150, 17)];
    self.ploaderLb1.font = DEF_MyFont(16);
    self.ploaderLb1.textColor = DEF_UICOLORFROMRGB(0xadadad);
    self.ploaderLb1.text = @"请输入您的意见";
    [self.tv2 addSubview:self.ploaderLb1];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), lineView.bottom + DEF_RESIZE_UI(325), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"提交意见" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = 8;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    @weakify(self);
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tv2 resignFirstResponder];
    }];
    [self.view addGestureRecognizer:tap];
}

-(void)jieshu
{
    NSDictionary *dic1 = @{
                          @"content"         :self.tv2.text,
                          };
    [RequestOperationManager checkValidImgParametersDic:dic1 success:^(NSMutableDictionary *result) {
        
        if (result == nil) {
            return;
        }
        if ([result[@"code"] intValue] != 1) {
            return;
        }
        
    } failture:^(id result) {
        
    }];
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (self.tv2.text == nil || [self.tv2.text isEqualToString:@""]) {
        self.ploaderLb1.hidden = NO;
    }else{
        self.ploaderLb1.hidden = YES;
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
