//
//  RoomDetail_BaseConfigCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_BaseConfigCell.h"

@implementation RoomDetail_BaseConfigCell

- (void)awakeFromNib {
    // Initialization code
    
    _dataArr = @[@"床",@"衣柜",@"冰箱",@"洗衣机",@"空调",@"热水器",@"宽带",@"微波炉"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
