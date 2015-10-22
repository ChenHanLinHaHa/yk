//
//  AlertControllerHelper.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "AlertControllerHelper.h"

@implementation AlertControllerHelper

+ (AlertControllerHelper *)defaultAlertControllerHelper {
    static AlertControllerHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[AlertControllerHelper alloc] init];
    });
    return helper;
}

- (void)showAlertControllerwithClickIndexBlock:(ClickIndexBlock)clickIndexBlock {
    _clickIndexBlock = clickIndexBlock;
    
    NSString *title = @"请选择预订方式";
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"一个月房租＋一个月押金" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _clickIndexBlock(0);
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"订金300元" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _clickIndexBlock(1);
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            _clickIndexBlock(2);
        }]];
        [selected_navigation_controller() presentViewController:alert animated:YES completion:nil];
    } else {
        UIActionSheet *actionsheet = [[UIActionSheet alloc]
                                      initWithTitle:title
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"一个月房租＋一个月押金"
                                      otherButtonTitles:@"订金300元",nil];
        [actionsheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    _clickIndexBlock((int)buttonIndex);
}

@end
