//
//  Me_ReverseViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Me_ReverseViewController.h"
#import "Reverse_CountdownCell.h"
#import "Me_RentViewController.h"
#import "RoomDetailViewController.h"

@interface Me_ReverseViewController ()
{
    NSMutableArray *_dataArr;
    IBOutlet UITableView *_myTableView;
    UILabel *_headLabel;
    IBOutlet UIImageView *_defaultTextImageView;
    NSInteger _loadMoreCount;
}
@end

@implementation Me_ReverseViewController

- (NSDictionary *)getCheckWhereKey {
    return @{@"RoomState":@"1"};
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
        [self handleRoomModelWithOjbects:objects];
    } withRoomDetailRelationResultBlock:nil];
}

- (void)handleRoomModelWithOjbects:(NSArray *)objects {
    _dataArr = [NSMutableArray arrayWithArray:objects];
    [_myTableView reloadData];
    if (_dataArr.count == 0) {
        _defaultTextImageView.hidden = NO;
    } else {
        _defaultTextImageView.hidden = YES;
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
    Reverse_CountdownCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reverse_CountdownCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[Reverse_CountdownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Reverse_CountdownCell"];
    }
    cell.payOtherMoneyClick = ^(void) {
        Me_RentViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_RentViewController"];
        vc.rentType = OtherMoney_Reverse;
        vc.roomModel = model;
        vc.reverseBlock = ^(void) {
            [self deleteCollectRoom:indexPath withTableView:tableView];
        };
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.roomModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)deleteCollectRoom:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView {
    [_dataArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    if (_dataArr.count > 0) {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, kScreen_Width-40, 50)];
        _headLabel.text = @"       在倒计时内取消预订将退还一半定金，否则将不退还定金。";
        _headLabel.font = [UIFont systemFontOfSize:13];
        _headLabel.textColor = [UIColor redColor];
        _headLabel.numberOfLines = 0;
        [headView addSubview:_headLabel];
    }
    return headView;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_dataArr > 0) {
        return 60;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RoomModel *model = _dataArr[indexPath.row];
    RoomDetailViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"RoomDetailViewController"];
    vc.roomOriginalVC = Me_ReverseVC;
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
