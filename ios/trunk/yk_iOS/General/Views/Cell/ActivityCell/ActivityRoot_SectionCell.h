//
//  ActivityRoot_SectionCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/19.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CouponSectionBlock)(void);
typedef void(^NewVIPSectionBlock)(void);
typedef void(^SpecialRoomSectionBlock)(void);

@interface ActivityRoot_SectionCell : UITableViewCell {
    
    IBOutlet UIView *_couopnSectionBgView;
    IBOutlet UIView *_newVIPSectionBgView;
    IBOutlet UIView *_specialRoomSectionBgView;
}

@property (nonatomic, strong) CouponSectionBlock couponSectionBlock;
@property (nonatomic, strong) NewVIPSectionBlock newVIPSectionBlock;
@property (nonatomic, strong) SpecialRoomSectionBlock specialRoomSectionBlock;

@end
