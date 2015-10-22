//
//  FindRoomRootSelect_BgView.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CheckResultBlock)(NSMutableArray *indexs);

@interface FindRoomRootSelect_BgView : UIView {
    NSArray *_headDataArr;
    NSArray *_sectionDataArr;
    NSArray *_subwayDataArr;
    NSArray *_rentDataArr;
    NSArray *_roomTypeDataArr;
    NSMutableDictionary *_selectCellDic;
}

@property (nonatomic, strong) CheckResultBlock checkResultBlock;

@end
