//
//  SHNPushGuideView.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/5.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNPushGuideView.h"

@implementation SHNPushGuideView

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)showView {
    
    NSString *key = @"CFBundleShortVersionString";
    //获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获得沙盒中存储的版本号
    NSString *sandersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![currentVersion isEqualToString:sandersion]) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        SHNPushGuideView *guideView = [SHNPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (IBAction)close:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
