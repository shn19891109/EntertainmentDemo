//
//  SHNTabViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/23.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTabViewController.h"
#import "SHNEssenceViewController.h"
#import "SHNNewViewController.h"
#import "SHNFriendTrendsViewController.h"
#import "SHNMeViewController.h"
#import "SHNTabBar.h"
@interface SHNTabViewController ()

@end

@implementation SHNTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //防止图片被重新渲染的方法
    //    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    vc01.tabBarItem.selectedImage = image;

    
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置(例如 [UINavigationBar appearance])
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];

 
    
    // 添加子控制器
    [self setupChildVc:[[SHNEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[SHNNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[SHNFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[SHNMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换tabBar(通过KVC更改系统的)
    //    self.tabBar = [[SHNTabBar alloc] init];
    [self setValue:[[SHNTabBar alloc] init] forKeyPath:@"tabBar"];
    
}
/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
    // 包装一个导航控制器，添加导航控制器为tabbarcontroller为子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
