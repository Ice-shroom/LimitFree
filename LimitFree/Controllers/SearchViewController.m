//
//  SearchViewController.m
//  LimitFree
//
//  Created by 千锋 on 16/3/30.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 重写定制方法

- (void)customNavigationItem{

    [self addTitleViewWithTitle:self.title];
    
    [self addBarbuttonItem:@"返回" image:[UIImage imageNamed:@"buttonbar_back"] target:self action:@selector(onBachAction) isLeft:YES];
    
}

- (void)onBachAction{

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}










@end
