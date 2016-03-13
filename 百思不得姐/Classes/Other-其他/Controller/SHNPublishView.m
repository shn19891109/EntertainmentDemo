//
//  SHNPublishView.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/10.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNPublishView.h"
#import <POP.h>
#import "SHNVerticalButton.h"

static CGFloat const SHNAnimationDelay = 0.1;
static CGFloat const SHNSpringFactor = 10;

@interface SHNPublishView ()

@end

@implementation SHNPublishView

static UIWindow *window_;

+ (instancetype)publishView;
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show
{
    // 创建窗口
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    window_.hidden = NO;
    
    // 添加发布界面
    SHNPublishView *publishView = [SHNPublishView publishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

- (void)awakeFromNib {
    //在动画结束前禁止点击
    self.userInteractionEnabled = NO;
    
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (SHNScreenH - 2*buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (SHNScreenW - 2*buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i < images.count; i++) {
        SHNVerticalButton *button = [[SHNVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];

        //计算X，Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row *buttonH;
        //动画开始的位置
        CGFloat buttonBeginY = buttonEndY - SHNScreenH;
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW,buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = SHNSpringFactor;
        anim.springSpeed = SHNSpringFactor;
        anim.beginTime = CACurrentMediaTime() + i*SHNAnimationDelay;
        [button pop_addAnimation:anim forKey:nil];
    }
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    //标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = SHNScreenW *0.5;
    CGFloat centerEndY = SHNScreenH *0.2;
    CGFloat centerBeginY = centerEndY - SHNScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springBounciness = SHNSpringFactor;
    anim.springSpeed = SHNSpringFactor;
    anim.beginTime = CACurrentMediaTime() + images.count *SHNAnimationDelay;
    [anim setCompletionBlock:^(POPAnimation *anim,BOOL finish) {
        //标语动画结束，回复点击
//        self.userInteractionEnabled = YES;
        // 销毁窗口
        window_ = nil;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}

#pragma mark --按钮点击--
- (void)buttonClick:(UIButton *)sender {

    [self cancelWithCompletetionBlock:^{
        if (sender.tag == 0) {
            SHNLog(@"发视频");
        } else if (sender.tag == 1) {
            SHNLog(@"发图片");
        }
    }];
}

#pragma mark ---取消按扭点击--
- (IBAction)cancel{
    [self cancelWithCompletetionBlock:nil];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletetionBlock:(void(^)())completionBlock {
    
    //不能被点击
    self.userInteractionEnabled = NO;
    int beginIndex = 1;

    for (int i = beginIndex; i<self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        //基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        ;
        CGFloat centerY = subView.centerY + SHNScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * SHNAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        
        //监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *ani, BOOL finished) {
                //执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithCompletetionBlock:nil];
}



@end
