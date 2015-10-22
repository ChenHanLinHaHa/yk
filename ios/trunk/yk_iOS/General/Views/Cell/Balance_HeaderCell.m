//
//  Balance_HeaderCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Balance_HeaderCell.h"

@implementation Balance_HeaderCell

- (void)configUI {
    _chargeBtn.layer.cornerRadius = 4.0;
    _chargeBtn.layer.masksToBounds = YES;
    _chargeBtn.layer.borderWidth = 1.0;
    _chargeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
