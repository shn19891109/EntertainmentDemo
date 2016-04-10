//
//  SHNAddTagViewController.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/4/9.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHNAddTagViewController : UIViewController
/**获取tags的block*/
@property (nonatomic,copy) void (^tagsBlock)(NSArray *tags);
/** 所有的标签 */
@property (nonatomic, strong) NSArray *tags;

@end
