//
//  LoginViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/22.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ResetPwdViewController.h"

@interface LoginViewController () {
    
    IBOutlet UITextField *_usernameTextField;
    IBOutlet UITextField *_passwordTextField;
    IBOutlet UIButton *_loginBtn;
    IBOutlet UIButton *_rememberBtn;
    BOOL _isRememberPassword;
}

@end

@implementation LoginViewController

- (BOOL)isShowBack {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _loginBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _loginBtn.layer.borderWidth = 0.5;
    _loginBtn.layer.cornerRadius = 4.0;
    _loginBtn.layer.masksToBounds = YES;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    
    _isRememberPassword =((NSNumber *)[UserDefaultManager getObjectForKey:@"isRememberPassword"]).boolValue;
    [self setRememberBtnImage];
    _usernameTextField.text = [UserDefaultManager getObjectForKey:KEmail];
    _passwordTextField.text = [UserDefaultManager getObjectForKey:KPassword];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"go_register_image" showBadge:NO target:self action:@selector(goRegisterAction:)];
}

- (void)setRememberBtnImage {
    if (_isRememberPassword) {
        [_rememberBtn setImage:[UIImage imageNamed:@"remember_pw_selected_image"] forState:UIControlStateNormal];
    } else {
        [_rememberBtn setImage:[UIImage imageNamed:@"remember_pw_normal_image"] forState:UIControlStateNormal];
    }
}

- (void)hideKeyboard {
    if ([_usernameTextField isFirstResponder]) {
        [_usernameTextField resignFirstResponder];
    } else if ([_passwordTextField isFirstResponder]) {
        [_passwordTextField resignFirstResponder];
    }
}

- (IBAction)doRememberAction:(id)sender {
    _isRememberPassword = !_isRememberPassword;
    [self setRememberBtnImage];
    [UserDefaultManager saveObject:[NSNumber numberWithBool:_isRememberPassword] forKey:@"isRememberPassword"];
}
- (IBAction)doLoginAction:(id)sender {
    if (_usernameTextField.text.length == 0 || _passwordTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入邮箱或密码!" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AVOSCloudHelper logout];
    [AVOSCloudHelper loginWithUsename:_usernameTextField.text withPassword:_passwordTextField.text withLoginResultBlock:^(BOOL isLoginSuccess,NSInteger errorCode) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isLoginSuccess) {
            [UserDefaultManager saveObject:_usernameTextField.text forKey:KEmail];
            [UserDefaultManager saveObject:_passwordTextField.text forKey:KPassword];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            if (errorCode == 211) {
                [SVProgressHUD showInfoWithStatus:@"用户不存在!" maskType:SVProgressHUDMaskTypeBlack];
            } else {
                [SVProgressHUD showInfoWithStatus:@"登录失败,请检查网络!" maskType:SVProgressHUDMaskTypeBlack];
            }
        }
    }];
}
- (void)goRegisterAction:(id)sender {
    RegisterViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"doResetAction"]) {
        ResetPwdViewController *vc = segue.destinationViewController;
        vc.resetBlock = ^(void) {
            _passwordTextField.text = nil;
        };
    }
}


@end
