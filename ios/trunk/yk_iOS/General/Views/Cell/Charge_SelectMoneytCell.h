//
//  Charge_SelectMoneytCell.h
//  
//
//  Created by chenhanlin on 15/10/9.
//
//

#import <UIKit/UIKit.h>

typedef void(^ChargeSelectMoneyCountBlock)(double amount);

@interface Charge_SelectMoneytCell : UITableViewCell
{
    NSArray *_dataArr;
}

@property (nonatomic, strong) ChargeSelectMoneyCountBlock chargeSelectMoneyCountBlock;

@end
