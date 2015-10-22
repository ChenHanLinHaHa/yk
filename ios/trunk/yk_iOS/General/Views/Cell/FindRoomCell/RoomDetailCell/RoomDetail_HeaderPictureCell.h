//
//  RoomDetail_HeaderPictureCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectButton.h"

typedef void(^ImageClickBlock)(NSArray *imagesArr, NSUInteger index);
typedef void(^CollectBtnClickBlock)(BOOL isCollect);

@interface RoomDetail_HeaderPictureCell : UITableViewCell<UIScrollViewDelegate> {
    
    NSMutableArray *_headImageArr;
    IBOutlet UIScrollView *_headScrollView;
    IBOutlet UIImageView *_preImageView;
    IBOutlet UIImageView *_currentImageView;
    NSInteger _curImageIndex;
    IBOutlet UIImageView *_nextImageView;
    IBOutlet UILabel *_curIndexLabel;
    IBOutlet UILabel *_totalIndexLabel;
    
    NSString *_roomId;
    NSString *_roomPrice;
    NSString *_roomDescribe;
    NSString *_roomImage;
    NSString *_roomDeposit;
}
@property (strong, nonatomic) IBOutlet CollectButton *collectBtn;

@property (nonatomic, strong) ImageClickBlock imageClickBlock;

@property (strong, nonatomic) CollectBtnClickBlock collectBtnClickBlock;

@property (strong, nonatomic) RoomModel *roomModel;

@property (strong, nonatomic) NSArray *roomImages;

@end
