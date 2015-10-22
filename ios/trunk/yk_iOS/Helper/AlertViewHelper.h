//
//  AlertViewHelper.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/13.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CertainClickBlock)(void);

@interface AlertViewHelper : NSObject<UIAlertViewDelegate> {
    CertainClickBlock _certainClickBlock;
}

+ (AlertViewHelper *)defaultAlertViewHelper;

- (void)showAlertView:(NSString *)content withRightTitle:(NSString *)rightTitle withCertainClickBlock:(CertainClickBlock)block;

@end
