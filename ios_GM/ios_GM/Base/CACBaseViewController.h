//
//  CACBaseViewController.h
//  cacwallet
//
//  Created by Queen on 2017/4/21.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CACBaseViewController : UIViewController

/**
 *  nav背景视图
 */
@property (nonatomic, strong)UIView *navBar;

/**
 *  nav 左边按钮
 */
@property (nonatomic, strong)UIButton *leftBtn;

/**
 *  nav 右边按钮
 */
@property (nonatomic, strong)UIButton *rightBtn;

/**
 *  nav 标题
 */
@property (nonatomic, strong)UILabel *titleLb;

/**
 *  nav 下划线
 */
@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, weak)UILabel *carLb;

@property (nonatomic, weak)UIView *carView;

/**
 *  返回按钮方法
 */
-(void)leftBtnClick;

/**
 *  右边按钮响应方法
 */
-(void)rightBtnClick;

@end
