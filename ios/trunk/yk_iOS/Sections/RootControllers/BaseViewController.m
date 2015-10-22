//
//  BaseViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "BaseViewController.h"
#import <ODRefreshControl.h>
#import "RoomDetailModel.h"

@interface BaseViewController () {
    UILabel *_nullMoreDataLabel;
}
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@end

@implementation BaseViewController

#pragma 子类重写
- (BOOL)isShowBack {
    return YES;
}

- (NSDictionary *)getCheckWhereKey {
    return nil;
}

- (NSArray *)getRelationTitles {
    return nil;
}

- (UIView *)getSelfView {
    return self.view;
}

- (UITableView *)getSelfTableView {
    return nil;
}

- (BOOL)isHaveTableView {
    return NO;
}

- (void)againRefresh {
    
}

- (BOOL)isCanLoadMore {
    return YES;
}

- (void)loadMoreRefresh {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self isShowBack]) {
        [self createLeftItem];
    }
    
    if ([self isHaveTableView]) {
        _refreshControl = [[ODRefreshControl alloc] initInScrollView:[self getSelfTableView]];
        [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
        if ([self isCanLoadMore]) {
            [[self getSelfTableView] addInfiniteScrollingWithActionHandler:^{
                [self loadMoreRefresh];
            }];
            _nullMoreDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
            _nullMoreDataLabel.text = @"已经是最多房间";
            _nullMoreDataLabel.textAlignment = NSTextAlignmentCenter;
            _nullMoreDataLabel.textColor = [UIColor lightGrayColor];
        }
    }
}

- (void)createLeftItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"left_nav_image" showBadge:NO target:self action:@selector(leftItemClick)];
}

- (void)leftItemClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refresh {
    [self againRefresh];
}

