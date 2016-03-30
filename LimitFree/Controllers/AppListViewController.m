//
//  AppListViewController.m
//  LimitFree
//
//  Created by 千锋 on 16/3/29.
//  Copyright © 2016年 1000phone. All rights reserved.
//

#import "AppListViewController.h"
#import "AppListModel.h"
#import "ApplistCell.h"
#import "SearchViewController.h"

// 单元格复用的cell
#define CELL @"AppListCell"

@interface AppListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

// 数据源数组。
@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) AFHTTPSessionManager * httpManager;// 数据请求管理对象、

@property (nonatomic,assign) NSInteger currentPage; // 记录当前页、

@property (nonatomic,strong) UITableView * appListTableView; // 显示app列表的表格视图、

@property (nonatomic,strong) UISearchBar * searchBar; // 搜索栏、

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

    _appListTableView = [[UITableView alloc] init];
    
    // 注册单元格、
    [_appListTableView registerNib:[UINib nibWithNibName:@"ApplistCell" bundle:nil] forCellReuseIdentifier:CELL];
    
    // 注册行高、
    _appListTableView.rowHeight = 130;
    
    
    [self.view addSubview:_appListTableView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _appListTableView.tableHeaderView = _searchBar;
    
    // 配置UISearchBar
    // 设置占位文字、
    _searchBar.placeholder = @"百万应用等你来搜哟！";
    // 设置委托
    _searchBar.delegate = self;
    
    
    
    
    // 通过Masony建立约束
    _appListTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_appListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        // 边距和self.view紧挨着、
        make.edges.equalTo(self.view);
        
    }];
    
    // 设置UITableView的dataSource和delegate
    
    _appListTableView.dataSource = self;
    
    _appListTableView.delegate = self;
    
    // 设置刷新
    
    __weak typeof(self) weakSelf = self;
    
    _appListTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 下拉刷新
        weakSelf.currentPage = 1;
        [weakSelf requestApplistWithPage:weakSelf.currentPage searchText:weakSelf.searchText categoryID:weakSelf.categotyID];
        
        // 禁用footer
        weakSelf.appListTableView.mj_footer.hidden = YES;
        
        
    }];
    
    _appListTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        // 上拉刷新、
        weakSelf.currentPage++;
        [weakSelf requestApplistWithPage:weakSelf.currentPage searchText:weakSelf.searchText categoryID:weakSelf.categotyID];
        
        // 禁用header
        weakSelf.appListTableView.mj_header.hidden = YES;
        
        
    }];
    // 第一次加载数据、
    [_appListTableView.mj_header beginRefreshing];
    
    
}

#pragma mark -- 数据请求

- (void)requestApplistWithPage:(NSInteger) page searchText:(NSString *) searchText categoryID:(NSString *) cateID{

    __weak typeof(self) weakSelf = self;

    // 拼接请求地址、
    NSString * url = [NSString stringWithFormat:self.requestURL,page,searchText == nil ? @"":searchText];
    if (cateID.length > 0) {
        
        url = [url stringByAppendingFormat:@"&cate_id=%@",cateID];
    }
    // 百分号编码、
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 请求数据
    
    [self.httpManager GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 将字典转换为模型数据、
        AppListModel * listModel = [AppListModel yy_modelWithJSON:responseObject];
        if (page == 1) {
            
            // 移除所有的数据、
            [weakSelf.dataArray removeAllObjects];
        }
        // 将新请求的数据添加到数据源中、
        [weakSelf.dataArray addObjectsFromArray:listModel.applications];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            // 停止刷新
            [weakSelf.appListTableView.mj_header endRefreshing];
            
            [weakSelf.appListTableView.mj_footer endRefreshing];
            
            // 解禁footer和header
            
            weakSelf.appListTableView.mj_header.hidden = NO;
            
            weakSelf.appListTableView.mj_footer.hidden = NO;
            
            
            // 判断数据是否加载完成、
            if (weakSelf.dataArray.count >= [listModel.totalCount integerValue]) {
                
                // 表示没有数据可以请求 设置UITableView footer的状态、
                [weakSelf.appListTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
                // 重置提示没有更多数据、
                [weakSelf.appListTableView.mj_footer resetNoMoreData];
            }
            
            // 刷新数据
            [weakSelf.appListTableView reloadData];

            
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (weakSelf.currentPage > 1) {
            
            weakSelf.currentPage--;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.labelText = error.localizedDescription;
            
            [hud hide:YES afterDelay:2];
            
        });
        
        
        NSLog(@"%@",error);
    }];
    
}


#pragma mark -- 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ApplistCell * cell = [tableView dequeueReusableCellWithIdentifier:CELL forIndexPath:indexPath];
    
    // 获取indexPath的模型数据、
    ApplicationsModel * model = self.dataArray[indexPath.row];
    
    cell.model = model;
    
    
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
#pragma mark -- UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    NSString * searchText = searchBar.text;
    if (searchText.length > 0) {
        
        // 创建搜索页面
        SearchViewController * searchVC = [[SearchViewController alloc] init];
        
        searchVC.requestURL = self.requestURL;
        
        searchVC.categotyID = self.categotyID;
        
        searchVC.categoryType = self.categoryType;
        
        searchVC.searchText = self.searchText;
        
        searchVC.title = searchText;
        
        // 隐藏TabBar
        searchVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:searchVC animated:YES];
        
    }

}



// 左侧按钮点击相应、
- (void)onLeftClicked:(UIButton *) sender{

    
}

// 右侧按钮点击响应
- (void)onRightClicked:(UIButton *) sender{

    
}



@end
