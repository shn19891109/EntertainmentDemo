//
//  SHNCommentCell.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/28.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNCommentCell.h"
#import "SHNComment.h"
#import <UIImageView+WebCache.h>
#import "SHNUser.h"
#import "UIImageView+SHNExtension.h"

@interface SHNCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation SHNCommentCell

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(SHNComment *)comment {
    _comment = comment;
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.profileImageView setHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:SHNUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }

}
- (void)setFrame:(CGRect)frame {

//    frame.origin.x = SHNTopicCellMargin;
//    frame.size.width -= 2 * SHNTopicCellMargin;
    
    [super setFrame:frame];
}

@end
