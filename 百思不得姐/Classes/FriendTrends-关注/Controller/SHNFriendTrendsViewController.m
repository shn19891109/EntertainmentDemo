//
//  SHNFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/24.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNFriendTrendsViewController.h"
#import "SHNRecomendViewController.h"
#import "SHNLoginRegisterViewController.h"

@interface SHNFriendTrendsViewController ()

@end

@implementation SHNFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    //设置背景色
    self.view.backgroundColor = SHNGlobalBg;

}
#pragma mark ---导航栏左边的按钮--
- (void)friendsClick
{
    SHNRecomendViewController *recomendVC = [[SHNRecomendViewController alloc] init];
    [self.navigationController pushViewController:recomendVC animated:YES];
}
#pragma mark --登录注册
- (IBAction)loginRegister:(UIButton *)sender {
    SHNLoginRegisterViewController *loginVC = [[SHNLoginRegisterViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
