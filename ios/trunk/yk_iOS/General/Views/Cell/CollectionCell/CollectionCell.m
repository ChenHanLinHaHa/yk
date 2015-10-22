//
//  CollectionCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "CollectionCell.h"
#import "AlertControllerHelper.h"

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRoomModel:(RoomModel *)roomModel
{
    [self.roomImageView sd_setImageWithURL:[NSURL URLWithString:roomModel.roomImage] placeholderImage:nil];;
    self.roomPriceLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomPrice];
    self.roomDescribeLabel.text = roomModel.roomDescribe;
    self.roomReverseMoneyLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomDeposit];
}

- (IBAction)doReverseAction:(id)sender {
    [[AlertControllerHelper defaultAlertControllerHelper] showAlertControllerwithClickIndexBlock:^(int index) {
        if (self.reverseClickBlock) {
            self.reverseClickBlock(index);
        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
