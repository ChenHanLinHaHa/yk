//
//  RegisterViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/22.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController () {
    
    IBOutlet UITextField *_usernameTextField;
    IBOutlet UITextField *_passwordTextField;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)doRegisterAction:(id)sender {
    if (_usernameTextField.text.length == 0 || _passwordTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入邮箱或密码!" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AVOSCloudHelper registerWithUsername:_usernameTextField.text withPassword:_passwordTextField.text withEmail:_usernameTextField.text withRegisterResultBlock:^(BOOL isRegisterSuccess, NSUInteger errorCode, NSString *username, NSString *password, NSString *email) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isRegisterSuccess) {
            [UserDefaultManager saveObject:_usernameTextField.text forKey:KEmail];
            [UserDefaultManager saveObject:_passwordTextField.text forKey:KPassword];
            [SVProgressHUD showInfoWithStatus:@"注册成功!" maskType:SVProgressHUDMaskTypeBlack];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            if (errorCode == 203) {
                [SVProgressHUD showInfoWithStatus:@"邮箱已被注册!" maskType:SVProgressHUDMaskTypeBlack];
            } else {
                [SVProgressHUD showInfoWithStatus:@"注册失败,请检查网络!" maskType:SVProgressHUDMaskTypeBlack];
            }
        }
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
