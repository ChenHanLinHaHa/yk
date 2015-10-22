//
//  AppMacro.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

typedef enum : int {
    MyElectric,
    myRoomRent,
    AllMoney_Reverse,//全额预订
    Deposit_Reverse,//订金预订
    OtherMoney_Reverse,//余额－订金预订
} RentType;

typedef enum : int {
    Charge,
    Pay_Rent,
    Pay_Electric,
    Pay_AllMoney_Reverse,
    Pay_Deposit_Reverse,
    Pay_OtherMoney_Reverse,
} PayType;

typedef enum : int {
    Success,
    Fail,
    IsWaiting,
} PayResultType;

#define kColorTableBG [UIColor colorWithHexString:@"0xfafafa"]
#define kMySegmentControlIcon_Height 50.0

//郑州中心经纬度
#define KLatitude 34.7568711
#define KLongitude 113.663221

#define IsFirstLaunch @"IsFirstLaunch"
#define CollectRoomPlist @"CollectRoomPlist.plist"

#define CountLimit 5 //一次加载的最大数据条数

#define KShareViewHeight 300

#endif /* AppMacro_h */
