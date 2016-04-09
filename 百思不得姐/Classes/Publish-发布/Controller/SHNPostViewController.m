//
//  SHNPostViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/30.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNPostViewController.h"
#import "SHNPlaceHolderTextView.h"
#import "SHNAddTagToolBar.h"

@interface SHNPostViewController ()<UITextViewDelegate>
/** 文本输入控件 */
@property (nonatomic, strong) SHNPlaceHolderTextView *textView;
/** 工具条 */
@property (nonatomic, weak) SHNAddTagToolBar *toolbar;

@end

@implementation SHNPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setupTextView];

    [self setupToolbar];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)setupTextView {
    
    SHNPlaceHolderTextView *textView = [[SHNPlaceHolderTextView alloc] init];
    textView.frame  = self.view.frame;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
    textView.delegate = self;
    [SHNNoteCenter addObserver:self selector:@selector(textViewDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)textViewDidChanged:(NSNotification *)noti {
    
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText ? YES : NO;
}
- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    // 强制刷新改变导航栏的字体颜色
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)setupToolbar {
    SHNAddTagToolBar *toolbar = [SHNAddTagToolBar viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    [SHNNoteCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}


- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    SHNLogFunc;
}

/**
 * 监听键盘的弹出和隐藏
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - SHNScreenH);
    }];
}
#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/*
 UITextField *textField默认的情况
 1.只能显示一行文字
 2.有占位文字
 
 UITextView *textView默认的情况
 2.能显示任意行文字
 2.没有占位文字
 
 文本输入控件,最终希望拥有的功能
 1.能显示任意行文字
 2.有占位文字
 
 最终的方案:
 1.继承自UITextView
 2.在UITextView能显示任意行文字的基础上,增加"有占位文字"的功能
 */


@end
