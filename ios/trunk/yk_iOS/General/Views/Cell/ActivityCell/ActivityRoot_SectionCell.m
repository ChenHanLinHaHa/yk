//
//  ActivityRoot_SectionCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/19.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "ActivityRoot_SectionCell.h"

@implementation ActivityRoot_SectionCell

- (void)awakeFromNib {
    // Initialization code
    
    _couopnSectionBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _couopnSectionBgView.layer.borderWidth = 0.5;
    _couopnSectionBgView.layer.cornerRadius = 4.0;
    _couopnSectionBgView.layer.masksToBounds = YES;
    
    _newVIPSectionBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _newVIPSectionBgView.layer.borderWidth = 0.5;
    _newVIPSectionBgView.layer.cornerRadius = 4.0;
    _newVIPSectionBgView.layer.masksToBounds = YES;
    
    _specialRoomSectionBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _specialRoomSectionBgView.layer.borderWidth = 0.5;
    _specialRoomSectionBgView.layer.cornerRadius = 4.0;
    _specialRoomSectionBgView.layer.masksToBounds = YES;
}
- (IBAction)doCouponSectionAction:(id)sender {
    if (self.couponSectionBlock) {
        self.couponSectionBlock();
    }
}
- (IBAction)doNewVIPSectionAction:(id)sender {
    if (self.newVIPSectionBlock) {
        self.newVIPSectionBlock();
    }
}
- (IBAction)doSpecialRoomSectionAction:(id)sender {
    if (self.specialRoomSectionBlock) {
        self.specialRoomSectionBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
