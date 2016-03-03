//
//  SHNVerticalButton.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/3.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNVerticalButton.h"

@implementation SHNVerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}
- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;

}
@end
