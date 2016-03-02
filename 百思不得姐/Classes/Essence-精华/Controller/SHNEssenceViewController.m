//
//  SHNEssenceViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/24.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNEssenceViewController.h"
#import "SHNRecomendTagsController.h"

@interface SHNEssenceViewController ()

@end

@implementation SHNEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景色
    self.view.backgroundColor = SHNGlobalBg;
    
}

- (void)tagClick {

    SHNRecomendTagsController *tags = [[SHNRecomendTagsController alloc] init];

    [self.navigationController pushViewController:tags animated:YES];
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
