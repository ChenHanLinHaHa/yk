//
//  Reverse_RootViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Reverse_RootViewController.h"
#import "CollectionCell.h"
#import "RoomDetailViewController.h"
#import "Me_RentViewController.h"
#import "CollectRoomOperation.h"
#import "PlistHelper.h"
#import "RoomModel.h"
#import "CollectRoomOperation.h"

@interface Reverse_RootViewController () {
    UILabel *_headLabel;
    IBOutlet UIImageView *_defaultTextImageView;
}

@property (strong, nonatomic) NSMutableArray *dataArr;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@end

@implementation Reverse_RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadData];
}

- (BOOL)isShowBack {
    return NO;
}

- (void)loadData {
    self.dataArr = [NSMutableArray array];
    NSDictionary *dic = [[PlistHelper defaultDBHelper] valueFormPlistName:CollectRoomPlist];
    for (int i = 0; i < [dic allKeys].count; i++) {
        NSDictionary *roomDic = [dic objectForKey:[dic.allKeys objectAtIndex:i]];
        RoomModel *model = [[RoomModel alloc] initWithDic:roomDic];
        [_dataArr addObject:model];
    }
    if (_dataArr.count == 0) {
        _defaultTextImageView.hidden = NO;
    } else {
        _defaultTextImageView.hidden = YES;
    }
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
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionCell"];
    }
    cell.reverseClickBlock = ^(int index) {
        if (index == 0) {
            //全额支付
            Me_RentViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_RentViewController"];
            vc.rentType = AllMoney_Reverse;
            vc.hidesBottomBarWhenPushed = YES;
            vc.roomModel = model;
            vc.reverseBlock = ^(void) {
                [self deleteCollectRoom:indexPath withTableView:tableView];
                [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteFinishReversedRoomNotification object:model.roomId];
            };
            [self.navigationController pushViewController:vc animated:YES];
        } else if (index == 1) {
            //订金
            Me_RentViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_RentViewController"];
            vc.rentType = Deposit_Reverse;
            vc.hidesBottomBarWhenPushed = YES;
            vc.roomModel = model;
            vc.reverseBlock = ^(void) {
                [self deleteCollectRoom:indexPath withTableView:tableView];
                [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteFinishReversedRoomNotification object:model.roomId];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.roomModel = model;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    if (_dataArr.count > 0) {
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, kScreen_Width-40, 50)];
        _headLabel.text = @"       预订分为支付定金和支付全额，支付定金的房间我们将为您保留三天。";
        _headLabel.font = [UIFont systemFontOfSize:13];
        _headLabel.textColor = [UIColor redColor];
        _headLabel.numberOfLines = 0;
        [headView addSubview:_headLabel];
    }
    return headView;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteCollectRoom:indexPath withTableView:tableView];
    }
}

- (void)deleteCollectRoom:(NSIndexPath *)indexPath withTableView:(UITableView *)tableView {
    RoomModel *model = _dataArr[indexPath.row];
    [[CollectRoomOperation defaultCollectRoomOperation] deleteLocalSavedRoomByRoomId:model.roomId];
    [_dataArr removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KCancelFindRoomCollectStateFromReverseVCDeleteNotification object:model.roomId];
    if (_dataArr.count == 0) {
        _headLabel.hidden = YES;
        _defaultTextImageView.hidden = NO;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
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
    vc.hidesBottomBarWhenPushed = YES;
    vc.roomOriginalVC = CollectionVC;
    vc.roomModel = model;
    vc.roomDetailCollectClickBlock = ^(BOOL isCollect) {
        if (!isCollect) {
            //删除收藏
            [self deleteCollectRoom:indexPath withTableView:tableView];
        }
    };
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
