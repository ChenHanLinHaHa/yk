//
//  ActivityRoot_HeaderCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/10.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "ActivityRoot_HeaderCell.h"

@implementation ActivityRoot_HeaderCell

- (void)awakeFromNib {
    // Initialization code
    
    _bannerView.continuous = YES;
    _bannerView.autoPlayTimeInterval = 4.0;
}

#pragma mark - KDCycleBannerViewDataource

- (NSArray *)numberOfKDCycleBannerView:(KDCycleBannerView *)bannerView {
    
    return @[[UIImage imageNamed:@"image1"],
             @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=ed59838948ed2e73fce9812cb339a08b/58ee3d6d55fbb2fb9835341f4d4a20a44623dca5.jpg",
             @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=5ad7fab780025aafd33279cbcfd5aa64/8601a18b87d6277f15eb8e4f2a381f30e824fcc8.jpg",
             @"http://e.hiphotos.baidu.com/image/w%3D2048/sign=df5d0b61cdfc1e17fdbf8b317ea8f703/0bd162d9f2d3572c8d2b20ab8813632763d0c3f8.jpg",
             @"http://d.hiphotos.baidu.com/image/w%3D2048/sign=a11d7b94552c11dfded1b823571f63d0/eaf81a4c510fd9f914eee91e272dd42a2934a4c8.jpg"];
}

- (UIViewContentMode)contentModeForImageIndex:(NSUInteger)index {
    return UIViewContentModeScaleAspectFill;
}

- (UIImage *)placeHolderImageOfZeroBannerView {
    return [UIImage imageNamed:@"image1"];
}

#pragma mark - KDCycleBannerViewDelegate

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didScrollToIndex:(NSUInteger)index {
}

- (void)cycleBannerView:(KDCycleBannerView *)bannerView didSelectedAtIndex:(NSUInteger)index {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
