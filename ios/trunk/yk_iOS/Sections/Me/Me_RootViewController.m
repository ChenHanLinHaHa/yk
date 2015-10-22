//
//  Me_RootViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Me_RootViewController.h"
#import "Me_RootHeaderCell.h"
#import "Me_RootCell.h"
#import "Me_InfoViewController.h"
#import "Me_BalanceViewController.h"
#import "Me_CouponViewController.h"
#import "Me_RentViewController.h"
#import "Me_ReverseViewController.h"
#import "Me_MyRoomViewController.h"

@interface Me_RootViewController ()
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation Me_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = @[@[@"详细信息"],@[@"我的房租",@"我的电费"],@[@"我的房间"],@[@"管理员电话:15902168747"]];
}

- (BOOL)isShowBack {
    return NO;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return ((NSArray *)(self.dataArr[section-1])).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Me_RootHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Me_RootHeaderCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Me_RootHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Me_RootHeaderCell"];
        }
        cell.myCouopnClickBlock = ^(void) {
            Me_CouponViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_CouponViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.myBalanceClickBlock = ^(void) {
            Me_BalanceViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_BalanceViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.myReverseClickBlock = ^(void) {
            Me_ReverseViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_ReverseViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configUI];
        return cell;
    } else {
        Me_RootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Me_RootCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Me_RootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Me_RootCell"];
        }
        cell.textLabel.text = ((NSArray *)(self.dataArr[indexPath.section-1]))[indexPath.row];
        return cell;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *me_HeadView = [[UIImageView alloc] init];
    me_HeadView.backgroundColor = kColorTableBG;
    return me_HeadView;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 20;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 200;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:
        {
            Me_InfoViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_InfoViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            Me_RentViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_RentViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            if (indexPath.row == 0) {
                vc.rentType = myRoomRent;
            } else if (indexPath.row == 1) {
                vc.rentType = MyElectric;
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            Me_MyRoomViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_MyRoomViewController"];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
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
