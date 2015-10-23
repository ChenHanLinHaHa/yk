//
//  ResetPwdViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/23.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "ResetPwdViewController.h"

@interface ResetPwdViewController () {
    
    IBOutlet UITextField *_emailTextField;
}

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _emailTextField.text = [UserDefaultManager getObjectForKey:KEmail];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

- (IBAction)doResetPwdAction:(id)sender {
    if (_emailTextField.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入邮箱!" maskType:SVProgressHUDMaskTypeBlack];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AVOSCloudHelper resetPWDWithEmail:_emailTextField.text withResetPwdResult:^(BOOL isResetSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isResetSuccess) {
            [SVProgressHUD showInfoWithStatus:@"邮件发送成功，请转至邮箱修改密码!" maskType:SVProgressHUDMaskTypeBlack];
            if (self.resetBlock) {
                self.resetBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showInfoWithStatus:@"邮箱发送失败!" maskType:SVProgressHUDMaskTypeBlack];
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
