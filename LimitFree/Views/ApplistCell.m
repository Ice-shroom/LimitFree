//
//  ApplistCell.m
//  LimitFree
//
//  Created by 千锋 on 16/3/30.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "ApplistCell.h"

@implementation ApplistCell



// 类似于ViewController里的viewdidload
- (void)awakeFromNib {
    // Initialization code
    
    // 处理视图、
    self.iconImageView.layer.cornerRadius = 35;
    
    self.iconImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


// 重写模型的set方法
- (void)setModel:(ApplicationsModel *)model{

    _model = model;
    
    // 填充视图
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.iconUrl] placeholderImage:[UIImage imageNamed:@"appproduct_appdefault"]];
    
    self.titleLabel.text = _model.name;
    
    self.expireDateLabel.text = _model.expireDatetime;
    
    // 富文本处理、
    
    NSString * lastPrice = [NSString stringWithFormat:@"￥%@",_model.lastPrice];
    // 创建富文本字符串、
    NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:lastPrice attributes:@{NSStrikethroughColorAttributeName:[UIColor purpleColor],NSStrikethroughStyleAttributeName:@2,NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    self.lastPriceLabel.attributedText = attrString;
    
    self.categoryNameLabel.text = _model.categoryName;
    
    NSString * totalMessage = [NSString stringWithFormat:@"分享：%@次 收藏：%@次 下载：%@次",_model.shares,_model.favorites,_model.downloads];
    
    self.totalMsgLabel.text = totalMessage;
    
    // 设置星标的值
    self.starView.starValue = [_model.starOverall floatValue];
    
    
}


@end
