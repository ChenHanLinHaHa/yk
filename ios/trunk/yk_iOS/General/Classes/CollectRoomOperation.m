//
//  CollectRoomOperation.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/14.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "CollectRoomOperation.h"
#import "PlistHelper.h"

@implementation CollectRoomOperation

+ (id)defaultCollectRoomOperation {
    static CollectRoomOperation *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[CollectRoomOperation alloc] init];
    });
    return helper;
}

- (void)saveRoomToLocalByRoomId:(NSString *)roomId withValue:(id)value {
    [[PlistHelper defaultDBHelper] addValueToPlistName:CollectRoomPlist withValue:value forKey:roomId];
}

- (void)deleteLocalSavedRoomByRoomId:(NSString *)roomId {
    [[PlistHelper defaultDBHelper] removeValueFromPlistName:CollectRoomPlist withKey:roomId];
}

@end
