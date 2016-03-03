//
//  SHNLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 苏浩楠 on 16/3/3.
//  Copyright © 2016年 suhaonan. All rights reserved.
//

#import "SHNLoginRegisterViewController.h"

@interface SHNLoginRegisterViewController ()
/** 登录框距离控制器view左边的间距 */



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@end

@implementation SHNLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)showLoginOrRegister:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { //显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
        sender.selected = YES;
    } else {
        self.loginViewLeftMargin.constant = 0;
        sender.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        //如果让约束做动画，需要调用才可以做动画
        [self.view layoutIfNeeded];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
