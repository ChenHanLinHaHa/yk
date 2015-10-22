//
//  RoomDetail_HeaderPictureCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetail_HeaderPictureCell.h"
#import "CollectRoomOperation.h"
#import "RoomDetailModel.h"

@implementation RoomDetail_HeaderPictureCell

- (void)awakeFromNib {
    // Initialization code
    
    _headScrollView.contentSize = CGSizeMake(3*kScreen_Width, 195);
    _headScrollView.contentOffset = CGPointMake(kScreen_Width, 0);
    
    _preImageView = [[UIImageView alloc] init];
    [_headScrollView addSubview:_preImageView];
    _currentImageView = [[UIImageView alloc] init];
    [_headScrollView addSubview:_currentImageView];
    _nextImageView = [[UIImageView alloc] init];
    [_headScrollView addSubview:_nextImageView];
    [self resetImageViewFrame];
    
    [_preImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicAction)]];
    [_currentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicAction)]];
    [_nextImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicAction)]];
    _headImageArr = [NSMutableArray array];
}

- (void)loadData {
    
}

- (void)setRoomImages:(NSArray *)roomImages {
    [_headImageArr removeAllObjects];
    for (RoomImages *roomImageModel in roomImages) {
        [_headImageArr addObject:roomImageModel.RoomImage];
    }
    
    _curImageIndex = 0;
    _totalIndexLabel.text = [NSString stringWithFormat:@"/%lu",(unsigned long)_headImageArr.count];
    _curIndexLabel.text = [NSString stringWithFormat:@"%d",1];
    [self setScrollImage:_curImageIndex];
}

- (void)resetImageViewFrame {
    _preImageView.frame = CGRectMake(0, 0, kScreen_Width, 195);
    _currentImageView.frame = CGRectMake(kScreen_Width, 0, kScreen_Width, 195);
    _nextImageView.frame = CGRectMake(2*kScreen_Width, 0, kScreen_Width, 195);
}

#pragma mark -HeadScrollView Handle
- (void)setScrollImage:(NSInteger)curImageIndex {
    _curIndexLabel.text = [NSString stringWithFormat:@"%ld",curImageIndex+1];
    NSInteger preImageIndex = curImageIndex-1;
    NSInteger nextImageIndex = curImageIndex+1;
    if (preImageIndex == -1) {
        preImageIndex = _headImageArr.count-1;
    }
    if (nextImageIndex == _headImageArr.count) {
        nextImageIndex = 0;
    }
    [_preImageView sd_setImageWithURL:[NSURL URLWithString:_headImageArr[preImageIndex]] placeholderImage:nil];
    [_currentImageView sd_setImageWithURL:[NSURL URLWithString:_headImageArr[curImageIndex]] placeholderImage:nil];
    [_nextImageView sd_setImageWithURL:[NSURL URLWithString:_headImageArr[nextImageIndex]] placeholderImage:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _headScrollView) {
        int index = scrollView.contentOffset.x/kScreen_Width;
        if (index == 2) {
            //向右滑动
            _curImageIndex++;
            if (_curImageIndex == _headImageArr.count) {
                _curImageIndex = 0;
            }
            [self setScrollImage:_curImageIndex];
        } else if (index == 0) {
            //向左滑动
            _curImageIndex--;
            if (_curImageIndex == -1) {
                _curImageIndex = _headImageArr.count-1;
            }
            [self setScrollImage:_curImageIndex];
        }
        scrollView.contentOffset = CGPointMake(kScreen_Width, 0);
    }
}

- (void)setRoomModel:(RoomModel *)roomModel {
    _roomId = roomModel.roomId;
    _roomPrice = roomModel.roomPrice;
    _roomDescribe = roomModel.roomDescribe;
    _roomImage = roomModel.roomImage;
    _roomDeposit = roomModel.roomDeposit;
}

- (IBAction)doCollectAction:(id)sender {
    CollectButton *btn = (CollectButton *)sender;
    if (btn.isCollectFlag) {
        if (self.collectBtnClickBlock) {
            self.collectBtnClickBlock(NO);
        }
        [sender setImage:[UIImage imageNamed:@"collection_normal_image"] forState:UIControlStateNormal];
        btn.isCollectFlag = NO;
        [[CollectRoomOperation defaultCollectRoomOperation] deleteLocalSavedRoomByRoomId:_roomId];
    } else {
        if (self.collectBtnClickBlock) {
            self.collectBtnClickBlock(YES);
        }
        [sender setImage:[UIImage imageNamed:@"collection_selected_image"] forState:UIControlStateNormal];
        btn.isCollectFlag = YES;
        [[CollectRoomOperation defaultCollectRoomOperation] saveRoomToLocalByRoomId:_roomId withValue:@{@"roomId":_roomId,
                                                                                                        @"roomPrice":_roomPrice,
                                                                                                        @"roomDescribe":_roomDescribe,
                                                                                                        @"roomImage":_roomImage,
                                                                                                        @"roomDeposit":_roomDeposit}];
    }
}

- (void)imageClicAction {
    if (self.imageClickBlock) {
        self.imageClickBlock(_headImageArr,_curImageIndex);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
