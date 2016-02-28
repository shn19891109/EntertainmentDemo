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

#import "SHNRecomendCategoryCell.h"
#import "SHNRecomendCatogory.h"
@interface SHNRecomendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;

@end

@implementation SHNRecomendViewController
static NSString *const SHNCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHNRecomendCategoryCell class ]) bundle:nil] forCellReuseIdentifier:SHNCategoryId];
    
    self.title = @"推荐关注";
    // 设置背景色
    self.view.backgroundColor = SHNGlobalBg;
    
    //发送请求
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        // 服务器返回的JSON数据
        self.categories = [SHNRecomendCatogory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.categoryTableView reloadData];

        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];

}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHNRecomendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SHNCategoryId];
    cell.category = self.categories[indexPath.row];
    return cell;
}



@end
