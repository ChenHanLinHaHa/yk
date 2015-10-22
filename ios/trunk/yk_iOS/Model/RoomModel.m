//
//  RoomModel.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/14.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomModel.h"

@implementation RoomModel

- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.roomId = dic[@"roomId"];
        self.roomPrice = dic[@"roomPrice"];
        self.roomDescribe = dic[@"roomDescribe"];
        self.roomImage = dic[@"roomImage"];
        self.roomDeposit = dic[@"roomDeposit"];
    }
    return self;
}

@end
