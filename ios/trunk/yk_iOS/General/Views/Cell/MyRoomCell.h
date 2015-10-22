//
//  MyRoomCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/15.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRoomCell : UITableViewCell {
    
    IBOutlet UILabel *_roomPriceLabel;
    IBOutlet UILabel *_roomDescribeLabel;
    IBOutlet UIImageView *_roomImageView;
}

@property (nonatomic, strong) RoomModel *roomModel;

@end
