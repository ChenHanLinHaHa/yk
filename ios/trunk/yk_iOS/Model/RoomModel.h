//
//  RoomModel.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/14.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomModel : NSObject

@property (strong, nonatomic) NSString *roomId;
@property (strong, nonatomic) NSString *roomPrice;
@property (strong, nonatomic) NSString *roomDescribe;
@property (strong, nonatomic) NSString *roomImage;
@property (strong, nonatomic) NSString *roomDeposit;//订金
@property (strong, nonatomic) NSNumber *isCollected;

- (id)initWithDic:(NSDictionary *)dic;

@end
