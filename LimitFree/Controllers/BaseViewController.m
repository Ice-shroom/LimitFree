//
//  BaseViewController.m
//  LimitFree
//
//  Created by 千锋 on 16/3/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTitleViewWithTitle:(NSString *)title{

    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.navigationItem.titleView = titleView;
    // 设置字体
    titleView.font = [UIFont systemFontOfSize:16];
    // 设置颜色
    titleView.textColor = [UIColor purpleColor];
    // 设置文字居中
    titleView.textAlignment = NSTextAlignmentCenter;
    // 设置文本
    titleView.text = title;
}

- (void)addBarbuttonItem:(NSString *)name image:(UIImage *)image target:(id)target action:(SEL)action isLeft:(BOOL)isLeft{

    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    // 给button设置title
    [button setTitle:name forState:UIControlStateNormal];
    
    // 设置图片
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    // 设置frame
    button.frame = CGRectMake(0, 0, 44, 30);
    
    // 判断是否放在左侧按钮
    if (isLeft) {
        
        self.navigationItem.leftBarButtonItem = item;
        
    }else{
    
        self.navigationItem.rightBarButtonItem = item;
    }
    
    
}



@end
