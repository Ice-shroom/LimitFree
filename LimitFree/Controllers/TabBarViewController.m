//
//  TabBarViewController.m
//  LimitFree
//
//  Created by 千锋 on 16/3/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "TabBarViewController.h"
#import "AppListViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createViewControllers];
    
    [self customTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 创建子视图控制区
- (void)createViewControllers{

    // 读取plist文件内容
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"Controllers" ofType:@"plist"];
    // 通过数组读取plist文件的内容、
    NSArray * plistArray = [NSArray arrayWithContentsOfFile:plistPath];
    // 循环遍历数组 创建视图控制器、
    NSMutableArray * viewControllers = [NSMutableArray array];
    
    // 记录所有的请求地址
    NSArray * requestURLs = @[kLimitUrl,kReduceUrl,kFreeUrl,kSubjectUrl,kHotUrl];
    
    // 存储类型、
    NSArray * categroyTypes = @[kLimitType, kReduceType, kFreeType, kSubjectType,kHotType];
    
    for (NSDictionary * dict in plistArray) {
        
        NSString * className = dict[@"className"];
        NSString * title = dict[@"title"];
        NSString * iconName = dict[@"iconName"];
        // 通过类名获取类、
        Class class = NSClassFromString(className);
        // 通过类创建对象
        AppListViewController * vc = [[class alloc] init];
        
        vc.requestURL = requestURLs[[plistArray indexOfObject:dict]];
        
        vc.categoryType = categroyTypes[[plistArray indexOfObject:dict]];
        
        vc.title = title;
        
        UINavigationController * naviVc = [[UINavigationController alloc] initWithRootViewController:vc];
        
        
        // 普通状态图片
        UIImage * normarlImage = [UIImage imageNamed:iconName];
        
        // 选中图片
        UIImage * selectImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_press",iconName]];
        
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        UITabBarItem * tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normarlImage selectedImage:selectImage];
        // 设置UITabBarItem
        naviVc.tabBarItem = tabBarItem;
        
        
        // 定制UINavigationBar
        UINavigationBar * navigationBar = naviVc.navigationBar;
        
        [navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar"] forBarMetrics:UIBarMetricsDefault];
    
        // 将naviVc放到数组中
        [viewControllers addObject:naviVc];
        
        
    }
    
    self.viewControllers = viewControllers;
    
    
}

// 定制UITabBar
- (void)customTabBar{

    // 获取tabBar
    UITabBar * tabBar = self.tabBar;
    
    tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    
    // 获取到所有视图控制器、
    
    NSArray * ViewControllers = self.viewControllers;
    
    
    [ViewControllers enumerateObjectsUsingBlock:^(UINavigationController * navi, NSUInteger idx, BOOL * _Nonnull stop) {

        
    }];

    
    
}






@end
