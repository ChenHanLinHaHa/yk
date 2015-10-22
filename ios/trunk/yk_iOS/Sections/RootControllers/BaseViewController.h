//
//  BaseViewController.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVObject.h>

typedef enum : NSUInteger {
    Room_All_Data,
    Room_Detail_Data,
} DataType;

typedef void(^RefreshResultBlock)(BOOL isSuccess, NSArray *objects);
typedef void(^RoomDetailRelationResultBlock)(BOOL isSuccess,id result,NSString *title);

@interface BaseViewController : UIViewController

//子类调的刷新方法
- (void)beginRefreshWithDataType:(DataType)dataType withRefreshResultBlock:(RefreshResultBlock)block withRoomDetailRelationResultBlock:(RoomDetailRelationResultBlock)roomDetailRelationResultBlock;

- (void)loadMoreDataWithDataType:(DataType)dataType WithCount:(NSInteger)count withRefreshResultBlock:(RefreshResultBlock)block;

- (NSDictionary *)getCheckWhereKey;

- (NSArray *)getRelationTitles;

- (UIView *)getSelfView;

- (BOOL)isHaveTableView;

- (UITableView *)getSelfTableView;

- (void)againRefresh;

- (BOOL)isCanLoadMore;

- (void)removeLoadMoreRefresh;

- (void)loadMoreRefresh;

@end
