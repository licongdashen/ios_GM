//
//  RiskAppraisalViewController.m
//  cacbos
//
//  Created by Apple on 2017/10/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "RiskAppraisalViewController.h"
#import "WebJSBridgeKit.h"

@interface  RiskAppraisalViewController()<UIWebViewDelegate>

// webView视图
@property (nonatomic, weak) UIWebView *webView;

@property (nonatomic, strong) MBProgressHUD * HUD;

@end

@implementation RiskAppraisalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = DEF_APP_MAIN_COLOR;
    
    self.titleLb.text = self.title;
    
    // 1.设置导航栏
    
    // 2.添加子控件
    [self addSubviews];
}

#pragma makr - 添加子控件
- (void)addSubviews
{
    
    CGRect rectOfStatusbar  = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat statusBarHeight = rectOfStatusbar.size.height;
    
//    // 1.添加状态栏view
//    UIView * statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0,0, DEF_DEVICE_WIDTH, statusBarHeight)];
//    statusBarView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:statusBarView];
    
    // 2. 添加UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - DEF_NAVIGATIONBAR_HEIGHT)];
    [self.view addSubview:webView];
    self.webView = webView;
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    webView.scrollView.bounces = NO;
    webView.scalesPageToFit = YES;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
    NSLog(@"url==%@",self.webUrl);

//    [self loadProgressHUD];
    
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
//    [self removeProgressHUD];
    
    // 取加载url文件标题名，展示到导航标题中。
    //    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"signOut"] = ^(){
       
    };
    
    // 对象调用方法
    WebJSBridgeKit *jsBridge = [[WebJSBridgeKit alloc] initWithViewController:self];
    context[DEF_JS_CALLBACK_OBJ_NAME] = jsBridge;
    
    // 禁用用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // 禁用长按弹出框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

//#pragma mark - 返回按钮点击
- (void)closeOrBackOperation{
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 加载提示




- (void)dealloc{
    
    
}

@end
