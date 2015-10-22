//
//  Reverse_CountdownCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Reverse_CountdownCell.h"

@implementation Reverse_CountdownCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setRoomModel:(RoomModel *)roomModel {
    priceLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomPrice];
    describeLabel.text = roomModel.roomDescribe;
    [roomImageView sd_setImageWithURL:[NSURL URLWithString:roomModel.roomImage] placeholderImage:nil];
}

- (IBAction)doPayOtherMoneyAction:(id)sender {
    if (self.payOtherMoneyClick) {
        self.payOtherMoneyClick();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
