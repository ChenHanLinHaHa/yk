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
typedef void(^RegisterResultBlock)(BOOL isRegisterSuccess,NSUInteger errorCode,NSString *username, NSString *password, NSString *email);
typedef void(^LoginResultBlock)(BOOL isLoginSuccess, NSInteger errorCode);
typedef void(^ResetPWDResultBlock)(BOOL isResetSuccess);
typedef void(^ModifyPWDResultBlock)(BOOL isModifySuccess, NSString *newPwd);

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


//判断是否需要登录
+(BOOL)isNeedLogin;
//登出
+(BOOL)logout;
//登录
+(void)loginWithUsename:(NSString *)username withPassword:(NSString *)password withLoginResultBlock:(LoginResultBlock)block;
//注册
+(void)registerWithUsername:(NSString *)username withPassword:(NSString *)password withEmail:(NSString *)email withRegisterResultBlock:(RegisterResultBlock)block;
//重置密码
+(void)resetPWDWithEmail:(NSString *)email withResetPwdResult:(ResetPWDResultBlock)block;
//修改密码
+(void)modifyPWDWithUsername:(NSString *)username withOldPassword:(NSString *)password withNewPassword:(NSString *)newPassword withModifyPwdBlock:(ModifyPWDResultBlock)block;

@end
