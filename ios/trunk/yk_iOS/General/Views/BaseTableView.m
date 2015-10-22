//
//  BaseTableView.m
//  House_Project
//
//  Created by chenhanlin on 15/10/3.
//  Copyright © 2015年 chenhanlin. All rights reserved.
//

#import "BaseTableView.h"
#import "CouponCell.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame withTableViewType:(TableViewType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        [self configUI];
    }
    return self;
}

- (void)reloadData:(id)data {
    _dataArr = data;
    [_myTableView reloadData];
}

- (void)configUI {
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_type == Coupon_Unused || _type == Couopn_Used) {
            [tableView registerNib:[UINib nibWithNibName:@"CouponCell" bundle:kMainBundle] forCellReuseIdentifier:kCellIdentifier_Couopn];
        }
        [self addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        tableView;
    });
    [self addSubview:_myTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == Coupon_Unused || _type == Couopn_Used) {
        CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Couopn forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[CouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier_Couopn];
        }
        cell.cellTypeBlock = ^() {
            if (_type == Coupon_Unused) {
                return CouponUnused;
            } else if (_type == Couopn_Used) {
                return CouponUsed;
            }
            return DefaultType;
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == Coupon_Unused || _type == Couopn_Used) {
        return kCouponCellHeight;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_baseTableViewCellClickBlock) {
        _baseTableViewCellClickBlock(indexPath,_type);
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
