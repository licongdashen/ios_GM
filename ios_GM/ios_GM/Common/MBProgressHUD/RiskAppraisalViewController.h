//
//  RiskAppraisalViewController.h
//  cacbos
//
//  Created by Apple on 2017/10/27.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "CACBaseViewController.h"

@interface RiskAppraisalViewController : CACBaseViewController

/*
 * @brief 要跳转的URL
 */
@property (nonatomic, strong) NSString *webUrl;

@property (nonatomic, strong) NSString *title;

- (void)closeOrBackOperation;

@end
