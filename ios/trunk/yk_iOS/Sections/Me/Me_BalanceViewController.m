//
//  Me_BalanceViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Me_BalanceViewController.h"
#import "Balance_HeaderCell.h"
#import "Balance_Cell.h"

@interface Me_BalanceViewController ()

@end

@implementation Me_BalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Balance_HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Balance_HeaderCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Balance_HeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Balance_HeaderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configUI];
        return cell;
    } else {
        Balance_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Balance_Cell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Balance_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Balance_Cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIImageView *balance_HeadView = [[UIImageView alloc] init];
        balance_HeadView.backgroundColor = kColorTableBG;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-20, 30)];
        label.text = @"历史充值记录";
        label.font = [UIFont systemFontOfSize:12];
        label.alpha = 0.7;
        [balance_HeadView addSubview:label];
        return balance_HeadView;
    }
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
    if (indexPath.section == 0) {
        return 160;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
