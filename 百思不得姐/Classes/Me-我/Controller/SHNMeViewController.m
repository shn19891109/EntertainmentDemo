//
//  SHNMeViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/24.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNMeViewController.h"
#import "SHNMeViewCell.h"
#import "SHNMeFooterView.h"
#import "SHNSettingViewController.h"

@interface SHNMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SHNMeViewController

static NSString *SHNMeId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    [self setupTableView];
 
    
}
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}
- (void)setupTableView
{
    // 设置背景色
    self.tableView.backgroundColor = SHNGlobalBg;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[SHNMeViewCell class] forCellReuseIdentifier:SHNMeId];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = SHNTopicCellMargin;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 调整inset
    self.tableView.contentInset = UIEdgeInsetsMake(SHNTopicCellMargin - 35, 0, 0, 0);
    
    // 设置footerView
    self.tableView.tableFooterView = [[SHNMeFooterView alloc] init];

}
#pragma mark --设置按钮点击--
- (void)settingClick
{
    SHNSettingViewController *settingVC = [[SHNSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)moonClick
{
    SHNLogFunc;
}

#pragma mark ---数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHNMeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHNMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}


@end
