//
//  FindRoom_RootViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "FindRoom_RootViewController.h"
#import "FindRoomRoot_ContentCell.h"
#import "FindRoomRootSelect_BgView.h"
#import "RoomModel.h"
#import "PlistHelper.h"
#import "CollectRoomOperation.h"
#import "RoomDetailViewController.h"
#import "WelcomeViewController.h"

@interface FindRoom_RootViewController () {
    NSIndexPath *_tempIndexPath;
    IBOutlet FindRoomRootSelect_BgView *_checkBgView;
    IBOutlet UIView *_collectionBgView;
    BOOL _isHidden;
    IBOutlet UITableView *_myTableView;
    IBOutlet UIView *_select_CollectBgView;
    IBOutlet UIImageView *_shadowBgView;
    NSInteger _loadMoreCount;
}
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableString *resultStr;
@property (nonatomic, assign) BOOL isCheckAll;

@end

@implementation FindRoom_RootViewController

- (BOOL)isShowBack {
    return NO;
}

- (NSDictionary *)getCheckWhereKey {
    if (self.isCheckAll) {
        return @{@"RoomState":@"0"};
    } else {
        return @{@"Flag":_resultStr,@"RoomState":@"0"};
    }
}

- (UIView *)getSelfView {
    return self.view;
}

- (BOOL)isHaveTableView {
    return YES;
}

- (UITableView *)getSelfTableView {
    return _myTableView;
}

- (void)againRefresh {
    [self beginRefreshWithDataType:Room_All_Data withRefreshResultBlock:^(BOOL isSuccess, NSArray *objects) {
        if (isSuccess) {
            _loadMoreCount = 0;
            [_dataArr removeAllObjects];
            [self handleRoomModelWithOjbects:objects];
        }
    } withRoomDetailRelationResultBlock:nil];
}

- (void)loadMoreRefresh {
    _loadMoreCount++;
    [self loadMoreDataWithDataType:Room_All_Data WithCount:_loadMoreCount withRefreshResultBlock:^(BOOL isSuccess, NSArray *objects) {
        [self handleRoomModelWithOjbects:objects];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WelcomeViewController *welcomeVC = [kMainStoryboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
    [[UIApplication sharedApplication].keyWindow addSubview:welcomeVC.view];
    if ([AVOSCloudHelper isNeedLogin]) {
        UINavigationController *loginNav = [kMainStoryboard instantiateViewControllerWithIdentifier:@"LoginNav"];
        [self presentViewController:loginNav animated:YES completion:nil];
    }
    
    _dataArr = [NSMutableArray array];
    _isHidden = YES;
    _isCheckAll = YES;
    _loadMoreCount = 0;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithBtnTitle:@"筛选" target:self action:@selector(doCheckAction)];

    __weak typeof(self) weakSelf = self;
    _checkBgView.checkResultBlock = ^(NSMutableArray *indexs) {
        DebugLog(@"indexs = %@",indexs);
        [weakSelf hideSelectBgView];
        //处理筛选任务，indexs里存放的都是nsindexpath对象
        _resultStr = [NSMutableString string];
        for (NSIndexPath *indexPath in indexs) {
            [weakSelf.resultStr appendFormat:@"%ld",(long)indexPath.row];
        }
        if ([weakSelf.resultStr isEqualToString:@"0000"]) {
            weakSelf.isCheckAll = YES;
        } else {
            weakSelf.isCheckAll = NO;
        }
        [weakSelf beginRefreshWithDataType:Room_All_Data withRefreshResultBlock:^(BOOL isSuccess, NSArray *objects) {
            [weakSelf.dataArr removeAllObjects];
            [weakSelf handleRoomModelWithOjbects:objects];
        } withRoomDetailRelationResultBlock:nil];
    };
    [self beginRefreshWithDataType:Room_All_Data withRefreshResultBlock:^(BOOL isSuccess, NSArray *objects) {
        [weakSelf handleRoomModelWithOjbects:objects];
    } withRoomDetailRelationResultBlock:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doCancelCellCollected:) name:KCancelFindRoomCollectStateFromReverseVCDeleteNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doDeleteFinishReversedRoom:) name:kDeleteFinishReversedRoomNotification object:nil];
}

- (void)handleRoomModelWithOjbects:(NSArray *)objects {
    NSDictionary *localDic = [[PlistHelper defaultDBHelper] valueFormPlistName:CollectRoomPlist];
    for (RoomModel *object in objects) {
        BOOL isCollected = NO;
        if ([localDic.allKeys containsObject:object.roomId]) {
            isCollected = YES;
        }
        object.isCollected = [NSNumber numberWithBool:isCollected];
        [_dataArr addObject:object];
    }
    [_myTableView reloadData];
}

