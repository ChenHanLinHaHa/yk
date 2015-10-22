//
//  AlertViewHelper.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/13.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "AlertViewHelper.h"

@implementation AlertViewHelper

+ (AlertViewHelper *)defaultAlertViewHelper {
    static AlertViewHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[AlertViewHelper alloc] init];
    });
    return helper;
}

- (void)showAlertView:(NSString *)content withRightTitle:(NSString *)rightTitle withCertainClickBlock:(CertainClickBlock)block {
    _certainClickBlock = block;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:rightTitle, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        _certainClickBlock();
    }
}

@end
