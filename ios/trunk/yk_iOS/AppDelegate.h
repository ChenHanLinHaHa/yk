//
//  AppDelegate.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate, TencentSessionDelegate, QQApiInterfaceDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) TencentOAuth* tencentOAuth;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

