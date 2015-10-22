//
//  Reverse_CountdownCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PayOtherMoneyClick)(void);

@interface Reverse_CountdownCell : UITableViewCell {
    
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *describeLabel;
    IBOutlet UIImageView *roomImageView;
}

@property (nonatomic, strong) PayOtherMoneyClick payOtherMoneyClick;

@property (nonatomic, strong) RoomModel *roomModel;

@end
