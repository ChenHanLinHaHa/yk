//
//  RoomDetail_NameCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReverseClickBlock)(int index);

@interface RoomDetail_NameCell : UITableViewCell {
    IBOutlet UILabel *_roomDescribeLabel;
    IBOutlet UILabel *_rentLabel;//租金
    IBOutlet UILabel *_cashLabel;//押金
    IBOutlet UILabel *_depositLabel;//订金
}

@property (strong, nonatomic) IBOutlet UIButton *reverseRoomBtn;

@property (nonatomic, strong) ReverseClickBlock reverseClickBlock;

@property (nonatomic, strong) RoomModel *roomModel;

@end
