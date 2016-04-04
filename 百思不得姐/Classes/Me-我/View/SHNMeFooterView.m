//
//  SHNMeFooterView.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/30.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNMeFooterView.h"
#import "SHNSqaureButton.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "SHNSquare.h"
#import "SHNWebViewController.h"

@implementation SHNMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 发送请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
            NSArray *sqaures = [SHNSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 创建方块
            [self createSquares:sqaures];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    return self;
}
/**
 * 创建方块
 */
- (void)createSquares:(NSArray *)sqaures
{
    // 一行最多4列
    int maxCols = 4;
    
    // 宽度和高度
    CGFloat buttonW = SHNScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<sqaures.count; i++) {
        // 创建按钮
        SHNSqaureButton *button = [SHNSqaureButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = sqaures[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    
    // 8个方块, 每行显示4个, 计算行数 8/4 == 2 2
    // 9个方块, 每行显示4个, 计算行数 9/4 == 2 3
    // 7个方块, 每行显示4个, 计算行数 7/4 == 1 2
    
    // 总行数
    //    NSUInteger rows = sqaures.count / maxCols;
    //    if (sqaures.count % maxCols) { // 不能整除, + 1
    //        rows++;
    //    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    NSUInteger rows = (sqaures.count + maxCols - 1) / maxCols;
    
    // 计算footer的高度
    self.height = rows * buttonH;
    // 重新设置footerView
    UITableView *tableView = (UITableView *)self.superview;
    //    tableView.tableFooterView = self;
    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));

//    // 重绘
    [self setNeedsDisplay];
}
- (void)buttonClick:(SHNSqaureButton *)button {

    if (![button.square.url hasPrefix:@"http"]) {
        return;
    }
    SHNWebViewController *web = [[SHNWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    //取出当前的导航控制器
    UITabBarController *tabbarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabbarVC.selectedViewController;
    [nav pushViewController:web animated:YES];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
//- (void)drawRect:(CGRect)rect {
//
//}


@end
