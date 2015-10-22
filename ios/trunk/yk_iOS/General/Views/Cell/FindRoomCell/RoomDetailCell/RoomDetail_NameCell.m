//
//  RoomDetail_NameCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_NameCell.h"
#import "AlertControllerHelper.h"

@implementation RoomDetail_NameCell

- (void)awakeFromNib {
    // Initialization code
    
    _reverseRoomBtn.layer.borderColor = [UIColor orangeColor].CGColor;
    _reverseRoomBtn.layer.borderWidth = 1.0;
}

- (void)setRoomModel:(RoomModel *)roomModel {
    _roomDescribeLabel.text = roomModel.roomDescribe;
    _rentLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomPrice];
    _cashLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomPrice];
    _depositLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomDeposit];
}

- (IBAction)doReverseRoomAction:(id)sender {
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
