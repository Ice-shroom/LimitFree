//
//  ApplistCell.h
//  LimitFree
//
//  Created by 千锋 on 16/3/30.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppListModel.h"

#import "starView.h"


@interface ApplistCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UILabel *expireDateLabel;


@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;


@property (weak, nonatomic) IBOutlet starView *starView;


@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *totalMsgLabel;


// 关联模型
@property(nonatomic,strong) ApplicationsModel * model;



@end
