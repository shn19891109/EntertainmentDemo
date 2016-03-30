//
//  SHNRecommendUserCell.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/1.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNRecommendUserCell.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+SHNExtension.h"
#import "SHNRecommendUser.h"

@interface SHNRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end

@implementation SHNRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setUser:(SHNRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    } else { // 大于等于10000
        fansCount = [NSString stringWithFormat:@"%.1f万人关注", user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
//    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.headerImageView setHeader:user.header];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
