//
//  ResetPwdViewController.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/23.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ResetBlock)();

@interface ResetPwdViewController : BaseViewController

@property (nonatomic, strong) ResetBlock resetBlock;

@end
