//
//  SHNTagTextField.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/4/10.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHNTagTextField : UITextField

/** 按了删除键后的回调 */
@property (nonatomic,copy) void (^deleBlock)();
@end
