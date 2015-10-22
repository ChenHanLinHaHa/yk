//
//  AVOSCloudHelper.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/15.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SaveResultBlock)(BOOL isSavedSuccess);
typedef void(^QueryResultBlock)(BOOL isQuerySuccess ,NSArray *objects);
typedef void(^QueryRelationResultBlock)(BOOL isQuerySuccess ,NSArray *objects, NSString *title);
typedef void(^DeleteResultBlock)(BOOL isDeleteSuccess);

@interface AVOSCloudHelper : NSObject

//保存数据
+(void)saveToObjectClass:(NSString *)ObjectClass withDic:(NSDictionary *)dic withResultBlock:(SaveResultBlock)block;

//存数组（dicArr里key＝数组字段，value＝array）
+(void)saveToObjectClass:(NSString *)ObjectClass withDic:(NSDictionary *)dic  withDicArr:(NSArray *)dicArr withResultBlock:(SaveResultBlock)block;

+(void)refreshToObjectClass:(NSString *)ObjectClass withWhereKey:(NSString *)whereKey withRefreshArr:(NSArray *)refreshArr withRefreshToDic:(NSDictionary *)dic withResultBlock:(SaveResultBlock)block;

//获取表下所有数据
+(void)getAllObjectsFromObjectClass:(NSString *)objectClass withCount:(NSInteger)count withResultBlock:(QueryResultBlock)block;

//条件筛选
+(void)getFromObjectClass:(NSString *)ObjectClass withWhereKey:(NSArray *)whereKeys withValue:(NSArray *)values withCount:(NSInteger)count withResultBlock:(QueryResultBlock)block;

+(void)getRelationObject:(AVObject *)object withRelationTitle:(NSString *)title withResultBlock:(QueryRelationResultBlock)block;

//条件删除
+(void)deleteObjectFromObjectClass:(NSString *)ObjectClass withWhereKey:(NSString *)whereKey withDeleteArr:(NSArray *)deleteArr withResultBlock:(DeleteResultBlock)block;

@end
