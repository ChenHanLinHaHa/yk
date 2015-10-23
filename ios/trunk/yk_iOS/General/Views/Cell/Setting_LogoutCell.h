//
//  Setting_LogoutCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/23.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LogoutBlock)(void);

@interface Setting_LogoutCell : UITableViewCell

@property (nonatomic, strong) LogoutBlock logoutBlock;

@end
