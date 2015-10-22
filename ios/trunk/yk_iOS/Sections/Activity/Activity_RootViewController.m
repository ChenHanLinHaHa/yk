//
//  Activity_RootViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Activity_RootViewController.h"
#import "ActivityRoot_HeaderCell.h"
#import "ActivityRoot_SectionCell.h"
#import "ActivityRoot_ContentCell.h"

@interface Activity_RootViewController ()

@end

@implementation Activity_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)isShowBack {
    return NO;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ActivityRoot_HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityRoot_HeaderCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ActivityRoot_HeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityRoot_HeaderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        ActivityRoot_SectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityRoot_SectionCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ActivityRoot_SectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityRoot_SectionCell"];
        }
        cell.couponSectionBlock = ^(void) {
            
        };
        cell.newVIPSectionBlock = ^(void) {
            
        };
        cell.specialRoomSectionBlock = ^(void) {
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        ActivityRoot_ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityRoot_ContentCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ActivityRoot_ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActivityRoot_ContentCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 0;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 160;
    } else if (indexPath.section == 1) {
        return 70;
    }
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
