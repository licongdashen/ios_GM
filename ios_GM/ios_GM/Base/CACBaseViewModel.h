//
//  CACBaseViewModel.h
//  cacwallte
//
//  Created by Queen on 2017/4/27.
//  Copyright © 2017年 licong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef enum {
    LoadData = 2,
    LoadMore
}LoadType;

@interface CACBaseViewModel : NSObject

/**
 下拉刷新网络请求command
 */
@property (nonatomic, strong) RACCommand *headerRefreshCommand;

/**
 上拉加载网络请求command
 */
@property (nonatomic, strong) RACCommand *footerRefreshCommand;

/**
 分页
 */
@property int page;

@end
