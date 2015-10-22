//
//  BaseTableView.h
//  House_Project
//
//  Created by chenhanlin on 15/10/3.
//  Copyright © 2015年 chenhanlin. All rights reserved.
//

/**
 * 我的优惠券/收藏
 **/

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Default_Type,
    Coupon_Unused,
    Couopn_Used,
} TableViewType;

typedef void(^BaseTableViewCellClickBlock)(NSIndexPath*indexPath,TableViewType type);

@interface BaseTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_myTableView;
    NSArray *_dataArr;
    TableViewType _type;
}

@property (assign, nonatomic) BaseTableViewCellClickBlock baseTableViewCellClickBlock;

- (id)initWithFrame:(CGRect)frame withTableViewType:(TableViewType)type;

- (void)reloadData:(id)data;

@end
