//
//  CouponCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//
#define kCellIdentifier_Couopn @"CouponCell"
#define kCouponCellHeight 127

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DefaultType,
    CouponUnused,
    CouponUsed,
} CellType;

typedef CellType(^CellTypeBlock)(void);

@interface CouponCell : UITableViewCell {
    
    IBOutlet UIImageView *_bgImageView;
}

@property (nonatomic, assign) CellTypeBlock cellTypeBlock;

@end
