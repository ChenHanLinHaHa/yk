//
//  RoomDetail_HMInfoCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBlock)(NSString *telephone);

@interface RoomDetail_HMInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *HMNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (nonatomic, strong) CallBlock callBlock;

@end