- (void)doCheckAction {
    [self resetLeftBarButtonItemTextColor];
    if (_isHidden) {
        _checkBgView.hidden = !_isHidden;
    }
    [UIView animateWithDuration:0.25 animations:^{
        if (_isHidden) {
            //显现
            _shadowBgView.alpha = 0.5;
            _select_CollectBgView.frame = CGRectMake(0, 0, kScreen_Width, 385);
        } else {
            _shadowBgView.alpha = 0;
            _select_CollectBgView.frame = CGRectMake(0, -385, kScreen_Width, 385);
        }
    } completion:^(BOOL finished) {
        if (!_isHidden) {
            _checkBgView.hidden = !_isHidden;
        }
        _isHidden = !_isHidden;
    }];
}

- (void)hideSelectBgView {
    [self resetLeftBarButtonItemTextColor];
    [UIView animateWithDuration:0.25 animations:^{
        _shadowBgView.alpha = 0;
        _select_CollectBgView.frame = CGRectMake(0, -385, kScreen_Width, 385);
    } completion:^(BOOL finished) {
        _checkBgView.hidden = YES;
        _isHidden = YES;
    }];
}

- (void)resetLeftBarButtonItemTextColor {
    if (_isHidden) {
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor orangeColor]} forState:UIControlStateNormal];
    } else {
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomModel *model = _dataArr[indexPath.row];
    FindRoomRoot_ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindRoomRoot_ContentCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[FindRoomRoot_ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FindRoomRoot_ContentCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.collectClickBlock = ^(BOOL isCollect) {
        model.isCollected = [NSNumber numberWithBool:isCollect];
    };
    cell.roomModel = model;
    if (model.isCollected.boolValue) {
        [cell.collectionBtn setImage:[UIImage imageNamed:@"collection_selected_image"] forState:UIControlStateNormal];
        cell.collectionBtn.isCollectFlag = YES;
    } else {
        [cell.collectionBtn setImage:[UIImage imageNamed:@"collection_normal_image"] forState:UIControlStateNormal];
        cell.collectionBtn.isCollectFlag = NO;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *headView = [[UIImageView alloc] init];
    headView.backgroundColor = [UIColor clearColor];
    return headView;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomModel *model = _dataArr[indexPath.row];
    RoomDetailViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"RoomDetailViewController"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.roomModel = model;
    vc.roomOriginalVC = FindRoomVC;
    vc.isCollected = model.isCollected.boolValue;
    vc.roomDetailCollectClickBlock = ^(BOOL isCollect) {
        FindRoomRoot_ContentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (isCollect) {
            model.isCollected = [NSNumber numberWithBool:YES];
            [cell.collectionBtn setImage:[UIImage imageNamed:@"collection_selected_image"] forState:UIControlStateNormal];
            cell.collectionBtn.isCollectFlag = YES;
        } else {
            model.isCollected = [NSNumber numberWithBool:NO];
            [cell.collectionBtn setImage:[UIImage imageNamed:@"collection_normal_image"] forState:UIControlStateNormal];
            cell.collectionBtn.isCollectFlag = NO;
        }
    };
    vc.reverseFinishBlock = ^(void) {
        //预订完成
        if (model.isCollected) {
            //删除本地收藏
            [[CollectRoomOperation defaultCollectRoomOperation] deleteLocalSavedRoomByRoomId:model.roomId];
        }
        [_dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doHideSelectBgView:(id)sender {
    [self hideSelectBgView];
}

- (void)doCancelCellCollected:(NSNotification *)notification {
    NSString *roomId = [notification object];
    FindRoomRoot_ContentCell *cell;
    RoomModel *roomModel;
    for (int i = 0; i < _dataArr.count; i++) {
        RoomModel *model = _dataArr[i];
        if ([model.roomId isEqualToString:roomId]) {
            roomModel = model;
            cell = [_myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            break;
        }
    }
    roomModel.isCollected = [NSNumber numberWithBool:NO];
    [cell.collectionBtn setImage:[UIImage imageNamed:@"collection_normal_image"] forState:UIControlStateNormal];
    cell.collectionBtn.isCollectFlag = NO;
}

- (void)doDeleteFinishReversedRoom:(NSNotification *)notification {
    NSString *roomId = [notification object];
    FindRoomRoot_ContentCell *cell;
    RoomModel *roomModel;
    NSUInteger index;
    for (int i = 0; i < _dataArr.count; i++) {
        RoomModel *model = _dataArr[i];
        if ([model.roomId isEqualToString:roomId]) {
            roomModel = model;
            index = i;
            cell = [_myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            break;
        }
    }
    [_dataArr removeObjectAtIndex:index];
    [_myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
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
