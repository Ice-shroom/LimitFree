//
//  starView.m
//  LimitFree
//
//  Created by 千锋 on 16/3/30.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "starView.h"

@implementation starView{

    UIImageView * _foregroundImageView; // 前景图、
    
    UIImageView * _backgroundImageView; // 背景图、
    
}

// 创建视图

- (void)createViews{

    
    _backgroundImageView = [[UIImageView alloc] init];
    
    [self addSubview:_backgroundImageView];
    
    // 使用自动布局、
    _backgroundImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        // 建立约束
        make.left.equalTo(self);
        
        make.top.equalTo(self);
        
        make.width.equalTo(@65);
        
        make.height.equalTo(@23);
        
    }];
    
    // 设置背景图属性、
    _backgroundImageView.image = [UIImage imageNamed:@"StarsBackground"];
    
    // 设置图片显示模型、
    _backgroundImageView.contentMode = UIViewContentModeLeft;
    
    
    // 前景图
    _foregroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"StarsForeground"]];
    
    [self addSubview:_foregroundImageView];
    
    // 设置约束、
    [_foregroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(_backgroundImageView);
    }];
    
    // 设置图片显示模式、
    _foregroundImageView.contentMode = UIViewContentModeLeft;
    
    // 裁剪
    _foregroundImageView.clipsToBounds = YES;
    
    
}

// 重写init方法

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self createViews];
        
    }
    return self;
}

// 挡在xib或者storyboard中关联类时，程序从xib或者storyboard中创建对象时，会调用该方法、
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        
        [self createViews];
    }
    return self;
    
}

// 重写属性的setter方法
- (void)setStarValue:(CGFloat)starValue{

    _starValue = starValue;
    
    if (_starValue >= 0 && _starValue <= 5) {
        
        // 重建约束、
        [_foregroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(_backgroundImageView);
            
            make.top.equalTo(_backgroundImageView);
            
            make.height.equalTo(_backgroundImageView);
            
            make.width.equalTo(_backgroundImageView).multipliedBy(_starValue/5);
        }];
        
    }
    
}














@end
