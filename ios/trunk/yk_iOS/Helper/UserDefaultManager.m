//
//  UserDefaultManager.m
//  House_Project
//
//  Created by chenhanlin on 15/10/2.
//  Copyright © 2015年 chenhanlin. All rights reserved.
//

#import "UserDefaultManager.h"

@implementation UserDefaultManager

+ (void)saveObject:(id)object forKey:(id)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:object forKey:key];
    [defaults synchronize];
}

+ (id)getObjectForKey:(id)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

@end
