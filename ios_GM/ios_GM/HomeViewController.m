//
//  HomeViewController.m
//  ios_GM
//
//  Created by Apple on 2018/7/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "NowAndSoonCollectionCell.h"
#import "MainViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *Collection;
@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.hidden = YES;

    UILabel *nameLb = [[UILabel alloc]initWithFrame:CGRectMake(23, 56 + SafeAreaTopHeight, DEF_DEVICE_WIDTH/2, 30)];
    nameLb.font = DEF_MyBoldFont(26);
    nameLb.textColor = DEF_UICOLORFROMRGB(0x4b4948);
    nameLb.text = [NSString stringWithFormat:@"Hi,  %@",DEF_MyAppDelegate.loginDic[@"accountName"]];
    [self.view addSubview:nameLb];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [nameLb addGestureRecognizer:tap];
    @weakify(self);
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        @strongify(self);

        [self logout];
    }];
                
    UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(23, nameLb.bottom + 9, DEF_DEVICE_WIDTH - 23, 17)];
    titleLb.textColor = DEF_UICOLORFROMRGB(0x4b4948);
    titleLb.font = DEF_MyFont(16);
    titleLb.text = @"请选择你想要体验的车型";
    [self.view addSubview:titleLb];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(DEF_RESIZE_UI(170), DEF_RESIZE_UI(120))];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, DEF_RESIZE_UI(12), 0, DEF_RESIZE_UI(12));
    flowLayout.minimumInteritemSpacing = 0;
    
    self.Collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, titleLb.bottom + 17, DEF_DEVICE_WIDTH, DEF_DEVICE_HEIGHT - 124) collectionViewLayout:flowLayout];
    self.Collection.delegate = self;
    self.Collection.dataSource = self;
//    self.Collection.contentInset = UIEdgeInsetsMake(DEF_NAVIGATIONBAR_HEIGHT, 0, DEF_TABBAR_HEIGHT, 0);
    self.Collection.backgroundColor = [UIColor clearColor];
    self.Collection.alwaysBounceVertical = YES;
    [self.Collection registerClass:[NowAndSoonCollectionCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.Collection];
    self.Collection.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self planRefresh];
    }];
    self.Collection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    [self.Collection.mj_footer endRefreshingWithNoMoreData];
    
    [self planRefresh];
    
}

-(void)planRefresh
{
    
    
    NSDictionary *dic = @{@"access-token"      :DEF_MyAppDelegate.loginDic[@"access_token"],
                          };
    [RequestOperationManager userLoginParametersDic:dic success:^(NSMutableDictionary *result) {
        [self.Collection.mj_header endRefreshing];
        
        if (result == nil) {
            return;
        }
        if ([result[@"code"] intValue] != 1) {
            return;
        }
        
        self.arr = result[@"data"];
        [self.Collection reloadData];
        
    } failture:^(id result) {
        [self.Collection.mj_header endRefreshing];

    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NowAndSoonCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];

    cell.model = self.arr[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MainViewController *vc = [[MainViewController alloc]init];
    vc.dic = self.arr[indexPath.row];
    
    DEF_MyAppDelegate.carDic = self.arr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)logout
{
    LoginViewController *tabBar = [[LoginViewController alloc]init];
    CACBaseNavigationController *Nav = [[CACBaseNavigationController alloc]initWithRootViewController:tabBar];
    DEF_MyAppDelegate.window.rootViewController = Nav;
    DEF_MyAppDelegate.mainNav = Nav;
    
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
