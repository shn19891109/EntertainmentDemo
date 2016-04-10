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
/** 添加按钮 */
@property (weak, nonatomic) UIButton *addButton;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;

@end

@implementation SHNAddTagToolBar
- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

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
    self.addButton = addButton;
    
    // 默认就拥有2个标签
    [self createTagLabels:@[@"吐槽", @"糗事"]];

}
#pragma mark --加号按钮点击---
- (void)addButtonClick
{
    SHNAddTagViewController *addVC = [[SHNAddTagViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    [addVC setTagsBlock:^(NSArray *tags) {
        [weakSelf createTagLabels:tags];
    }];
    addVC.tags = [self.tagLabels valueForKeyPath:@"text"];
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)rootVC.presentedViewController;
    [nav pushViewController:addVC animated:YES];
    
    // a modal 出 b
    //    [a presentViewController:b animated:YES completion:nil];
    //    a.presentedViewController -> b
    //    b.presentingViewController -> a
}
/**
 * 创建标签
 */
- (void)createTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i < tags.count; i++) {
        UILabel *tagLab = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLab];
        tagLab.backgroundColor = SHNTagBg;
        tagLab.textAlignment = NSTextAlignmentCenter;
        tagLab.text = tags[i];
        tagLab.font = [UIFont systemFontOfSize:14];
        //应该要先设置文字和字体后，在进行计算
        [tagLab sizeToFit];
        tagLab.width += 2 *SHNTopicTagMargin;
        tagLab.height = SHNTagH;
        tagLab.textColor = [UIColor whiteColor];
        [self.topView addSubview:tagLab];
        
//        //设置位置
//        if (i == 0) {
//            tagLab.x = 0;
//            tagLab.y = 0;
//        } else {
//            UILabel *lastTagLabel = self.tagLabels[i - 1];
//            //计算当前行左边的宽度
//            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SHNTopicTagMargin;
//            //计算当前行右边的宽度
//            CGFloat rightWidth = self.topView.width - leftWidth;
//            if (rightWidth >= tagLab.width) {
//                tagLab.y = lastTagLabel.y;
//                tagLab.x = leftWidth;
//            } else {
//                tagLab.x = 0;
//                tagLab.y = CGRectGetMaxY(lastTagLabel.frame)+ SHNTopicTagMargin;
//            }
//        }
    }
//    // 最后一个标签
//    UILabel *lastTagLabel = [self.tagLabels lastObject];
//    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SHNTopicTagMargin;
//    
//    // 更新textField的frame
//    if (self.topView.width - leftWidth >= self.addButton.width) {
//        self.addButton.y = lastTagLabel.y;
//        self.addButton.x = leftWidth;
//    } else {
//        self.addButton.x = 0;
//        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + SHNTopicTagMargin;
//    }
    //重新布局子控件
    [self setNeedsLayout];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SHNTopicTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) { // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + SHNTopicTagMargin;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + SHNTopicTagMargin;
    
    // 更新textField的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    } else {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + SHNTopicTagMargin;
    }
    
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldH;
}


@end
