//
//  FindRoomRootSelect_CollectionCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "FindRoomRootSelect_CollectionCell.h"

@implementation FindRoomRootSelect_CollectionCell

- (void)awakeFromNib {
    _tempColor = [UIColor blackColor];
}

- (void)setBorderColor:(UIColor *)color {
    _tempColor = color;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor *color = _tempColor;
    [color set];  //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kCollectionCellSize.width, kCollectionCellSize.height)];
    
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
    
    [aPath stroke];
}

@end
