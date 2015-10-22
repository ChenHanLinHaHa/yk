//
//  RoomDetail_BaseInfoCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_BaseInfoCell.h"

@implementation RoomDetail_BaseInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setRoomDetailModel:(RoomDetailModel *)roomDetailModel {
    _addressLabel.text = roomDetailModel.RoomVillage;
    _roomBedLabel.text = roomDetailModel.RoomBed;
    _roomFloorLabel.text = roomDetailModel.RoomFloor;
    _roomDirectionLabel.text = roomDetailModel.RoomDirection;
    _roomTypeLabel.text = roomDetailModel.RoomType;
    _roomAreaLabel.text = [NSString stringWithFormat:@"%@平",roomDetailModel.RoomArea];
} 

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
