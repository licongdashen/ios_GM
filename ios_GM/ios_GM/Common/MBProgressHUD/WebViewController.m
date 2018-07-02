//
//  WebViewController.m
//  hexueEducation
//
//  Created by Apple on 2018/1/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLb.text = self.title1;
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - DEF_NAVIGATIONBAR_HEIGHT)];
    [self.view addSubview:web];
    NSURL* url = [NSURL URLWithString:self.webUrl];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [web loadRequest:request];//加载
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
