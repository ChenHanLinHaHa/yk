//
//  SettingViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/23.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "SettingViewController.h"
#import "Setting_ContentCell.h"
#import "Setting_LogoutCell.h"

@interface SettingViewController () {
    
    IBOutlet UITableView *_myTableView;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _myTableView.tableFooterView = [[UIView alloc] init];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Setting_ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Setting_ContentCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Setting_ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Setting_ContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        Setting_LogoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Setting_LogoutCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Setting_LogoutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Setting_LogoutCell"];
        }
        cell.logoutBlock = ^(void) {
            BOOL isLogoutSuccess = [AVOSCloudHelper logout];
            if (isLogoutSuccess) {
                UINavigationController *loginNav = [kMainStoryboard instantiateViewControllerWithIdentifier:@"LoginNav"];
                [self presentViewController:loginNav animated:YES completion:nil];
            } else {
                [SVProgressHUD showInfoWithStatus:@"登出失败!" maskType:SVProgressHUDMaskTypeBlack];
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
