//
//  RoomDetail_RoomsStateCollectionCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/12.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_RoomsStateCollectionCell.h"

@implementation RoomDetail_RoomsStateCollectionCell

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor *color = kColorTableBG;
    [color set];  //设置线条颜色
    
    UIBezierPath* aPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, kRoomsStateCollectionCellSize.width, kRoomsStateCollectionCellSize.height)];
    
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
    
    [aPath stroke];
}

@end
