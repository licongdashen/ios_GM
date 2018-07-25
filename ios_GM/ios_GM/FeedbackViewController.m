//
//  FeedbackViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/18.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITextView *tv2;
@property (nonatomic, strong) UILabel *ploaderLb1;
@property (nonatomic, weak) UIButton *xiangceBtn;
@property (nonatomic, strong) NSMutableArray *photoArr;

@property (nonatomic, weak) UIView *backView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rightBtn.hidden = YES;
    self.titleLb.text = @"意见反馈";

    self.photoArr = [[NSMutableArray alloc]init];
    
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
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, lineView.bottom + DEF_RESIZE_UI(20), DEF_DEVICE_WIDTH, DEF_RESIZE_UI(160))];
    [self.view addSubview:backView];
    self.backView = backView;

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
    
    [self loadphotoView];

}

-(void)loadphotoView
{
    for (UIView *view in self.backView.subviews) {
        [view removeFromSuperview];
    }
    
    int x = DEF_RESIZE_UI(39);
    int y = 0;
    
    for (int i = 0; i < self.photoArr.count + 1; i++) {
        if (i == self.photoArr.count) {
            if (i < 5) {
                UIButton *xiangceBtn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, DEF_RESIZE_UI(70), DEF_RESIZE_UI(70))];
                [xiangceBtn setImage:DEF_IMAGE(@"照相") forState:0];
                [xiangceBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
                [self.backView addSubview:xiangceBtn];
                self.xiangceBtn = xiangceBtn;
            }
        }else{
            UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, DEF_RESIZE_UI(70), DEF_RESIZE_UI(70))];
            imagv.image = self.photoArr[i];
            imagv.layer.cornerRadius = 6;
            imagv.layer.masksToBounds = YES;
            imagv.contentMode = UIViewContentModeScaleAspectFill;
            [self.backView addSubview:imagv];
        }
       
        x += DEF_RESIZE_UI(90);
        
        if (i == 2) {
            y += DEF_RESIZE_UI(90);
            x = DEF_RESIZE_UI(39);
        }
        
    }
}

-(void)action
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择" , nil];
    [sheet showInView:self.view];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    [self.photoArr addObject:image];

    [self loadphotoView];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - CustomActionSheetDelegate

- (BOOL) isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"%ld", buttonIndex);
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.editing = YES;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0: {
            if ([self isCameraAvailable])
            {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            else
            {
            }
            break;
        }
            
        case 1: {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
            break;
        }
        default:
            return;
    }
}


-(void)jieshu
{

    [CACProgressHUD showMBProgress:DEF_MyUIWindow message:@""];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableString *str = [NSMutableString stringWithFormat:DEF_IPAddress];
    [str appendString:DEF_API_CHECKVALIDIMG];
    [str appendString:@"?"];
    [str appendFormat:@"%@=%@", @"access-token", DEF_MyAppDelegate.loginDic[@"access_token"]];
    
    NSDictionary *dic = @{@"content"      :self.tv2.text,
                          };
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:str parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < self.photoArr.count; i ++) {
            
            NSData *data = UIImageJPEGRepresentation(self.photoArr[i], 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%d%@.png",i,str];
            NSLog(@"ffffffff%@",fileName);
            [formData appendPartWithFileData:data name:@"image[]" fileName:fileName mimeType:@"image/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功 %@", responseObject);
        [CACProgressHUD hideMBProgress:DEF_MyUIWindow];
        if (responseObject == nil) {
            [CACUtility showTips:@"提交失败"];
            return;
        }
        if ([responseObject[@"code"] intValue] != 1) {
            [CACUtility showTips:@"提交失败"];
            return;
        }
        
        [CACUtility showTips:@"提交成功"];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [CACProgressHUD hideMBProgress:DEF_MyUIWindow];
        
        NSLog(@"提交失败 %@", error);
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
