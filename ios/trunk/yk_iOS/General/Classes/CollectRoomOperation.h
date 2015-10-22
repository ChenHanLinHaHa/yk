//
//  CollectRoomOperation.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/14.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectRoomOperation : NSObject

+ (id)defaultCollectRoomOperation;

- (void)saveRoomToLocalByRoomId:(NSString *)roomId withValue:(id)value;

- (void)deleteLocalSavedRoomByRoomId:(NSString *)roomId;

@end
