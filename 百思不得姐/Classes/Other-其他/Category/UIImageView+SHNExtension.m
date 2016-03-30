//
//  UIImageView+SHNExtension.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/30.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "UIImageView+SHNExtension.h"
#import <UIImageView+WebCache.h>
#import "UIImage+SHNExtension.h"

@implementation UIImageView (SHNExtension)
- (void)setHeader:(NSString *)url {
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}
@end
