//
//  AppDelegate.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "AppDelegate.h"
#import "PlistHelper.h"
#import "UserDefaultManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerBaiduMapSDK];
    [self registerAVOSCloud];
    [self registerShareSDK];
    if (![UserDefaultManager getObjectForKey:IsFirstLaunch]) {
        [self createLocalPlist];
        [UserDefaultManager saveObject:[NSNumber numberWithBool:YES] forKey:IsFirstLaunch];
    }
    return YES;
}

- (void)createLocalPlist {
    [[PlistHelper defaultDBHelper] creatPlistFile:CollectRoomPlist];
}

- (void)registerBaiduMapSDK {
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定 generalDelegate参数
    BOOL ret = [mapManager start:BaiduAK generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (void)registerShareSDK {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:wbAppKey];
    [WXApi registerApp:wxAppId withDescription:@"yike"];
    
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:qqAPPID andDelegate:self];
}

- (void)registerAVOSCloud {
    [AVOSCloud setApplicationId:AVOSCloud_AppId clientKey:AVOSCloud_AppKey];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *string = [url absoluteString];
    if ([string hasPrefix:@"wx"]) {
        return  [WXApi handleOpenURL:url delegate:self];
    } else if ([string hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else if ([string hasPrefix:@"tencent"]) {
        return [QQApiInterface handleOpenURL:url delegate:self];
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *string = [url absoluteString];
    if ([string hasPrefix:@"wx"]) {
        return  [WXApi handleOpenURL:url delegate:self];
    } else if ([string hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else if ([string hasPrefix:@"tencent"]) {
        return [QQApiInterface handleOpenURL:url delegate:self];
    }
    return NO;
}
#pragma mark - qq/weixin
- (void)onResp:(id)resp
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([resp isKindOfClass:[BaseResp class]]) {
            if([resp isKindOfClass:[SendMessageToWXResp class]])
            {
                if (((SendMessageToWXResp *)resp).errCode == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                } else if (((SendMessageToWXResp *)resp).errCode == -2){
                    [SVProgressHUD showInfoWithStatus:@"已取消分享"];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"分享失败"];
                }
            }
        } else if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
            switch (((QQBaseReq *)resp).type)
            {
                case ESENDMESSAGETOQQRESPTYPE:
                {
                    SendMessageToQQResp* sendResp = (SendMessageToQQResp*)resp;
                    if ([sendResp.result integerValue] == 0) {
                        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                    } else if ([sendResp.result integerValue] == -4) {
                        [SVProgressHUD showInfoWithStatus:@"已取消分享"];
                    } else {
                        [SVProgressHUD showErrorWithStatus:@"分享失败"];
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
        }
    });
}
#pragma mark - weibo
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
    } else if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
        [SVProgressHUD showInfoWithStatus:@"已取消分享"];
    } else {
        [SVProgressHUD showErrorWithStatus:@"分享失败"];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.yike.com.yk_iOS" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"yk_iOS" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"yk_iOS.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
