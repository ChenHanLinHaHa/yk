//
//  RoomDetail_RoomsStateCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_RoomsStateCell.h"
#import "RoomDetail_RoomsStateCollectionCell.h"

@implementation RoomDetail_RoomsStateCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)reloadData:(RoomOthers *)roomOther {
    _roomTypeLabel.text = roomOther.RoomCode;
    _roomAreaLabel.text = [NSString stringWithFormat:@"%@㎡",roomOther.RoomArea];
    _roomRentLabel.text = [NSString stringWithFormat:@"%@元/月",roomOther.RoomPrice];
    _roomStateLabel.text = roomOther.RoomState;
    if (roomOther.isHaveBalcony) {
        _roomConfigLabel.text = @"阳台";
    }
    if (roomOther.isHaveBayWindow) {
        _roomConfigLabel.text = @"飘窗";
    }
    if (roomOther.isHaveIndependentToilet) {
        _roomConfigLabel.text = @"独卫";
    }
    if ([roomOther.RoomMateSex isEqualToString:@"男"]) {
        _roomMateImage.image = [UIImage imageNamed:@"man_image"];
    } else if ([roomOther.RoomMateSex isEqualToString:@"女"]) {
        _roomMateImage.image = [UIImage imageNamed:@"woman_image"];
    }
}

/*- (void)reloadData:(NSArray *)dataArr {
    _dataArr = dataArr;
    [_myCollectionView reloadData];
}

- (NSUInteger)getArrCount {
    return ((NSArray *)[_dataArr firstObject]).count;
}

#pragma mark -UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ((NSArray *)_dataArr[section]).count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArr.count;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"RoomDetail_RoomsStateCollectionCell";
    RoomDetail_RoomsStateCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSString *content = ((NSArray *)_dataArr[indexPath.section])[indexPath.row];
    if ([content hasSuffix:@"_image"]) {
        cell.contentLabel.hidden = YES;
        cell.contentBtn.hidden = NO;
        [cell.contentBtn setImage:[UIImage imageNamed:content] forState:UIControlStateNormal];
    } else {
        cell.contentBtn.hidden = YES;
        cell.contentLabel.hidden = NO;
        cell.contentLabel.text = content;
    }
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return kRoomsStateCollectionCellSize;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}*/

@end
