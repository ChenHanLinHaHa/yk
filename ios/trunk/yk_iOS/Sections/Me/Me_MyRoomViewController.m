//
//  Me_MyRoomViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/15.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Me_MyRoomViewController.h"
#import "MyRoomCell.h"
#import "RoomDetailViewController.h"

@interface Me_MyRoomViewController ()
{
    NSMutableArray *_dataArr;
    IBOutlet UITableView *_myTableView;
    NSInteger _loadMoreCount;
}
@end

@implementation Me_MyRoomViewController

- (NSDictionary *)getCheckWhereKey {
    return @{@"RoomState":@"2"};
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

- (BOOL)isCanLoadMore {
    return NO;
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
    _loadMoreCount = 0;
    _dataArr = [NSMutableArray array];
    
    [self beginRefreshWithDataType:Room_All_Data withRefreshResultBlock:^(BOOL isSuccess, NSArray *objects) {
        if (isSuccess) {
            [self handleRoomModelWithOjbects:objects];
        }
    } withRoomDetailRelationResultBlock:nil];
}

- (void)handleRoomModelWithOjbects:(NSArray *)objects {
    _dataArr = [NSMutableArray arrayWithArray:objects];
    [_myTableView reloadData];
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
    MyRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyRoomCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MyRoomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyRoomCell"];
    }
    cell.roomModel = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //解约流程
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"申请解约";
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomModel *model = _dataArr[indexPath.row];
    RoomDetailViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"RoomDetailViewController"];
    vc.roomOriginalVC = Me_MyRoomVC;
    vc.roomModel = model;
    [self.navigationController pushViewController:vc animated:YES];
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
