//
//  AppListViewController.m
//  LimitFree
//
//  Created by 千锋 on 16/3/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "AppListViewController.h"

// 单元格复用的cell
#define CELL @"AppListCell"

@interface AppListViewController ()<UITableViewDataSource,UITableViewDelegate>

// 数据源数组。
@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) AFHTTPSessionManager * httpManager;// 数据请求管理对象、

@property (nonatomic,assign) NSInteger currentPage; // 记录当前页、

@end

@implementation AppListViewController


- (NSMutableArray *)dataArray{

    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (AFHTTPSessionManager *)httpManager{

    if (_httpManager == nil) {
        
        _httpManager = [[AFHTTPSessionManager alloc] init];
        
        _httpManager.responseSerializer.acceptableContentTypes = [_httpManager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    }
    return _httpManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customNavigationItem];
    
    [self createViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 创建视图
- (void)createViews{

    UITableView * tableView = [[UITableView alloc] init];
    
    [self.view addSubview:tableView];
    
    UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    tableView.tableHeaderView = searchBar;
    
    // 通过Masony建立约束
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        // 边距和self.view紧挨着、
        make.edges.equalTo(self.view);
        
    }];
    
    // 设置UITableView的dataSource和delegate
    
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    // 设置刷新
    
    __weak typeof(self) weakSelf = self;
    
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 下拉刷新
        weakSelf.currentPage = 1;
        [weakSelf requestApplistWithPage:weakSelf.currentPage searchText:weakSelf.searchText categoryID:weakSelf.categotyID];
    }];
    
    tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        // 上拉刷新、
        weakSelf.currentPage++;
        [weakSelf requestApplistWithPage:weakSelf.currentPage searchText:weakSelf.searchText categoryID:weakSelf.categotyID];
        
    }];
    // 第一次加载数据、
    [tableView.mj_header beginRefreshing];
    
    
}

#pragma mark -- 数据请求

- (void)requestApplistWithPage:(NSInteger) page searchText:(NSString *) searchText categoryID:(NSString *) cateID{

    // 拼接请求地址、
    NSString * url = [NSString stringWithFormat:self.requestURL,page,searchText == nil ? @"":searchText];
    if (cateID.length > 0) {
        
        url = [url stringByAppendingFormat:@"&cate_id=%@",cateID];
    }
    // 百分号编码、
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据
    
    [self.httpManager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


#pragma mark -- 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL forIndexPath:indexPath];
    
    return cell;
}



// 定制UINavigationItem
- (void)customNavigationItem{

    // 定制title
    [self addTitleViewWithTitle:self.title];
    
    // 定制左右按钮
    [self addBarbuttonItem:@"分类" image:[UIImage imageNamed:@"buttonbar_action"] target:self action:@selector(onLeftClicked:) isLeft:YES];
    
    [self addBarbuttonItem:@"设置" image:[UIImage imageNamed:@"buttonbar_action"] target:self action:@selector(onRightClicked:) isLeft:NO];
    
    
}
// 左侧按钮点击相应、
- (void)onLeftClicked:(UIButton *) sender{

    
}

// 右侧按钮点击响应
- (void)onRightClicked:(UIButton *) sender{

    
}



@end
