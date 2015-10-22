//
//  FindRoomRootSelectFooter_CollectionReusableView.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CheckBtnClickBlock)(void);

@interface FindRoomRootSelectFooter_CollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) CheckBtnClickBlock checkBtnClickBlock;

@end
