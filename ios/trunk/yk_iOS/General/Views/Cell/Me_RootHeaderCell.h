//
//  Me_RootHeaderCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyCouponClickBlock)(void);
typedef void(^MyBalanceClickBlock)(void);
typedef void(^MyReverseClickBlock)(void);

@interface Me_RootHeaderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bgImageView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;


@property (nonatomic, strong) MyCouponClickBlock myCouopnClickBlock;
@property (nonatomic, strong) MyBalanceClickBlock myBalanceClickBlock;
@property (nonatomic, strong) MyReverseClickBlock myReverseClickBlock;

- (void)configUI;

@end
