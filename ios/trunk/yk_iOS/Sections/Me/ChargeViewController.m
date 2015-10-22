//
//  ChargeViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "ChargeViewController.h"
#import "PaymentResultViewController.h"
#import "Charge_HeaderCell.h"
#import "Charge_SelectMoneytCell.h"
#import "Charge_PayCell.h"
#import "Charge_FooterCell.h"

@interface ChargeViewController ()
{
    NSArray *_payLeftImageArr;
    NSArray *_payContentArr;
    NSIndexPath *_selectIndexPath;
    Charge_PayCell *_historySelectPayCell;
    Charge_FooterCell *_tempFooterCell;
    IBOutlet UIView *_keyboardBgView;
}
@property (nonatomic, assign) BOOL isCanPay;
@end

@implementation ChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _payLeftImageArr = @[@"alipay_image",@"wxpay_image",@"ylpay_image"];
    _payContentArr = @[@"支付宝支付",@"微信支付",@"银联支付"];
    
    
    self.isCanPay = NO;
    [self addObserver:self forKeyPath:@"self.isCanPay" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    [_keyboardBgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"self.isCanPay"] && [[change objectForKey:NSKeyValueChangeNewKey] boolValue]) {
        _tempFooterCell.payBtn.hidden = NO;
    }
}

- (void)keyboardWillAppear:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 animations:^{
        _keyboardBgView.hidden = NO;
    }];
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 animations:^{
        _keyboardBgView.hidden = YES;
    }];
}

- (void)hideKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Charge_HeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Charge_HeaderCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Charge_HeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Charge_HeaderCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        Charge_SelectMoneytCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Charge_SelectMoneytCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Charge_SelectMoneytCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Charge_SelectMoneytCell"];
        }
        cell.chargeSelectMoneyCountBlock = ^(double amount) {
            DebugLog(@"amount = %lf",amount);
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        Charge_PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Charge_PayCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Charge_PayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Charge_PayCell"];
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
        Charge_FooterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Charge_FooterCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[Charge_FooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Charge_FooterCell"];
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
    UIImageView *balance_HeadView = [[UIImageView alloc] init];
    balance_HeadView.backgroundColor = kColorTableBG;
    if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-20, 30)];
        label.text = @"选择充值金额(元)";
        label.font = [UIFont systemFontOfSize:14];
        label.alpha = 0.7;
        [balance_HeadView addSubview:label];
    } else if (section == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, kScreen_Width-20, 29)];
        label.font = [UIFont systemFontOfSize:14];
        label.alpha = 0.7;
        label.text = @"请选择支付方式";
        [balance_HeadView addSubview:label];
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, label.bottom, kScreen_Width, 1)];
        lineImageView.image = [UIImage imageNamed:@"line_image"];
        [balance_HeadView addSubview:lineImageView];
    } else {
        balance_HeadView.backgroundColor = [UIColor whiteColor];
    }
    return balance_HeadView;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 3) {
        return 15;
    } else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell创建在此方法之前
    if (_historySelectPayCell) {
        self.isCanPay = YES;
    }
    if (indexPath.section == 0) {
        return 80;
    } else if (indexPath.section == 1) {
        return 120;
    } else if (indexPath.section == 2) {
        return 60;
    }
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (_historySelectPayCell) {
            [_historySelectPayCell.paySelectBtn setImage:[UIImage imageNamed:@"pay_normal_image"] forState:UIControlStateNormal];
        }
        _selectIndexPath = indexPath;
        Charge_PayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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
    if ([segue.identifier isEqualToString:@"ChargeResultAction"]) {
        PaymentResultViewController *vc = segue.destinationViewController;
        vc.payType = Charge;
    }
}


@end
