//
//  Charge_FooterCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PayBlock)(void);

@interface Charge_FooterCell : UITableViewCell
@property (nonatomic, strong) PayBlock payBlock;
@property (strong, nonatomic) IBOutlet UIButton *payBtn;

@end
