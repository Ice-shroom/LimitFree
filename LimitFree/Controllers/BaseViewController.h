//
//  BaseViewController.h
//  LimitFree
//
//  Created by 千锋 on 16/3/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//




// 基类  所有视图控制器的父类、



#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController



// 设置标题
- (void)addTitleViewWithTitle:(NSString *)title;

// 设置左右按钮、
- (void)addBarbuttonItem:(NSString *)name image:(UIImage *)image target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;





@end
