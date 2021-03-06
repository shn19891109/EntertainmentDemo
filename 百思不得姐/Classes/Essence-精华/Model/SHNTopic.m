//
//  SHNTopic.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/6.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTopic.h"
#import <MJExtension.h>

#import "SHNComment.h"
#import "SHNUser.h"
@implementation SHNTopic
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

- (NSString *)create_time {
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { //今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { //其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { //非今年
        return _create_time;
    }
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"    //直接映射为模型
             // @"qzone_uid" : @"top_cmt[0].user.qzone_uid"  //把user中的qzone_uid属性映射为模型的qzone_uid
             };
}
//+ (NSDictionary *)mj_objectClassInArray {
////    return @{@"top_cmt" : [SHNComment class]};
//    return @{@"top_cmt" : @"SHNComment"};
//
//}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        //文件的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2 * SHNTopicCellMargin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // cell的高度
        // 文字部分的高度
        _cellHeight = SHNTopicCellTextY + textH + SHNTopicCellMargin;
        // 根据段子的类型来计算cell的高度
        if (self.type == SHNTopicTypePicture) { // 图片帖子
            //排除宽度或高度为0
            if (self.width != 0 && self.height!= 0) {
                // 图片显示出来的宽度
                CGFloat pictureW = maxSize.width;
                // 显示显示出来的高度
                CGFloat pictureH = pictureW *self.height /self.width;
                if (pictureH >= SHNTopicCellPictureMaxH) {
                    pictureH = SHNTopicCellPictureBreakH;
                    self.bigPicture = YES;   //大图
                }
                // 计算图片控件的frame
                CGFloat pictureX = SHNTopicCellMargin;
                CGFloat pictureY = SHNTopicCellTextY + textH + SHNTopicCellMargin;
                _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                
                _cellHeight += pictureH + SHNTopicCellMargin;

            }
         } else if (self.type == SHNTopicTypeVoice) { // 声音帖子
            
            CGFloat voiceX = SHNTopicCellMargin;
            CGFloat voiceY = SHNTopicCellTextY + textH + SHNTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellHeight += voiceH + SHNTopicCellMargin;

        } else if (self.type == SHNTopicTypeVideo) { // 视频帖子
            CGFloat videoX = SHNTopicCellMargin;
            CGFloat videoY = SHNTopicCellTextY + textH + SHNTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + SHNTopicCellMargin;

        }
        // 如果有最热评论
        SHNComment *cmt = self.top_cmt;
        if (cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", cmt.user.username, cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += SHNTopicCellTopCmtTitleH + contentH + SHNTopicCellMargin;

        }
        //底部工具条的高度
        _cellHeight += SHNTopicCellBottomBarH + SHNTopicCellMargin;

    }
    return _cellHeight;
}


@end
