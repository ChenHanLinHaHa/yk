//
//  RoomDetail_RoomsStateCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomDetailModel.h"

@interface RoomDetail_RoomsStateCell : UITableViewCell{
    NSArray *_dataArr;
    IBOutlet UICollectionView *_myCollectionView;
    IBOutlet UILabel *_roomTypeLabel;
    IBOutlet UILabel *_roomAreaLabel;
    IBOutlet UILabel *_roomRentLabel;
    IBOutlet UILabel *_roomStateLabel;
    IBOutlet UILabel *_roomConfigLabel;
    IBOutlet UIImageView *_roomMateImage;
}

- (void)reloadData:(RoomOthers *)roomOther;

@end
