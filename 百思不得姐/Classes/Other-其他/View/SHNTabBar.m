//
//  SHNTabBar.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/24.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTabBar.h"
#import "SHNPublishView.h"

@interface SHNTabBar ()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;

@end


@implementation SHNTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:publishButton];
        self.publishButton = publishButton;

    }
    return self;
}
- (void)publishClick
{
    // 窗口级别
    // UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
    //窗口可以屏蔽点击事件
    
    //    window = [[UIWindow alloc] init];
    //    window.frame = CGRectMake(0, 0, 375, 20);
    //    window.backgroundColor = [UIColor yellowColor];
    //    window.windowLevel = UIWindowLevelStatusBar;
    //    window.hidden = NO;
    
    //    window2 = [[UIWindow alloc] init];
    //    window2.frame = CGRectMake(100, 100, 100, 100);
    //    window2.backgroundColor = [UIColor redColor];
    //    window2.hidden = NO;

//    SHNPublishView *publish = [SHNPublishView show];
//    //
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    publish.frame = window.bounds;
//    [window addSubview:publish];
    [SHNPublishView show];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;

    
    // 设置发布按钮的frame
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    // 设置其他UITabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        //        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;
        
        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
    }

}
@end
