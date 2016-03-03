//
//  SHNTextField.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/3.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTextField.h"
static NSString * const SHNPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation SHNTextField


- (void)awakeFromNib {
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当前文本框聚焦时就会调用(可以重写此方法自定义文本框聚焦时文本的颜色)
 */
- (BOOL)becomeFirstResponder {
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:SHNPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}
/**
 * 当前文本框失去焦点时就会调用
 */
- (BOOL)resignFirstResponder {
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:SHNPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}


@end
