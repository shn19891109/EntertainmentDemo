//
//  SHNEssenceViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/24.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNEssenceViewController.h"
#import "SHNRecomendTagsController.h"
#import "SHNAllViewController.h"
#import "SHNVideoViewController.h"
#import "SHNVoiceViewController.h"
#import "SHNPictureViewController.h"
#import "SHNWordViewController.h"
@interface SHNEssenceViewController ()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;

/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;


@end

@implementation SHNEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏
    [self setUpNav];
    
    //初始化自控制器
    [self setupChildVCs];
    
    //设置顶部的标签栏
    [self setUpTitleView];

    //设置底部的scrollview
    [self setUpContentView];

 }


/**
 *  设置导航栏
 */
- (void)setUpNav {
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    //设置背景色
    self.view.backgroundColor = SHNGlobalBg;

}

/**
 *  初始化自控制器
 *
 */
- (void)setupChildVCs {
    SHNAllViewController *all = [[SHNAllViewController alloc] init];
    [self addChildViewController:all];
    
    SHNVideoViewController *video = [[SHNVideoViewController alloc] init];
    [self addChildViewController:video];
    
    SHNVoiceViewController *voice = [[SHNVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    SHNPictureViewController *picture = [[SHNPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    SHNWordViewController *word = [[SHNWordViewController alloc] init];
    [self addChildViewController:word];
}

/**
 *  设置顶部的标签栏
 */
- (void)setUpTitleView {
    //标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    self.titlesView = titlesView;
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    //底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.tag = -1;
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    //内部的字标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //[button layoutIfNeeded];   //强制布局(强制更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        //设置 disadle 转态可以防止按钮多次点击
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            //            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
        }

    }
    [titlesView addSubview:indicatorView];

}

/**
 *  底部的Scrollview
 */
- (void)setUpContentView {
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    
    self.contentView = contentView;
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
#pragma mark ---顶部标签栏点击
- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
    
}

- (void)tagClick {

    SHNRecomendTagsController *tags = [[SHNRecomendTagsController alloc] init];

    [self.navigationController pushViewController:tags animated:YES];
}
#pragma mark --- UIScrollViewDelegate---
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(如果是自己创建控制器的话 默认是20)
    vc.view.height = scrollView.height;// 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    
    //添加view到控制器上
    [scrollView addSubview:vc.view];

}
//滑动scrollview后会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //设置按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
