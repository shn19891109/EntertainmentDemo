//
//  SHNPlaceHolderTextView.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/30.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHNPlaceHolderTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;

@end
