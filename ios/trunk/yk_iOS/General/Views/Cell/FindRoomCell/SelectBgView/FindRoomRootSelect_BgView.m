//
//  FindRoomRootSelect_BgView.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "FindRoomRootSelect_BgView.h"
#import "FindRoomRootSelect_CollectionCell.h"
#import "FindRoomRootSelect_CollectionReusableView.h"
#import "FindRoomRootSelectFooter_CollectionReusableView.h"

@implementation FindRoomRootSelect_BgView

- (void)awakeFromNib {
    _headDataArr = @[@"行政区域",@"地铁",@"租金",@"房间类型"];
    _sectionDataArr = @[@"全部",@"金水区",@"二七区",@"中原区",@"二七区",@"高新区",@"管城区"];
    _subwayDataArr = @[@"全部",@"一号线"];
    _rentDataArr = @[@"全部",@"0-500元",@"500-1000元",@"1000-1500元",@"1500-2000元",@"2000-2500元",@"其他"];
    _roomTypeDataArr = @[@"全部",@"独卫",@"标准间",@"整租"];
    _selectCellDic = [NSMutableDictionary dictionary];
}

#pragma mark -UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    } else if (section == 3) {
        return 4;
    }
    return 7;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"FindRoomRootSelect_CollectionCell";
    FindRoomRootSelect_CollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    switch (indexPath.section) {
        case 0:
            cell.contentLabel.text = _sectionDataArr[indexPath.row];
            break;
        case 1:
            cell.contentLabel.text = _subwayDataArr[indexPath.row];
            break;
        case 2:
            cell.contentLabel.text = _rentDataArr[indexPath.row];
            break;
        case 3:
            cell.contentLabel.text = _roomTypeDataArr[indexPath.row];
            break;
        default:
            break;
    }
    [self doCollectionCellSelect:cell withIsSelect:NO];
    if (_selectCellDic.allKeys.count == _headDataArr.count) {
        NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
        if (indexPath == [_selectCellDic objectForKey:key]) {
            [self doCollectionCellSelect:cell  withIsSelect:YES];
        }
    } else {
        if (indexPath.row == 0) {
            [self doCollectionCellSelect:cell withIsSelect:YES];
            
            NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
            [_selectCellDic setObject:indexPath forKey:key];
        }
    }
    return cell;
}
//header/footer
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString: UICollectionElementKindSectionFooter]){
        FindRoomRootSelectFooter_CollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FindRoomRootSelectFooter_CollectionReusableView" forIndexPath:indexPath];
        footerView.checkBtnClickBlock = ^() {
            NSMutableArray *indexs = [NSMutableArray array];
            for (int i = 0; i < _headDataArr.count; i++) {
                NSString *key = [NSString stringWithFormat:@"%ld",(long)i];
                NSIndexPath *indexPath = [_selectCellDic objectForKey:key];
                [indexs addObject:indexPath];
            }
            if (self.checkResultBlock) {
                self.checkResultBlock(indexs);
            }
        };
        return footerView;
    }else{
        FindRoomRootSelect_CollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FindRoomRootSelect_CollectionReusableView" forIndexPath:indexPath];
        headerView.contentLabel.text = _headDataArr[indexPath.section];
        return headerView;
    }
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return kCollectionCellSize;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = {kScreen_Width,30};
    return size;
}

//返回头footerView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section  {
    CGSize size = {kScreen_Width,5};
    if (section == _headDataArr.count-1) {
        size = CGSizeMake(kScreen_Width, 50);
    }
    return size;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    FindRoomRootSelect_CollectionCell * collectionCell = (FindRoomRootSelect_CollectionCell *)cell;
    [self doCollectionCellSelect:collectionCell withIsSelect:YES];
    
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    FindRoomRootSelect_CollectionCell * tempCell = (FindRoomRootSelect_CollectionCell *)[collectionView cellForItemAtIndexPath:[_selectCellDic objectForKey:key]];
    [self doCollectionCellSelect:tempCell withIsSelect:NO];
    [_selectCellDic setObject:indexPath forKeyedSubscript:key];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)doCollectionCellSelect:(FindRoomRootSelect_CollectionCell *)cell withIsSelect:(BOOL)isSelect {
    if (isSelect) {
        [cell setBorderColor:[UIColor redColor]];
        cell.contentLabel.textColor = [UIColor redColor];
        [cell setNeedsDisplay];
    } else {
        [cell setBorderColor:[UIColor blackColor]];
        cell.contentLabel.textColor = [UIColor blackColor];
        [cell setNeedsDisplay];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
