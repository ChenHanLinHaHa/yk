//
//  CouponCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "CouponCell.h"

@implementation CouponCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configUI {
    
}

- (void)setCellTypeBlock:(CellTypeBlock)cellTypeBlock
{
    if (cellTypeBlock() == CouponUnused) {
        _bgImageView.image = [UIImage imageNamed:@"coupon_unused_image"];
    } else if (cellTypeBlock() == CouponUsed) {
        _bgImageView.image = [UIImage imageNamed:@"coupon_used_image"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
