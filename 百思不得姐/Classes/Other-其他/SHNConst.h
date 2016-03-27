
//
//  SHNConst.h
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/6.
//  Copyright © 2016年 suhaonan. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum {
    SHNTopicTypeAll = 1,
    SHNTopicTypePicture = 10,
    SHNTopicTypeWord = 29,
    SHNTopicTypeVoice = 31,
    SHNTopicTypeVideo = 41
}SHNTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const SHNTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const SHNTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const SHNTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const SHNTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const SHNTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const SHNTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const SHNTopicCellPictureBreakH;

/** SHNUser模型-性别属性值 */
UIKIT_EXTERN NSString * const SHNUserSexMale;
UIKIT_EXTERN NSString * const SHNUserSexFemale;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const SHNTopicCellTopCmtTitleH;