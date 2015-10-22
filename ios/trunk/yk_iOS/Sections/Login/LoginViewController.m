//
//  LoginViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/22.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () {
    
    IBOutlet UITextField *_usernameTextField;
    IBOutlet UITextField *_passwordTextField;
    IBOutlet UIButton *_loginBtn;
}

@end

@implementation LoginViewController

- (BOOL)isShowBack {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configTextField:_usernameTextField];
    [self configTextField:_passwordTextField];
    
    _loginBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _loginBtn.layer.borderWidth = 0.5;
    _loginBtn.layer.cornerRadius = 4.0;
    _loginBtn.layer.masksToBounds = YES;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
}

- (void)configTextField:(UITextField *)textField {
    
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 15, 15)];
    if (textField == _usernameTextField) {
        leftImageView.image = [UIImage imageNamed:@"username_bg_image"];
    } else if (textField == _passwordTextField) {
        leftImageView.image = [UIImage imageNamed:@"password_bg_image"];
    }
    [View addSubview:leftImageView];
    textField.leftView =View;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)hideKeyboard {
    if ([_usernameTextField isFirstResponder]) {
        [_usernameTextField resignFirstResponder];
    } else if ([_passwordTextField isFirstResponder]) {
        [_passwordTextField resignFirstResponder];
    }
}

- (IBAction)doRememberAction:(id)sender {
}
- (IBAction)doLoginAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
