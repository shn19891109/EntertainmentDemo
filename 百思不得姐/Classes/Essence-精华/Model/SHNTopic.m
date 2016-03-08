//
//  SHNTopic.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/6.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTopic.h"
#import <MJExtension.h>

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
             @"middle_image" : @"image2"
             };
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        //文件的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * SHNTopicCellMargin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        // cell的高度
        // 文字部分的高度
        _cellHeight = SHNTopicCellTextY + textH + SHNTopicCellMargin;
        // 根据段子的类型来计算cell的高度
        if (self.type == SHNTopicTypePicture) { // 图片帖子
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
        } else if (self.type == SHNTopicTypeVideo) {
        
        }
        //底部工具条的高度
        _cellHeight += SHNTopicCellBottomBarH + SHNTopicCellMargin;

    }
    return _cellHeight;
}


@end
