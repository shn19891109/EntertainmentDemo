//
//  UIView+SHNExtension.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/2/24.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (SHNExtension)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)isShowingOnKeyWindow;

/** 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和带有_下划线的成员变量*/
//只会声明set与get方法
//- (CGFloat)x;
//- (void)setX:(CGFloat)x;

@end
