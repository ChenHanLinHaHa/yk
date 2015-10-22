//
//  RoomDetailModel.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/19.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoomDetailModel : NSObject

@property (nonatomic, strong) NSArray * roomOthersArr;
@property (nonatomic, strong) NSDictionary * RoomGeoDic;
@property (nonatomic, strong) NSArray * roomImagesArr;
@property (nonatomic, strong) NSArray * roomsSameVilageArr;

@property (nonatomic, strong) NSString *RoomPrice;
@property (nonatomic, strong) NSString *RoomId;
@property (nonatomic, strong) NSString *RoomCash;
@property (nonatomic, strong) NSString *RoomDeposit;
@property (nonatomic, strong) NSString *RoomDescribe;
@property (nonatomic, strong) NSString *RoomImage;
@property (nonatomic, strong) NSString *RoomType;
@property (nonatomic, strong) NSString *RoomArea;
@property (nonatomic, strong) NSString *RoomFloor;
@property (nonatomic, strong) NSString *RoomDirection;
@property (nonatomic, strong) NSString *RoomBed;
@property (nonatomic, strong) NSString *RoomVillage;
@property (nonatomic, strong) NSString *RoomManager;
@property (nonatomic, strong) NSString *RoomManagerTel;
@property (nonatomic, strong) NSString *RoomState;

@end

@interface RoomOthers : NSObject
@property (nonatomic, strong) NSString *RoomCode;
@property (nonatomic, strong) NSString *RoomId;
@property (nonatomic, strong) NSString *RoomArea;
@property (nonatomic, strong) NSString *RoomPrice;
@property (nonatomic, strong) NSString *RoomState;
@property (nonatomic, strong) NSString *RoomMateSex;
@property (nonatomic, assign) BOOL isHaveBayWindow;
@property (nonatomic, assign) BOOL isHaveBalcony;
@property (nonatomic, assign) BOOL isHaveIndependentToilet;
@end

@interface RoomGeo : NSObject
@property (nonatomic, strong) NSString *Latitude;
@property (nonatomic, strong) NSString *Longitude;
@end

@interface RoomImages : NSObject
@property (nonatomic, strong) NSString *RoomImage;
@end

@interface RoomsSameVilage : NSObject
@property (nonatomic, strong) NSString *RoomCode;
@property (nonatomic, strong) NSString *RoomId;
@property (nonatomic, strong) NSString *RoomImage;
@property (nonatomic, strong) NSString *RoomPrice;
@end

