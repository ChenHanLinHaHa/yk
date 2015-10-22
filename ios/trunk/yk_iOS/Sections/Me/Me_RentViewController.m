//
//  Me_RentViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Me_RentViewController.h"
#import "Rent_FooterCell.h"
#import "RentCell.h"
#import "Rent_PayCell.h"
#import "PaymentResultViewController.h"

@interface Me_RentViewController ()
{
    NSArray *_leftTitleArr;
    NSArray *_rightContentArr;
    NSArray *_payLeftImageArr;
    NSArray *_payContentArr;
    NSIndexPath *_selectIndexPath;
    Rent_PayCell *_historySelectPayCell;
    Rent_FooterCell *_tempFooterCell;
}
@property (nonatomic, assign) BOOL isCanPay;
@end

@implementation Me_RentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_rentType == myRoomRent) {
        self.title = @"我的房租";
        _leftTitleArr = @[@"房间地址",@"房间编号",@"本月房租"];
        _rightContentArr = @[@"沙河名苑23号楼",@"1234567890",@"100.00元"];
    } else if (_rentType == MyElectric) {
        self.title = @"我的电费";
        _leftTitleArr = @[@"房间地址",@"房间编号",@"本月电费"];
        _rightContentArr = @[@"沙河名苑23号楼",@"1234567890",@"200.00元"];
    } else if (_rentType == AllMoney_Reverse) {
        self.title = @"全额预订房间";
        _leftTitleArr = @[@"房间地址",@"房间编号",@"月租+押金"];
        _rightContentArr = @[@"沙河名苑23号楼",@"1234567890",@"800.00元"];
    } else if (_rentType == Deposit_Reverse) {
        self.title = @"订金预订房间";
        _leftTitleArr = @[@"房间地址",@"房间编号",@"订金"];
        _rightContentArr = @[@"沙河名苑23号楼",@"1234567890",@"200.00元"];
    } else if (_rentType == OtherMoney_Reverse) {
        self.title = @"全额除订金预订房间";
        _leftTitleArr = @[@"房间地址",@"房间编号",@"还需支付"];
        _rightContentArr = @[@"沙河名苑23号楼",@"1234567890",@"600.00元"];
    }
    
    _payLeftImageArr = @[@"alipay_image",@"wxpay_image",@"ylpay_image",@"ylpay_image"];
    _payContentArr = @[@"支付宝支付",@"微信支付",@"银联支付",@"余额支付"];
    
    
    self.isCanPay = NO;
    [self addObserver:self forKeyPath:@"self.isCanPay" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"self.isCanPay"] && [[change objectForKey:NSKeyValueChangeNewKey] boolValue]) {
        _tempFooterCell.payBtn.hidden = NO;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[RentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RentCell"];
        }
        cell.leftLabel.text = _leftTitleArr[indexPath.row];
        cell.rightLabel.text = _rightContentArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        Rent_PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Rent_PayCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Rent_PayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Rent_PayCell"];
        }
        [cell.paySelectBtn setImage:[UIImage imageNamed:@"pay_normal_image"] forState:UIControlStateNormal];
        if ([UserDefaultManager getObjectForKey:@"pay_type"]) {
            long value = ((NSNumber *)[UserDefaultManager getObjectForKey:@"pay_type"]).longValue;
            if (value == indexPath.row) {
                [cell.paySelectBtn setImage:[UIImage imageNamed:@"pay_selected_image"] forState:UIControlStateNormal];
                _historySelectPayCell = cell;
                _selectIndexPath = indexPath;
            }
        }
        cell.iconImageView.image = [UIImage imageNamed:_payLeftImageArr[indexPath.row]];
        cell.contentLabel.text = _payContentArr[indexPath.row];
        return cell;
    } else {
        Rent_FooterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Rent_FooterCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Rent_FooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Rent_FooterCell"];
        }
        cell.payBlock = ^(void) {
            [UserDefaultManager saveObject:[NSNumber numberWithLong:_selectIndexPath.row]forKey:@"pay_type"];
        };
        _tempFooterCell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *me_HeadView = [[UIImageView alloc] init];
    me_HeadView.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, kScreen_Width-20, 29)];
        label.font = [UIFont systemFontOfSize:14];
        label.alpha = 0.7;
        label.text = @"请选择支付方式";
        [me_HeadView addSubview:label];
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, label.bottom, kScreen_Width, 1)];
        lineImageView.image = [UIImage imageNamed:@"line_image"];
        [me_HeadView addSubview:lineImageView];
    }
    return me_HeadView;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 60;
    } else {
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell创建在此方法之前
    if (_historySelectPayCell) {
        self.isCanPay = YES;
    }
    if (indexPath.section == 1) {
        return 60;
    } else if (indexPath.section == 2) {
        return 55;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (_historySelectPayCell) {
            [_historySelectPayCell.paySelectBtn setImage:[UIImage imageNamed:@"pay_normal_image"] forState:UIControlStateNormal];
        }
        _selectIndexPath = indexPath;
        Rent_PayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _historySelectPayCell = cell;
        [cell.paySelectBtn setImage:[UIImage imageNamed:@"pay_selected_image"] forState:UIControlStateNormal];
        self.isCanPay = YES;
    }
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
    if ([segue.identifier isEqualToString:@"PayResultAction"]) {
        
        PaymentResultViewController *vc = segue.destinationViewController;
        if (self.rentType == myRoomRent) {
            vc.payType = Pay_Rent;
        } else if (self.rentType == MyElectric) {
            vc.payType = Pay_Electric;
        } else if (self.rentType == AllMoney_Reverse) {
            vc.payType = Pay_AllMoney_Reverse;
        } else if (self.rentType == Deposit_Reverse) {
            vc.payType = Pay_Deposit_Reverse;
        } else if (self.rentType == OtherMoney_Reverse) {
            vc.payType = Pay_OtherMoney_Reverse;
        }
        vc.roomModel = self.roomModel;
        vc.reverseResultBlock = ^(BOOL isSuccess) {
            if (isSuccess) {
                if (self.reverseBlock) {
                    self.reverseBlock();
                }
            }
        };
    }
    
}


@end
