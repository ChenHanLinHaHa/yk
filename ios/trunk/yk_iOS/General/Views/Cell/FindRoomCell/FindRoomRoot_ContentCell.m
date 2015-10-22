//
//  FindRoomRoot_ContentCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "FindRoomRoot_ContentCell.h"
#import "CollectRoomOperation.h"

@implementation FindRoomRoot_ContentCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setRoomModel:(RoomModel *)roomModel {
    self.roomId = roomModel.roomId;
    [self.roomImageView sd_setImageWithURL:[NSURL URLWithString:roomModel.roomImage] placeholderImage:nil];
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",roomModel.roomPrice];
    self.describeLabel.text = roomModel.roomDescribe;
    _roomImage = roomModel.roomImage;
    _roomDeposit = roomModel.roomDeposit;
    _roomPrice = roomModel.roomPrice;
}

- (IBAction)doCollectAction:(id)sender {
    CollectButton *btn = (CollectButton *)sender;
    if (btn.isCollectFlag) {
        if (self.collectClickBlock) {
            self.collectClickBlock(NO);
        }
        [sender setImage:[UIImage imageNamed:@"collection_normal_image"] forState:UIControlStateNormal];
        btn.isCollectFlag = NO;
        [[CollectRoomOperation defaultCollectRoomOperation] deleteLocalSavedRoomByRoomId:self.roomId];
    } else {
        if (self.collectClickBlock) {
            self.collectClickBlock(YES);
        }
        [sender setImage:[UIImage imageNamed:@"collection_selected_image"] forState:UIControlStateNormal];
        btn.isCollectFlag = YES;
        [[CollectRoomOperation defaultCollectRoomOperation] saveRoomToLocalByRoomId:self.roomId withValue:@{@"roomId":self.roomId,
                                                                                                            @"roomPrice":_roomPrice,
                                                                                                            @"roomDescribe":self.describeLabel.text,
                                                                                                            @"roomImage":_roomImage,
                                                                                                            @"roomDeposit":_roomDeposit}];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
