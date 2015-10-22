//
//  FindRoomRootSelect_CollectionCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCollectionCellSize CGSizeMake(90, 30)

@interface FindRoomRootSelect_CollectionCell : UICollectionViewCell {
    UIColor *_tempColor;
}
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

- (void)setBorderColor:(UIColor *)color;

@end
