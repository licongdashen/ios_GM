//
//  MainViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/4.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *homeTabv;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *titleArr1;

@property (nonatomic, strong) NSArray *imagvArr;

@end

@implementation MainViewController

-(void)rightBtnClick
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArr = @[@"静态体验",@"动态体验"];
    self.titleArr1 = @[@"音响体验",@"空调体验",@"降噪体验"];

    self.imagvArr = @[@"Group",@"Group 3",@"Group 4"];
    
    self.rightBtn.hidden = NO;
    [self.rightBtn setImage:DEF_IMAGE(@"意见反馈") forState:0];
    
    self.leftBtn.hidden = YES;
    
    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(20, self.navBar.height - 24, DEF_DEVICE_WIDTH, 24)];
    nameLb.font = DEF_MyBoldFont(23);
    nameLb.textColor = DEF_UICOLORFROMRGB(0x4b4948);
    nameLb.text = @"Hi,  张全明";
    [self.navBar addSubview:nameLb];
    
    _homeTabv = [[UITableView alloc]initWithFrame:CGRectMake(0, DEF_NAVIGATIONBAR_HEIGHT, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - DEF_NAVIGATIONBAR_HEIGHT) style:UITableViewStylePlain];
    _homeTabv.delegate        = self;
    _homeTabv.dataSource      = self;
//    _homeTabv.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _homeTabv.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_homeTabv];
    
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 170)];
    _homeTabv.tableHeaderView = headerview;
    
    UIImageView *imagv = [[UIImageView alloc]initWithFrame:CGRectMake(12, 20, DEF_DEVICE_WIDTH - 12*2, 150)];
    imagv.image = DEF_IMAGE(@"Bitmap");
    imagv.userInteractionEnabled = YES;
    [headerview addSubview:imagv];
    
    UIImageView *rightImagv = [[UIImageView alloc]initWithFrame:CGRectMake(imagv.width/2, 2, imagv.width/2, imagv.height - 8)];
    rightImagv.image = DEF_IMAGE(@"迈锐宝XL车型");
    rightImagv.clipsToBounds = YES;
    [imagv addSubview:rightImagv];
    
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(12, 12, 120, 15)];
    titleLb.font = DEF_MyFont(14);
    titleLb.textColor = [UIColor whiteColor];
    titleLb.text = @"您体验的车型为";
    [imagv addSubview:titleLb];
    
    UILabel *nameLb1 = [[UILabel alloc]initWithFrame:CGRectMake(12, titleLb.bottom + 9, imagv.width/2 - 12, 25)];
    nameLb1.text = @"迈锐宝XL";
    nameLb1.font = DEF_MyBoldFont(24);
    nameLb1.textColor = DEF_UICOLORFROMRGB(0xffbe17);
    [imagv addSubview:nameLb1];

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(12, nameLb1.bottom + 54, 75, 25)];
    [btn setImage:DEF_IMAGE(@"切换") forState:0];
    [btn setTitle:@"切换车辆" forState:0];
    btn.titleLabel.font = DEF_MyFont(14);
    [btn setTitleColor:DEF_UICOLORFROMRGB(0xc5c5c5) forState:0];
    [btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [imagv addSubview:btn];
    
    
}

