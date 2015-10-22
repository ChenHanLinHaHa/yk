//
//  Charge_FooterCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Charge_FooterCell.h"

@implementation Charge_FooterCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)doPayAction:(id)sender {
    if (self.payBlock) {
        self.payBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
