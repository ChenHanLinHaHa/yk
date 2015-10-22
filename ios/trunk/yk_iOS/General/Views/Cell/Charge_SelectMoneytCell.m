//
//  Charge_SelectMoneytCell.m
//  
//
//  Created by chenhanlin on 15/10/9.
//
//

#import "Charge_SelectMoneytCell.h"
#import "Charge_SelectMoneyCollectionCell.h"
#import "Charge_InputMoneyCollectionCell.h"

@implementation Charge_SelectMoneytCell

- (void)awakeFromNib {
    // Initialization code
    
    _dataArr = @[@"100",@"200",@"500",@"1000",@"2000"];
}

#pragma mark -UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        Charge_InputMoneyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Charge_InputMoneyCollectionCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textFieldDidEndEditingBlock = ^(double amount) {
            if (self.chargeSelectMoneyCountBlock) {
                self.chargeSelectMoneyCountBlock(amount);
            }
        };
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.layer.borderWidth = 1.0;
        return cell;
    }
    static NSString * CellIdentifier = @"Charge_SelectMoneyCollectionCell";
    Charge_SelectMoneyCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.contentLabel.text = _dataArr[indexPath.row];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1.0;
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 40);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 20, 5, 20);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.layer.borderWidth = 1.0;
    if (indexPath.row == 5) {
        Charge_InputMoneyCollectionCell *inputCell = (Charge_InputMoneyCollectionCell *)cell;
        [inputCell.inputTextField becomeFirstResponder];
    }
    if (self.chargeSelectMoneyCountBlock) {
        if (indexPath.row == 5) {
            return;
        }
        self.chargeSelectMoneyCountBlock([_dataArr[indexPath.row] doubleValue]);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1.0;
    if (indexPath.row == 5) {
        Charge_InputMoneyCollectionCell *inputCell = (Charge_InputMoneyCollectionCell *)cell;
        [inputCell.inputTextField resignFirstResponder];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