-(void)change
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 1)];
    foot.alpha = 0.0f;
    return foot;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 48;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_DEVICE_WIDTH, 48)];
    backView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, DEF_DEVICE_WIDTH - 20, 48)];
    titleLb.font = DEF_MyBoldFont(16);
    titleLb.textColor = DEF_APP_MAIN_TITLECOLOR;
    titleLb.text = self.titleArr[section];
    [backView addSubview:titleLb];
    
    return backView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;{

    if (indexPath.section == 0) {
        return 208;
    }else{
        return 71;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //bunner
    static NSString *CellIdentifier = @"bunnerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        if (indexPath.section == 0) {
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(12, 2, DEF_DEVICE_WIDTH - 12*2, 208 - 4)];
            backView.layer.cornerRadius = 4;
            backView.backgroundColor = [UIColor whiteColor];
            backView.layer.shadowColor = [UIColor grayColor].CGColor;
            backView.layer.shadowOffset = CGSizeMake(0, 0);
            backView.layer.shadowOpacity = 0.5;
            backView.layer.shadowRadius = 1;
            backView.clipsToBounds = NO;
            [cell addSubview:backView];

            int y = 0;
            for (int i = 0; i<3; i++ ) {
                
                UIView *bakccc = [[UIView alloc]initWithFrame:CGRectMake(0, y, backView.width - 10, 204/3)];
                bakccc.tag = 200 + i;
                [backView addSubview:bakccc];

                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
                [tap.rac_gestureSignal subscribeNext:^(UIGestureRecognizer * x) {
                    NSLog(@"vvvvvv%ld",x.view.tag);
                    if (x.view.tag == 200) {
                        
                    }else if (x.view.tag == 201){
                        
                    }else if (x.view.tag == 202){
                        
                    }
                }];
                [bakccc addGestureRecognizer:tap];
                
                if (i < 2) {
                    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 204/3, backView.width - 10, 1)];
                    lineView.backgroundColor = DEF_UICOLORFROMRGB(0xf7f7f7);
                    [bakccc addSubview:lineView];
                }
                
                UIImageView *Headerimagv = [[UIImageView alloc]initWithFrame:CGRectMake(13, 17 , 37, 37)];
                Headerimagv.image = DEF_IMAGE(self.imagvArr[i]);
                [bakccc addSubview:Headerimagv];

                UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(Headerimagv.right + 10, 0, 150, 204/3)];
                titleLb.text = self.titleArr1[i];
                titleLb.font = DEF_MyFont(14);
                titleLb.textColor = DEF_APP_MAIN_TITLECOLOR;
                [bakccc addSubview:titleLb];

                UIImageView *arrowImagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(340 - 18), 0, 0, 204/3)];
                arrowImagv.image = DEF_IMAGE(@"右箭头");
                arrowImagv.contentMode = UIViewContentModeCenter;
                [bakccc addSubview:arrowImagv];
                
                y += 204/3;
            }
            
        }else{
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(12, 2, DEF_DEVICE_WIDTH - 12*2, 70 - 4)];
            backView.layer.cornerRadius = 4;
            backView.backgroundColor = [UIColor whiteColor];
            backView.layer.shadowColor = [UIColor grayColor].CGColor;
            backView.layer.shadowOffset = CGSizeMake(0, 0);
            backView.layer.shadowOpacity = 0.5;
            backView.layer.shadowRadius = 1;
            backView.clipsToBounds = NO;
            [cell addSubview:backView];
            
            UIView *bakccc = [[UIView alloc]initWithFrame:CGRectMake(0, 0, backView.width - 10, 204/3)];
            bakccc.tag = 203;
            [backView addSubview:bakccc];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
            [tap.rac_gestureSignal subscribeNext:^(UIGestureRecognizer * x) {
                NSLog(@"vvvvvv%ld",x.view.tag);
                
            }];
            [bakccc addGestureRecognizer:tap];
            
            UIImageView *Headerimagv = [[UIImageView alloc]initWithFrame:CGRectMake(13, 17 , 37, 37)];
            Headerimagv.image = DEF_IMAGE(@"Group 5");
            [bakccc addSubview:Headerimagv];
            
            UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(Headerimagv.right + 10, 0, 150, 204/3)];
            titleLb.text = @"底盘悬挂体验";
            titleLb.font = DEF_MyFont(14);
            titleLb.textColor = DEF_APP_MAIN_TITLECOLOR;
            [bakccc addSubview:titleLb];
            
            UIImageView *arrowImagv = [[UIImageView alloc]initWithFrame:CGRectMake(DEF_RESIZE_UI(340 - 18), 0, 0, 204/3)];
            arrowImagv.image = DEF_IMAGE(@"右箭头");
            arrowImagv.contentMode = UIViewContentModeCenter;
            [bakccc addSubview:arrowImagv];
        }
    }
    
    return cell;
    
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