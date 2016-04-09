//
//  SHNAddTagToolBar.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/4/9.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNAddTagToolBar.h"
#import "SHNAddTagViewController.h"

@interface SHNAddTagToolBar ()
/** 顶部控件 */
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation SHNAddTagToolBar

- (void)awakeFromNib
{
    // 添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //获取当前按钮的图片
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    //    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
    //    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = SHNTopicCellMargin;
    [self.topView addSubview:addButton];
}

- (void)addButtonClick
{
    SHNAddTagViewController *addVC = [[SHNAddTagViewController alloc] init];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:addVC animated:YES];
    
    // a modal 出 b
    //    [a presentViewController:b animated:YES completion:nil];
    //    a.presentedViewController -> b
    //    b.presentingViewController -> a
}

@end
