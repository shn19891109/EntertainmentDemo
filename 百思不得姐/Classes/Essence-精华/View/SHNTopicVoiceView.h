//
//  SHNTopicVoiceView.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/15.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHNTopic;

@interface SHNTopicVoiceView : UIView
+ (instancetype)voiceView;
/** 帖子数据 */
@property (nonatomic, strong) SHNTopic *topic;

@end
