//
//  SHNRecommendTag.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/1.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHNRecommendTag : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
