//
//  UserDefaultManager.h
//  House_Project
//
//  Created by chenhanlin on 15/10/2.
//  Copyright © 2015年 chenhanlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultManager : NSObject

+ (void)saveObject:(id)object forKey:(id)key;

+ (id)getObjectForKey:(id)key;

@end
