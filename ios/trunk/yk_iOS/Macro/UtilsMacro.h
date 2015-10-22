//
//  UtilsMacro.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (kScreen_Width/320))
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#define kTipAlert(_S_,_K_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:[NSString stringWithFormat:(_K_), ##__VA_ARGS__] otherButtonTitles:nil] show]

//设备型号
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//屏幕大小
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kScreen_Width [UIScreen mainScreen].bounds.size.width

//windor,mainStoryboard
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kMainStoryboard [UIStoryboard storyboardWithName:@"Main" bundle:nil]
#define kMainBundle [NSBundle mainBundle]


#endif /* UtilsMacro_h */
