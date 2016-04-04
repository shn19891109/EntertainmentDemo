//
//  SHNPostViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/30.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNPostViewController.h"
#import "SHNPlaceHolderTextView.h"

@interface SHNPostViewController ()
/** 文本输入控件 */
@property (nonatomic, strong) SHNPlaceHolderTextView *textView;

@end

@implementation SHNPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    [self setupTextView];

}

- (void)setupTextView {
    
    SHNPlaceHolderTextView *textView = [[SHNPlaceHolderTextView alloc] init];
    textView.frame  = self.view.frame;
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    [self.view addSubview:textView];
    self.textView = textView;
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



- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    SHNLogFunc;
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
