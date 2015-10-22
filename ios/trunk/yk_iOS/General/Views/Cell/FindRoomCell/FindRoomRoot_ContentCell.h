//
//  FindRoomRoot_ContentCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectButton.h"
#import "RoomModel.h"

typedef void(^CollectClickBlock)(BOOL isCollect);

@interface FindRoomRoot_ContentCell : UITableViewCell {
    NSString *_roomImage;
}
@property (nonatomic, strong) CollectClickBlock collectClickBlock;
@property (nonatomic, strong) RoomModel *roomModel;
@property (strong, nonatomic) NSString *roomId;
@property (strong, nonatomic) NSString *roomDeposit;
@property (strong, nonatomic) NSString *roomPrice;
@property (strong, nonatomic) IBOutlet CollectButton *collectionBtn;
@property (strong, nonatomic) IBOutlet UIImageView *roomImageView;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *describeLabel;
@end
