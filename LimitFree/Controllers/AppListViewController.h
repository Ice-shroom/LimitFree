//
//  AppListViewController.h
//  LimitFree
//
//  Created by 千锋 on 16/3/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "BaseViewController.h"

@interface AppListViewController : BaseViewController


@property(nonatomic,copy) NSString * requestURL; // 请求数据的接口

@property(nonatomic,copy) NSString * categotyID; //分类地址、

@property(nonatomic,copy) NSString * categoryType; // 记录类型、

@property(nonatomic,copy) NSString * searchText;

- (void)customNavigationItem;

@end
