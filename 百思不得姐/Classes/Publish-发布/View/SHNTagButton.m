//
//  SHNTagButton.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/4/9.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTagButton.h"

@implementation SHNTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = SHNTagBg;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.width += 3 * SHNTopicTagMargin;
    self.height = SHNTagH;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = SHNTopicTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + SHNTopicTagMargin;
}

@end
