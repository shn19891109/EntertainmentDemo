//
//  SHNTopicPictureView.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/8.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNTopicPictureView.h"
#import "SHNProgressView.h"
#import <UIImageView+WebCache.h>
#import "SHNShowPictureViewController.h"

#import "SHNTopic.h"

@interface SHNTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件 */
@property (weak, nonatomic) IBOutlet SHNProgressView *progressView;

@end

@implementation SHNTopicPictureView
+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    //防止通过xib创建的view自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}
- (void)showPicture
{
    SHNShowPictureViewController *showPicture = [[SHNShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(SHNTopic *)topic {
    _topic = topic;
    
    // 立马显示最新的进度值(防止因为网速慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.pictureProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        
        
        
    }];
    
    // 判断是否为gif(还可以根据返回的第一个字节判断是否是gif图片)
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }

}
@end
