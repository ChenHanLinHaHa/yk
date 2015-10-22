//
//  RoomDetail_HMInfoCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_HMInfoCell.h"

@implementation RoomDetail_HMInfoCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)doCallAction:(id)sender {
    if (self.callBlock) {
        self.callBlock(self.telephoneLabel.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
