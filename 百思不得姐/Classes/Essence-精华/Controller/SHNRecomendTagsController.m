//
//  SHNRecomendTagsController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/1.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNRecomendTagsController.h"

#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import "SHNRecommendTag.h"

#import "SHNRecommendTagCell.h"

@interface SHNRecomendTagsController ()
/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;

@end
static NSString * const SHNTagsId = @"tag";

@implementation SHNRecomendTagsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self loadTags];

}
- (void)loadTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        self.tags = [SHNRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
    }];
}

- (void)setupTableView
{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SHNRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:SHNTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = SHNGlobalBg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHNRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:SHNTagsId];
    
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}

@end
