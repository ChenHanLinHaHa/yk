//
//  PhotoBrowerHelper.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/13.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWPhotoBrowser.h>

@interface PhotoBrowerHelper : NSObject<MWPhotoBrowserDelegate>

@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;

+(PhotoBrowerHelper *)defaultPhotoBrowerHelper;

- (void)showBrowserWithImages:(NSArray *)imageArray;

@end
