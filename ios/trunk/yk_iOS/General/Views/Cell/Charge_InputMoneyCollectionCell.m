//
//  Charge_InputMoneyCollectionCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Charge_InputMoneyCollectionCell.h"

@implementation Charge_InputMoneyCollectionCell
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textFieldDidEndEditingBlock) {
        self.textFieldDidEndEditingBlock([textField.text doubleValue]);
    }
}
@end
