//
//  RoomDetail_BaseInfoCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailModel.h"

@interface RoomDetail_BaseInfoCell : UITableViewCell {
    
    IBOutlet UILabel *_addressLabel;
    IBOutlet UILabel *_roomTypeLabel;
    IBOutlet UILabel *_roomFloorLabel;
    IBOutlet UILabel *_roomDirectionLabel;
    IBOutlet UILabel *_roomBedLabel;
    IBOutlet UILabel *_roomAreaLabel;
}

@property (nonatomic, strong)RoomDetailModel *roomDetailModel;

@end
