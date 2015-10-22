//
//  RoomDetail_SameVillageCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/18.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_SameVillageCell.h"

@implementation RoomDetail_SameVillageCell

- (void)awakeFromNib {
    // Initialization code
    
    [_roomImageView sd_setImageWithURL:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/w%3D2048/sign=df5d0b61cdfc1e17fdbf8b317ea8f703/0bd162d9f2d3572c8d2b20ab8813632763d0c3f8.jpg"] placeholderImage:nil];
}

- (void)setRoomsSameVilageModel:(RoomsSameVilage *)roomsSameVilageModel {
    _roomAddressLabel.text = roomsSameVilageModel.RoomCode;
    [_roomImageView sd_setImageWithURL:[NSURL URLWithString:roomsSameVilageModel.RoomImage] placeholderImage:nil];
    _roomPriceLabel.text = [NSString stringWithFormat:@"%@元",roomsSameVilageModel.RoomPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
