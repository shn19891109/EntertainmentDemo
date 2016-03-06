//
//  SHNRecomendViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/28.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNRecomendViewController.h"

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

#import <MJRefresh.h>


#import "SHNRecomendCategoryCell.h"
#import "SHNRecommendUserCell.h"
#import "SHNRecomendCatogory.h"
#import "SHNRecommendUser.h"

#define SHNSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface SHNRecomendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation SHNRecomendViewController
static NSString *const SHNCategoryId = @"category";
static NSString * const XMGUserId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 控件的初始化
    [self setupTableView];

    // 添加刷新控件
    [self setupRefresh];
    // 加载左侧的类别数据
    [self loadCategories];

    
//    self.title = @"推荐关注";
//    // 设置背景色
//    self.view.backgroundColor = SHNGlobalBg;
//    
//    //发送请求
//    // 显示指示器
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
//    // 发送请求
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"a"] = @"category";
//    params[@"c"] = @"subscribe";
//    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        // 隐藏指示器
//        [SVProgressHUD dismiss];
//        // 服务器返回的JSON数据
//        self.categories = [SHNRecomendCatogory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        // 刷新表格
//        [self.categoryTableView reloadData];
//
//        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        // 显示失败信息
//        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
//    }];

}
/**
 * 控件的初始化
 */
- (void)setupTableView
{
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHNRecomendCategoryCell class ]) bundle:nil] forCellReuseIdentifier:SHNCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHNRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XMGUserId];
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;

    // 设置标题
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = SHNGlobalBg;

}
/**
 * 加载左侧的类别数据
 */
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        // 服务器返回的JSON数据
        self.categories = [SHNRecomendCatogory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}
/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
//    self.userTableView.mj_footer.hidden = YES;
}
#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    SHNRecomendCatogory *rc = SHNSelectedCategory;
    // 设置当前页码为1
    rc.currentPage = 1;
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    // 发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [SHNRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 清除所有旧数据
        [rc.users removeAllObjects];
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        // 不是最后一次请求
        if (self.params != params) return;
        // 刷新右边的表格
        [self.userTableView reloadData];
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        // 让底部控件结束刷新
        [self checkFooterState];


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreUsers {
    SHNRecomendCatogory *category = SHNSelectedCategory;
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [SHNRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        // 不是最后一次请求
        if (self.params != params) return;
        // 刷新右边的表格
        [self.userTableView reloadData];
        // 让底部控件结束刷新
        [self checkFooterState];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}
/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    SHNRecomendCatogory *rc = SHNSelectedCategory;
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }

}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 左边的类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    // 监测footer的状态
    [self checkFooterState];

    // 右边的用户表格
    return [SHNSelectedCategory users].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) { // 左边的类别表格
        SHNRecomendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SHNCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;

    } else { // 右边的用户表格
        SHNRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGUserId];
        cell.user = [SHNSelectedCategory users][indexPath.row];
        return cell;
    }
}
#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    SHNRecomendCatogory *c = self.categories[indexPath.row];
    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    } else {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        
        // 进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

- (void)dealloc {
    [self.manager.operationQueue cancelAllOperations];
}
@end
