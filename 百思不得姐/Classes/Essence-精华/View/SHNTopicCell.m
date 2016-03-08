//
//  SHNTopicCell.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/6.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTopicCell.h"
#import "SHNTopic.h"
#import "SHNTopicPictureView.h"
#import <UIImageView+WebCache.h>

@interface SHNTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) SHNTopicPictureView *pictureView;

@end

@implementation SHNTopicCell

- (SHNTopicPictureView *)pictureView {
    if (!_pictureView) {
        SHNTopicPictureView *pictureView = [SHNTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

//添加背景图片
- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}
/**
 今年
 今天
 1分钟内
 刚刚
 1小时内
 xx分钟前
 其他
 xx小时前
 昨天
 昨天 18:56:34
 其他
 06-23 19:56:23
 
 非今年
 2014-05-08 18:45:30
 */

- (void)setTopic:(SHNTopic *)topic {
    _topic = topic;
    //新浪加V
    self.sinaView.hidden = !topic.isSina_v;
    
    //设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置名字
    self.nameLabel.text = topic.name;
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    // 根据模型类型(帖子类型)添加对应的内容到cell的中间
    if (topic.type == SHNTopicTypePicture) {
        self.pictureView.frame = topic.pictureF; // 图片帖子
        self.pictureView.topic = topic;
    } else if (topic.type == SHNTopicTypeVoice) { // 声音帖子
    
    }
}
/**
 *  设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1ld万",count / 10000];
    } else if (count >0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}


//处理cell分割线的方法
- (void)setFrame:(CGRect)frame {
    
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2*margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    [super setFrame:frame];
    
}
@end
