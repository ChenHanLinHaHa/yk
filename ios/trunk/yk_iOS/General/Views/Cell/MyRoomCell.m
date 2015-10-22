//
//  MyRoomCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/15.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "MyRoomCell.h"

@implementation MyRoomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRoomModel:(RoomModel *)roomModel {
    _roomPriceLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomPrice];
    _roomDescribeLabel.text = roomModel.roomDescribe;
    [_roomImageView sd_setImageWithURL:[NSURL URLWithString:roomModel.roomImage] placeholderImage:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
