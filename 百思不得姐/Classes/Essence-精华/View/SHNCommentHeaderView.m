//
//  SHNCommentHeaderView.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/27.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNCommentHeaderView.h"

@interface SHNCommentHeaderView ()
/** 文字标签 */
@property (nonatomic, weak) UILabel *label;

@end

@implementation SHNCommentHeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    SHNCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 缓存池中没有, 自己创建
        header = [[SHNCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SHNGlobalBg;
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textColor = SHNRGBColor(67, 67, 67);
        label.width = 200;
//        label.x = SHNTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.label.text = title;
}


@end
