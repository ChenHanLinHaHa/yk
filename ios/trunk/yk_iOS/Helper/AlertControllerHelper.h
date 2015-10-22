//
//  AlertControllerHelper.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ClickIndexBlock)(int index);

@interface AlertControllerHelper : NSObject<UIActionSheetDelegate> {
    ClickIndexBlock _clickIndexBlock;
}

+ (AlertControllerHelper *)defaultAlertControllerHelper;

- (void)showAlertControllerwithClickIndexBlock:(ClickIndexBlock)clickIndexBlock;

@end
