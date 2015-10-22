//
//  AVOSCloudHelper.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/15.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "AVOSCloudHelper.h"

@implementation AVOSCloudHelper

+(void)saveToObjectClass:(NSString *)ObjectClass withDic:(NSDictionary *)dic withResultBlock:(SaveResultBlock)block {
    AVObject *post = [AVObject objectWithClassName:ObjectClass];
    NSArray *keys = dic.allKeys;
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *value = [dic objectForKey:key];
        [post setObject:value forKey:key];
    }
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        block(succeeded);
    }];
}

+(void)saveToObjectClass:(NSString *)ObjectClass withDic:(NSDictionary *)dic  withDicArr:(NSArray *)dicArr withResultBlock:(SaveResultBlock)block{
    AVObject *post = [AVObject objectWithClassName:ObjectClass];
    NSArray *keys = dic.allKeys;
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        NSString *value = [dic objectForKey:key];
        [post setObject:value forKey:key];
    }
    for (int j = 0; j < dicArr.count; j++) {
        NSDictionary *dic = dicArr[j];
        [post addUniqueObjectsFromArray:[dic.allValues firstObject] forKey:[dic.allKeys firstObject]];
    }
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        block(succeeded);
    }];
}

+(void)refreshToObjectClass:(NSString *)ObjectClass withWhereKey:(NSString *)whereKey withRefreshArr:(NSArray *)refreshArr withRefreshToDic:(NSDictionary *)dic withResultBlock:(SaveResultBlock)block {
    AVQuery *query = [AVQuery queryWithClassName:ObjectClass];
    [query whereKey:whereKey containedIn:refreshArr];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSString *key = [dic.allKeys firstObject];
            NSString *value = [dic.allValues firstObject];
            for (int i = 0; i < objects.count; i++) {
                AVObject *object = objects[i];
                object[key] = value;
            }
            [AVObject saveAllInBackground:objects block:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    block(YES);
                } else {
                    block(NO);
                }
            }];
        } else {
        }
    }];
}

+(void)getAllObjectsFromObjectClass:(NSString *)objectClass withCount:(NSInteger)count withResultBlock:(QueryResultBlock)block {
    AVQuery *query = [AVQuery queryWithClassName:objectClass];
    query.limit = CountLimit;
    query.skip = count*CountLimit;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            block(YES ,objects);
        } else {
            block(NO, nil);
        }
    }];
}

+(void)getFromObjectClass:(NSString *)ObjectClass withWhereKey:(NSArray *)whereKeys withValue:(NSArray *)values withCount:(NSInteger)count withResultBlock:(QueryResultBlock)block {
    AVQuery *query = [AVQuery queryWithClassName:ObjectClass];
    for (int i = 0; i < whereKeys.count; i++) {
        [query whereKey:whereKeys[i] equalTo:values[i]];
    }
    query.limit = CountLimit;
    query.skip = count*CountLimit;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            block(YES ,objects);
        } else {
            block(NO, nil);
        }
    }];
}

+(void)getRelationObject:(AVObject *)object withRelationTitle:(NSString *)title withResultBlock:(QueryRelationResultBlock)block {
    AVRelation *finalObject = [object objectForKey:title];
    [[finalObject query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            block(YES,objects,title);
        } else {
            block(NO, nil, title);
        }
    }];
}

//批量删除(根据key)
+(void)deleteObjectFromObjectClass:(NSString *)ObjectClass withWhereKey:(NSString *)whereKey withDeleteArr:(NSArray *)deleteArr withResultBlock:(DeleteResultBlock)block {
    AVQuery *query = [AVQuery queryWithClassName:ObjectClass];
    [query whereKey:whereKey containedIn:deleteArr];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (AVObject *object in objects) {
                [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        block(YES);
                    } else {
                        block(NO);
                    }
                }];
            }
        } else {
        }
    }];
}

@end
