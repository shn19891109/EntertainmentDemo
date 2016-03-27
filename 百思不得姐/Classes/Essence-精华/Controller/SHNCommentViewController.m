//
//  SHNCommentViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/27.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNCommentViewController.h"
#import "SHNTopicCell.h"
#import "SHNTopic.h"
#import "SHNCommentHeaderView.h"

#import "SHNComment.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
@interface SHNCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;
/** 保存帖子的top_cmt */
@property (nonatomic, strong) SHNComment *saved_top_cmt;

@end

@implementation SHNCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    [self setupHeader];
    [self setupRefresh];


}
- (void)setupBasic {
    self.title = @"评论";

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = SHNGlobalBg;
}

- (void)setupHeader {
    //创建header
    UIView *header = [[UIView alloc] init];
    
    // 清空top_cmt
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    //添加cell(cell内部设置了frame，所以外面设置cell的高度没影响，可以把cell包装一层view,再设置view的高度)
    SHNTopicCell *cell = [SHNTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(SHNScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.height = self.topic.cellHeight + SHNTopicCellMargin;
    
    // 设置header
    self.tableView.tableHeaderView = header;

}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewComments {
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        self.hotComments = [SHNComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        // 最新评论
        self.latestComments = [SHNComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];


}

- (void)keyboardWillChangeFrame:(NSNotification *)note {
    //键盘显示/隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    //修改底部约束
    self.bottomSapce.constant = SHNScreenH - frame.origin.y;
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //恢复帖子的top——cmt
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
}

#pragma mark --UITableViewDataSource--

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (hotCount) {
        return 2; // 有"最热评论" + "最新评论" 2组
    }
    if (latestCount) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    //非第0组
    return latestCount;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    // 创建头部
//    UIView *header = [[UIView alloc] init];
//    header.backgroundColor = XMGGlobalBg;
//
//    // 创建label
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = XMGRGBColor(67, 67, 67);
//    label.width = 200;
//    label.x = XMGTopicCellMargin;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [header addSubview:label];
//
//    // 设置文字
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//
//    return header;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *ID = @"header";
//    // 先从缓存池中找header
//    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
//
//    // 内部的一个label
//    UILabel *label = nil;
//
//    if (header == nil) { // 缓存池中没有, 自己创建
//        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
//        header.contentView.backgroundColor = XMGGlobalBg;
//        // 创建label
//        label = [[UILabel alloc] init];
//        label.textColor = XMGRGBColor(67, 67, 67);
//        label.width = 200;
//        label.x = XMGTopicCellMargin;
//        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        label.tag = XMGHeaderLabelTag;
//        [header.contentView addSubview:label];
//    } else { // 从缓存池中取出来的
//        label = (UILabel *)[header viewWithTag:XMGHeaderLabelTag];
//    }
//
//    // 设置label的数据
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) {
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    } else {
//        label.text = @"最新评论";
//    }
//
//    return header;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 先从缓存池中找header
    SHNCommentHeaderView *header = [SHNCommentHeaderView headerViewWithTableView:tableView];
    //设置label数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    SHNComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;

    return cell;
    
}
#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (SHNComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

@end
