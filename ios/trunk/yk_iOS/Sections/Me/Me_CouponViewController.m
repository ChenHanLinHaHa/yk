//
//  Me_CouponViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Me_CouponViewController.h"
#import "BaseTableView.h"

@interface Me_CouponViewController ()
@property (strong, nonatomic) XTSegmentControl *mySegmentControl;
@property (strong, nonatomic) iCarousel *myCarousel;

@property (strong, nonatomic) NSArray *dataArr;
@end

@implementation Me_CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArr = @[@"未使用",@"已使用"];
    
    self.myCarousel = ({
        iCarousel *icarousel = [[iCarousel alloc] init];
        icarousel.dataSource = self;
        icarousel.delegate = self;
        icarousel.decelerationRate = 1.0;
        icarousel.scrollSpeed = 1.0;
        icarousel.type = iCarouselTypeLinear;
        icarousel.pagingEnabled = YES;
        icarousel.clipsToBounds = YES;
        icarousel.bounceDistance = 0.2;
        [self.view addSubview:icarousel];
        [icarousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(kMySegmentControlIcon_Height+64, 0, 0, 0));
        }];
        icarousel;
    });
    
    [self configSegmentControlWithData:nil];
}

- (void)configSegmentControlWithData:(id)data {
    //重置滑块
    if (_mySegmentControl) {
        [_mySegmentControl removeFromSuperview];
    }
    
    __weak typeof(self) weakSelf = self;
    CGRect segmentFrame = CGRectMake(0, 64, kScreen_Width, kMySegmentControlIcon_Height);
    _mySegmentControl = [[XTSegmentControl alloc] initWithFrame:segmentFrame Items:self.dataArr selectedBlock:^(NSInteger index) {
        [weakSelf.myCarousel scrollToItemAtIndex:index animated:NO];
    }];
    [self.view addSubview:_mySegmentControl];
}

#pragma mark iCarousel M
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return self.dataArr.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    BaseTableView *tableView = (BaseTableView *)view;
    if (!tableView) {
        TableViewType type;
        if (index == 0) {
            type = Coupon_Unused;
        } else if (index == 1) {
            type = Couopn_Used;
        }
        tableView = [[BaseTableView alloc] initWithFrame:carousel.bounds withTableViewType:type];
        [tableView reloadData:@[@"1",@"2",@"3",@"4",@"5"]];
        tableView.baseTableViewCellClickBlock = ^(NSIndexPath *indexPath,TableViewType type) {
            DebugLog(@"indexPath = %@",indexPath);
        };
    }
    return tableView;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    if (_mySegmentControl) {
        float offset = carousel.scrollOffset;
        if (offset > 0) {
            [_mySegmentControl moveIndexWithProgress:offset];
        }
    }
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    if (_mySegmentControl) {
        _mySegmentControl.currentIndex = carousel.currentItemIndex;
    }
    [carousel.visibleItemViews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
    }];
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
