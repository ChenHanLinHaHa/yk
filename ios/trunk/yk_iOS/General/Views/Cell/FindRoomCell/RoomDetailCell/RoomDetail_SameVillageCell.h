//
//  RoomDetail_SameVillageCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/18.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailModel.h"

@interface RoomDetail_SameVillageCell : UITableViewCell {
    
    IBOutlet UIImageView *_roomImageView;
    IBOutlet UILabel *_roomAddressLabel;
    IBOutlet UILabel *_roomPriceLabel;
}

@property (nonatomic, strong) RoomsSameVilage *roomsSameVilageModel;

@end
