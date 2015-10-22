//
//  RoomDetailViewController.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "BaseViewController.h"
#import "RoomModel.h"
#import "RoomDetailModel.h"

typedef enum : NSUInteger {
    FindRoomVC,
    CollectionVC,
    Me_ReverseVC,
    Me_MyRoomVC,
} RoomOriginalVC;

typedef void(^RoomDetailCollectClickBlock)(BOOL isCollect);

typedef void(^ReverseFinishBlock)(void);

@interface RoomDetailViewController : BaseViewController {
    UIImage *image;
    NSString *url;
    NSData *imgData;
}

@property (nonatomic, assign) RoomOriginalVC roomOriginalVC;

@property (nonatomic, assign) BOOL isCollected;

@property (nonatomic, retain) RoomModel *roomModel;

@property (nonatomic, strong) RoomDetailCollectClickBlock roomDetailCollectClickBlock;

@property (nonatomic, strong) ReverseFinishBlock reverseFinishBlock;

@end
