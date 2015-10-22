//
//  Me_RentViewController.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ReverseBlock)(void);

@interface Me_RentViewController : BaseViewController

@property (nonatomic, assign) RentType rentType;

@property (nonatomic, strong) ReverseBlock reverseBlock;

@property (nonatomic, strong) RoomModel *roomModel;

@end
