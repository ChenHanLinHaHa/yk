//
//  Me_RootHeaderCell.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/8.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "Me_RootHeaderCell.h"

@implementation Me_RootHeaderCell

- (void)configUI {
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.layer.borderWidth = 1.0;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"http://d.hiphotos.baidu.com/image/w%3D2048/sign=ed59838948ed2e73fce9812cb339a08b/58ee3d6d55fbb2fb9835341f4d4a20a44623dca5.jpg"] placeholderImage:nil];
}
- (IBAction)doMyCouponAction:(id)sender {
    if (self.myCouopnClickBlock) {
        self.myCouopnClickBlock();
    }
}
- (IBAction)doMyBalanceAction:(id)sender {
    if (self.myBalanceClickBlock) {
        self.myBalanceClickBlock();
    }
}
- (IBAction)doMyReverseAction:(id)sender {
    if (self.myReverseClickBlock) {
        self.myReverseClickBlock();
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
