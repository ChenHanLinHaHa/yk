//
//  PlistHelper.h
//  HouseManager
//
//  Created by chenhanlin on 15/6/2.
//  Copyright (c) 2015年 chenhanlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistHelper : NSObject

+ (PlistHelper *)defaultDBHelper;

- (void)creatPlistFile:(NSString *)plistName;

- (void)addValueToPlistName:(NSString *)plist withValue:(id)value forKey:(NSString *)key;

- (void)removeValueFromPlistName:(NSString *)plist withKey:(NSString *)key;

- (id)valueFromPlistName:(NSString *)plist ForKey:(NSString *)key;

- (id)valueFormPlistName:(NSString *)plist;

- (NSString *)documentResource:(NSString *)fileName;

@end
