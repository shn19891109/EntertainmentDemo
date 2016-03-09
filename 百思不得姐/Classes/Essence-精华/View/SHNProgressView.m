//
//  SHNProgressView.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/8.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNProgressView.h"

@implementation SHNProgressView

- (void)awakeFromNib {
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
