//
//  PlistHelper.m
//  HouseManager
//
//  Created by chenhanlin on 15/6/2.
//  Copyright (c) 2015年 chenhanlin. All rights reserved.
//

#import "PlistHelper.h"

@implementation PlistHelper

+ (PlistHelper *)defaultDBHelper
{
    static PlistHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[PlistHelper alloc] init];
    });
    return helper;
}

- (void)creatPlistFile:(NSString *)plistName
{
    NSString *plistPath = [self documentResource:plistName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL res = [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
    if (res) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic writeToFile:plistPath atomically:YES];
        NSLog(@"plist创建成功 : %@", plistPath);
    } else {
        NSLog(@"plist创建失败");
    }
}

- (void)addValueToPlistName:(NSString *)plist withValue:(id)value forKey:(NSString *)key
{
    NSString *plistPath = [self documentResource:plist];
    NSMutableDictionary *dict = [[NSMutableDictionary dictionaryWithContentsOfFile:plistPath] mutableCopy];
    [dict setObject:value forKey:key];
    BOOL isSuccess = [dict writeToFile:plistPath atomically:YES];
    DebugLog(@"isSuccess = %@",isSuccess?@"YES":@"NO");
}

- (void)removeValueFromPlistName:(NSString *)plist withKey:(NSString *)key {
    NSString *plistPath = [self documentResource:plist];
    NSMutableDictionary *dict = [[NSMutableDictionary dictionaryWithContentsOfFile:plistPath] mutableCopy];
    [dict removeObjectForKey:key];
    [dict writeToFile:plistPath atomically:YES];
}

- (id)valueFromPlistName:(NSString *)plist ForKey:(NSString *)key
{
    NSString *plistPath = [self documentResource:plist];
    NSMutableDictionary *dict = [[NSMutableDictionary dictionaryWithContentsOfFile:plistPath] mutableCopy];
    return [dict objectForKey:key];
}

- (id)valueFormPlistName:(NSString *)plist {
    NSString *plistPath = [self documentResource:plist];
    NSMutableDictionary *dict = [[NSMutableDictionary dictionaryWithContentsOfFile:plistPath] mutableCopy];
    return dict;
}

- (NSString *)documentResource:(NSString *)fileName
{
    static NSString* documentsPath = nil;
    if (!documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:fileName];
}

@end
