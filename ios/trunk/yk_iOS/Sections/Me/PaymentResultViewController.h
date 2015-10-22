//
//  PaymentResultViewController.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ReverseResultBlock)(BOOL isSuccess);

@interface PaymentResultViewController : BaseViewController

@property (nonatomic, assign) PayType payType;
@property (nonatomic, assign) PayResultType payResultType;

@property (nonatomic, strong) ReverseResultBlock reverseResultBlock;

@property (nonatomic, strong) RoomModel *roomModel;

@end
