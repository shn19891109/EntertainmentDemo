//
//  SHNAddTagViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/4/9.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNAddTagViewController.h"
#import "SHNTagButton.h"
#import "SHNTagTextField.h"

#import <SVProgressHUD.h>

@interface SHNAddTagViewController ()<UITextFieldDelegate>
/** 内容 */
@property (nonatomic, weak) UIView *contentView;
/** 文本输入框 */
@property (nonatomic, weak) SHNTagTextField *textField;
/** 添加按钮 */
@property (nonatomic, weak) UIButton *addButton;
/** 所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation SHNAddTagViewController
#pragma mark --懒加载--
- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = 35;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = [UIFont systemFontOfSize:14];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, SHNTopicTagMargin, 0, SHNTopicTagMargin);
        // 让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = SHNRGBColor(74, 139, 209);
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}
- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        [self.view addSubview:contentView];
        self.contentView = contentView;
    }
    return _contentView;
}
- (SHNTagTextField *)textField {
    if (!_textField) {
        __weak typeof(self) weakSelf = self;
        SHNTagTextField *textField = [[SHNTagTextField alloc] init];
        textField.width =  self.contentView.width;
        textField.deleBlock = ^{
            if (weakSelf.textField.hasText) {
                return;
            }
            [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
        };
        //    textField.height = 25;
        textField.delegate = self;
        //    textField.placeholder = @"多个标签用逗号或者换行隔开";
        //    //设置了占位文字内容以后，才能设置占位文字的颜色
        //    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        //UITextField监听文字变化一般用方法或者通知，不用代理
        [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
        [textField becomeFirstResponder];
        [self.contentView addSubview:textField];
        self.textField = textField;
    }
    return _textField;
}
#pragma mark --初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
//    [self setupContentView];
//    
//    [self setupTextFiled];
//    
//    [self setupTags];

}
#pragma mark --初始化标签---
- (void)setupTags
{
    for (NSString *tag in self.tags) {
        self.textField.text = tag;
        [self addButtonClick];
    }
    self.tags = nil;
}

//- (void)setupContentView
//{
//    UIView *contentView = [[UIView alloc] init];
//    contentView.x = SHNTopicTagMargin;
//    contentView.width = self.view.width - 2 * contentView.x;
//    contentView.y = 64 +  SHNTopicTagMargin;
//    contentView.height =  SHNScreenH;
//    [self.view addSubview:contentView];
//    self.contentView = contentView;
//}
//
//- (void)setupTextFiled
//{
//    __weak typeof(self) weakSelf = self;
//    SHNTagTextField *textField = [[SHNTagTextField alloc] init];
//    textField.width =  self.contentView.width;
//    textField.deleBlock = ^{
//        if (weakSelf.textField.hasText) {
//            return;
//        }
//        [weakSelf tagButtonClick:[weakSelf.tagButtons lastObject]];
//    };
////    textField.height = 25;
//    textField.delegate = self;
////    textField.placeholder = @"多个标签用逗号或者换行隔开";
////    //设置了占位文字内容以后，才能设置占位文字的颜色
////    [textField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
//
//    //UITextField监听文字变化一般用方法或者通知，不用代理
//    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
//    [textField becomeFirstResponder];
//    [self.contentView addSubview:textField];
//    self.textField = textField;
//}

- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

#pragma mark --完成按钮点击--
- (void)done
{
    //传递数据给上一个控制器
//    NSMutableArray *tags = [NSMutableArray array];
//    for (SHNTagButton *tagButton in self.tagButtons) {
//        [tags addObject:tagButton.currentTitle];
//    }
    NSArray *tags = [self.tagButtons valueForKeyPath:@"currentTitle"];
    !self.tagsBlock ? : self.tagsBlock(tags);
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 * 布局控制器view的子控件
 */
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.contentView.x = SHNTopicTagMargin;
    self.contentView.width = self.view.width - 2 * self.contentView.x;
    self.contentView.y = 64 + SHNTopicTagMargin;
    self.contentView.height = SHNScreenH;
    
    self.textField.width = self.contentView.width;
    
    self.addButton.width = self.contentView.width;
    
    [self setupTags];
}


#pragma mark --监听文字改变--
/**
 * 监听文字改变
 */
- (void)textDidChange
{
    // 更新文本框的frame
    [self updateTextFieldFrame];

    if (self.textField.hasText) { // 有文字
        // 显示"添加标签"的按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + SHNTopicTagMargin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
        //获得最后一个字符
        NSString *text = self.textField.text;
        NSUInteger len = text.length;
        NSString *lastLetter = [text substringFromIndex:len -1];
        if ([lastLetter isEqualToString:@","] || [lastLetter isEqualToString:@"，"]) {
            //去除逗号
            self.textField.text = [text substringToIndex:len - 1];
            [self addButtonClick];
        }
        
    } else { // 没有文字
        // 隐藏"添加标签"的按钮
        self.addButton.hidden = YES;
    }
}
/**
 * 监听"添加标签"按钮点击
 */
- (void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    // 添加一个"标签按钮"
    SHNTagButton *tagButton = [SHNTagButton buttonWithType:UIButtonTypeCustom];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    //更新标签按钮的frame
    [self updateTagButtonFrame];
    // 更新文本框的frame
    [self updateTextFieldFrame];

    //清空textfield文字
    self.textField.text = nil;
    self.addButton.hidden = YES;
}
/**
 *  标签按钮的点击
 */
- (void)tagButtonClick:(SHNTagButton *)tagButton {
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    //更新所有标签按钮的frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        // 更新文本框的frame
        [self updateTextFieldFrame];
    }];
}

/**
 * 专门用来更新标签按钮的frame
 */
- (void)updateTagButtonFrame
{
    //更新标签按钮的frame
    for (int i = 0; i < self.tagButtons.count; i++) {
        UIButton *tagButton = self.tagButtons[i];
        
        if (i == 0) { // 最前面的标签按钮
            tagButton.x = 0;
            tagButton.y = 0;
        } else { //其他标签按钮
            UIButton *lastTagButton = self.tagButtons[i - 1];
            //计算当前左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + SHNTopicTagMargin;
            //计算当前右边的宽度
            CGFloat rightWidth = self.contentView.width - leftWidth;
            if (rightWidth >= tagButton.width) {
                tagButton.y = lastTagButton.y;
                tagButton.x = leftWidth;
            } else {  //按钮显示在下一行
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + SHNTopicTagMargin;
            }
        }
    }
}
/**
 * 更新textField的frame
 */
- (void)updateTextFieldFrame {
    //最后一个标签按钮
    SHNTagButton *lastButton = [self.tagButtons lastObject];
    //左边的宽度
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame) + SHNTopicTagMargin;
    
    //更新textField的frame
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.y = lastButton.y;
        self.textField.x = CGRectGetMaxX(lastButton.frame) + SHNTopicTagMargin;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastButton.frame) + SHNTopicTagMargin;
    }
}
/**
 *  textfield的文字宽度
 */
- (CGFloat)textFieldTextWidth {
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    return MAX(100, textW);
}
#pragma mark - <UITextFieldDelegate>
/**
 *  监听键盘最右下角按钮的点击(return key，比如换行，完成等)
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}


@end
