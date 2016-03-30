//
//  SHNComment.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/27.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SHNUser;

@interface SHNComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 音频文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;
/** 用户 */
@property (nonatomic, strong) SHNUser *user;

@end