- (void)beginRefreshWithDataType:(DataType)dataType withRefreshResultBlock:(RefreshResultBlock)block withRoomDetailRelationResultBlock:(RoomDetailRelationResultBlock)roomDetailRelationResultBlock {
    UIView *view = [self getSelfView];
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    switch (dataType) {
        case Room_All_Data:
        {
            [MBProgressHUD hideAllHUDsForView:view animated:YES];
            NSDictionary *whereDic = [self getCheckWhereKey];
            [AVOSCloudHelper getFromObjectClass:AC_AllRooms withWhereKey:whereDic.allKeys withValue:whereDic.allValues withCount:0 withResultBlock:^(BOOL isQuerySuccess, NSArray *objects) {
                [MBProgressHUD hideHUDForView:view animated:YES];
                if (_refreshControl.refreshing) {
                    [_refreshControl endRefreshing];
                }
                if (isQuerySuccess) {
                    block(YES,[self transferToRoomModelWithOjbects:objects]);
                } else {
                    block(NO,nil);
                }
            }];
        }
            break;
        case Room_Detail_Data:
        {
            [MBProgressHUD hideAllHUDsForView:view animated:YES];
            NSDictionary *whereDic = [self getCheckWhereKey];
            [AVOSCloudHelper getFromObjectClass:AC_RoomDetail withWhereKey:whereDic.allKeys withValue:whereDic.allValues withCount:0 withResultBlock:^(BOOL isQuerySuccess, NSArray *objects) {
                [MBProgressHUD hideHUDForView:view animated:YES];
                if (_refreshControl.refreshing) {
                    [_refreshControl endRefreshing];
                }
                if (isQuerySuccess) {
                    block(YES,[self transferToRoomDetailModelWithObjects:objects]);
                    [self handleRoomDetailRelationDataWithObject:objects.firstObject WithBlock:roomDetailRelationResultBlock];
                } else {
                    block(NO,nil);
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)loadMoreDataWithDataType:(DataType)dataType WithCount:(NSInteger)count withRefreshResultBlock:(RefreshResultBlock)block {
    UIView *view = [self getSelfView];
    [MBProgressHUD showHUDAddedTo:view animated:YES];
    switch (dataType) {
        case Room_All_Data:
        {
            NSDictionary *whereDic = [self getCheckWhereKey];
            [AVOSCloudHelper getFromObjectClass:AC_AllRooms withWhereKey:whereDic.allKeys withValue:whereDic.allValues withCount:count withResultBlock:^(BOOL isQuerySuccess, NSArray *objects) {
                [MBProgressHUD hideHUDForView:view animated:YES];
                if (_refreshControl.refreshing) {
                    [_refreshControl endRefreshing];
                }
                if (isQuerySuccess) {
                    if (objects.count != CountLimit) {
                        [[self getSelfTableView].infiniteScrollingView setCustomView:_nullMoreDataLabel forState:SVInfiniteScrollingStateStopped];
                    }
                    [[self getSelfTableView].infiniteScrollingView stopAnimating];
                    block(YES,[self transferToRoomModelWithOjbects:objects]);
                } else {
                    block(NO,nil);
                }
            }];
        }
            break;
            
        default:
            break;
    }
}

- (NSArray *)transferToRoomModelWithOjbects:(NSArray *)objects {
    NSMutableArray *modelArr = [NSMutableArray array];
    for (AVObject *object in objects) {
        NSString *roomId = object[@"RoomId"];
        NSString *roomPrice = object[@"RoomPrice"];
        NSString *roomDescribe = object[@"RoomDescribe"];
        NSString *roomImage = object[@"RoomImage"];
        NSString *roomDeposit = object[@"RoomDeposit"];
        RoomModel *model = [[RoomModel alloc] initWithDic:@{@"roomId":roomId,@"roomPrice":roomPrice,@"roomDescribe":roomDescribe,@"roomImage":roomImage,@"roomDeposit":roomDeposit,@"isCollected":[NSNumber numberWithBool:NO]}];
        [modelArr addObject:model];
    }
    return modelArr;
}

- (NSArray *)transferToRoomDetailModelWithObjects:(NSArray *)objects {
    AVObject *object = objects.firstObject;
    
    RoomDetailModel *roomDetailModel = [[RoomDetailModel alloc] init];
    roomDetailModel.RoomPrice = object[@"RoomPrice"];
    roomDetailModel.RoomId = object[@"RoomId"];
    roomDetailModel.RoomCash = object[@"RoomCash"];
    roomDetailModel.RoomDeposit = object[@"RoomDeposit"];
    roomDetailModel.RoomDescribe = object[@"RoomDescribe"];
    
    roomDetailModel.RoomBed = object[@"RoomBed"];
    roomDetailModel.RoomVillage = object[@"RoomVillage"];
    roomDetailModel.RoomManager = object[@"RoomManager"];
    roomDetailModel.RoomManagerTel = object[@"RoomManagerTel"];
    roomDetailModel.RoomState = object[@"RoomState"];
    
    roomDetailModel.RoomImage = object[@"RoomImage"];
    roomDetailModel.RoomType = object[@"RoomType"];
    roomDetailModel.RoomArea = object[@"RoomArea"];
    roomDetailModel.RoomFloor = object[@"RoomFloor"];
    roomDetailModel.RoomDirection = object[@"RoomDirection"];
    return @[roomDetailModel];
}

- (void)handleRoomDetailRelationDataWithObject:(AVObject *)object WithBlock:(RoomDetailRelationResultBlock)block {
    NSArray *titles = [self getRelationTitles];
    for (NSString *title in titles) {
        [AVOSCloudHelper getRelationObject:object withRelationTitle:title withResultBlock:^(BOOL isQuerySuccess, NSArray *objects, NSString *title) {
            if (!isQuerySuccess) {
                block(NO,nil,title);
            }
            if ([title isEqualToString:@"RoomOthers"]) {
                NSMutableArray *roomOthersArr = [NSMutableArray array];
                for (AVObject *object in objects) {
                    RoomOthers *roomOthers = [[RoomOthers alloc] init];
                    roomOthers.RoomCode = object[@"RoomCode"];
                    roomOthers.RoomId = object[@"RoomId"];
                    roomOthers.RoomArea = object[@"RoomArea"];
                    roomOthers.RoomPrice = object[@"RoomPrice"];
                    roomOthers.RoomState = object[@"RoomState"];
                    roomOthers.RoomMateSex = object[@"RoomMateSex"];
                    roomOthers.isHaveBayWindow = ((NSNumber *)(object[@"isHaveBayWindow"])).boolValue;
                    roomOthers.isHaveBalcony = ((NSNumber *)(object[@"isHaveBalcony"])).boolValue;
                    roomOthers.isHaveIndependentToilet = ((NSNumber *)(object[@"isHaveIndependentToilet"])).boolValue;
                    [roomOthersArr addObject:roomOthers];
                }
                block(YES,roomOthersArr,title);
            } else if ([title isEqualToString:@"RoomImages"]) {
                NSMutableArray *roomImagesArr = [NSMutableArray array];
                for (AVObject *object in objects) {
                    RoomImages *roomImages = [[RoomImages alloc] init];
                    roomImages.RoomImage = object[@"RoomImage"];
                    [roomImagesArr addObject:roomImages];
                }
                block(YES,roomImagesArr, title);
            } else if ([title isEqualToString:@"RoomsSameVillage"]) {
                NSMutableArray *roomsSameVillageArr = [NSMutableArray array];
                for (AVObject *object in objects) {
                    RoomsSameVilage *roomsSameVilage = [[RoomsSameVilage alloc] init];
                    roomsSameVilage.RoomCode = object[@"RoomCode"];
                    roomsSameVilage.RoomId = object[@"RoomId"];
                    roomsSameVilage.RoomImage = object[@"RoomImage"];
                    roomsSameVilage.RoomPrice = object[@"RoomPrice"];
                    [roomsSameVillageArr addObject:roomsSameVilage];
                }
                block(YES,roomsSameVillageArr, title);
            } else if ([title isEqualToString:@"Location"]) {
                AVObject *object = objects.firstObject;
                NSDictionary *RoomGeoDic = @{@"Latitude":object[@"Latitude"],@"Longitude":object[@"Longitude"]};
                block(YES,RoomGeoDic, title);
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
