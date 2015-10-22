//
//  PaymentResultViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "PaymentResultViewController.h"

@interface PaymentResultViewController ()

@end

@implementation PaymentResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    if (self.payType == Charge) {
        self.title = @"充值结果";
    } else if (self.payType == Pay_Rent) {
        self.title = @"房租支付结果";
    } else if (self.payType == Pay_Electric) {
        self.title = @"电费支付结果";
    }
}

- (BOOL)isShowBack {
    return NO;
}

//预约成功后保存房间
- (void)saveReversedRoom {
    if (self.payType == Pay_Deposit_Reverse) {
        //交付定金成功
        [AVOSCloudHelper refreshToObjectClass:AC_AllRooms withWhereKey:@"RoomId" withRefreshArr:@[self.roomModel.roomId] withRefreshToDic:@{@"RoomState":@"1"} withResultBlock:^(BOOL isSavedSuccess) {
            if (isSavedSuccess) {
                DebugLog(@"预约成功");
            } else {
                DebugLog(@"预约失败");
            }
        }];
    } else if (self.payType == Pay_OtherMoney_Reverse) {
        //交付除订金以外的费用
        [AVOSCloudHelper refreshToObjectClass:AC_AllRooms withWhereKey:@"RoomId" withRefreshArr:@[self.roomModel.roomId] withRefreshToDic:@{@"RoomState":@"2"} withResultBlock:^(BOOL isSavedSuccess) {
            if (isSavedSuccess) {
                DebugLog(@"签约成功");
            } else {
                DebugLog(@"签约失败");
            }
        }];
    }
}

- (IBAction)doCertainAction:(id)sender {
    [self saveReversedRoom];
    self.reverseResultBlock(YES);
    [self.navigationController popToRootViewControllerAnimated:YES];
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
