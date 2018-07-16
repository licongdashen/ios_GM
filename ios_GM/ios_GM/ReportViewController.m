//
//  ReportViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ReportViewController.h"
#import "MainViewController.h"
#import <CoreImage/CoreImage.h>

@interface ReportViewController ()

@property (nonatomic, strong)UIImageView *imagv;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLb.text = @"底盘悬挂体验";
    self.carView.hidden = NO;
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(64), DEF_DEVICE_WIDTH, 17 + 25)];
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"请扫描二维码\n领取您的试驾报告";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.numberOfLines = 2;
    titleLb.textColor = DEF_APP_MAIN_TITLECOLOR;
    [self.view addSubview:titleLb];
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(27), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(139), DEF_RESIZE_UI(213), DEF_RESIZE_UI(213))];
    imagv.centerX = self.view.centerX;
    imagv.contentMode = UIViewContentModeScaleAspectFit;
    CIImage *image = [self creatQRcodeWithUrlstring:@"http://www.baidu.com"];
    imagv.image = [self createNonInterpolatedUIImageFormCIImage:image withSize:DEF_RESIZE_UI(213)];
    [self.view addSubview:imagv];
    self.imagv = imagv;
    
    UIImageView *imagv1 = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(27), imagv.bottom + DEF_RESIZE_UI(44), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(40))];
    imagv1.centerX = self.view.centerX;
    imagv1.contentMode = UIViewContentModeScaleAspectFit;
    imagv1.image = DEF_IMAGE(@"透底logo-3");
    [self.view addSubview:imagv1];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(54), DEF_NAVIGATIONBAR_HEIGHT + DEF_RESIZE_UI(462), DEF_RESIZE_UI(268), DEF_RESIZE_UI(48))];
    [loginBtn setTitle:@"体验其他项目" forState:0];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    loginBtn.titleLabel.font = DEF_MyFont(22);
    loginBtn.layer.cornerRadius = DEF_RESIZE_UI(48)/2;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(jieshu) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.centerX = self.view.centerX;
    loginBtn.backgroundColor = DEF_UICOLORFROMRGB(0xffbf17);
    [self.view addSubview:loginBtn];
    
}


/**
   2  *  根据CIImage生成指定大小的UIImage
   3  *
   4  *  @param image CIImage
   5  *  @param size  图片宽度
   6  */
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
 }

/**
 *  根据字符串生成二维码 CIImage 对象
 *
 *  @param urlString 需要生成二维码的字符串
 *
 *  @return 生成的二维码
 */
- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}


-(void)jieshu
{
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
