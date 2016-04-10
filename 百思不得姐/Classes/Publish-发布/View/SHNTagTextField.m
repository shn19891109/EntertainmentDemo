//
//  SHNTagTextField.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/4/10.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTagTextField.h"

@implementation SHNTagTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.placeholder = @"多个标签用逗号或者换行隔开";
        // 设置了占位文字内容以后, 才能设置占位文字的颜色
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = SHNTagH;
    }
    return self;
}
// 也能在这个方法中监听键盘的输入，比如输入“换行”
//- (void)insertText:(NSString *)text
//{
//    [super insertText:text];
//
//    XMGLog(@"%d", [text isEqualToString:@"\n"]);
//}

- (void)deleteBackward {
    
    !self.deleBlock ? : self.deleBlock();
    [super deleteBackward];
}
@end
