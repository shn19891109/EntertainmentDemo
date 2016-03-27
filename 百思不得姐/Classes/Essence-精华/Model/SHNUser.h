//
//  SHNUser.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/27.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHNUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
