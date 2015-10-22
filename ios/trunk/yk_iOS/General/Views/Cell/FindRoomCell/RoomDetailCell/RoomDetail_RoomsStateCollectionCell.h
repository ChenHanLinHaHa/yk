//
//  RoomDetail_RoomsStateCollectionCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRoomsStateCollectionCellSize CGSizeMake(80, 30)

@interface RoomDetail_RoomsStateCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UIButton *contentBtn;

@end
