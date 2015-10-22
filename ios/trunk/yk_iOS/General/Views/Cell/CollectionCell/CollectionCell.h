//
//  CollectionCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoomModel.h"
typedef void(^ReverseClickBlock)(int index);
@interface CollectionCell : UITableViewCell

@property (nonatomic, strong) RoomModel *roomModel;
@property (nonatomic, strong) ReverseClickBlock reverseClickBlock;

@property (strong, nonatomic) IBOutlet UIImageView *roomImageView;
@property (strong, nonatomic) IBOutlet UILabel *roomReverseMoneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *roomPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *roomDescribeLabel;
@end
