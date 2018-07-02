//
//  CACTabBarViewController.h
//  cacwallet
//
//  Created by Queen on 2017/4/21.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CACTabBarViewController : UITabBarController<UITabBarControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign)NSInteger tabbarItemIndex;

@end
