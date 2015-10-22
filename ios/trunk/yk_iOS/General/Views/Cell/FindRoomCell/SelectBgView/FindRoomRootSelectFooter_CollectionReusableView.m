//
//  FindRoomRootSelectFooter_CollectionReusableView.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "FindRoomRootSelectFooter_CollectionReusableView.h"

@implementation FindRoomRootSelectFooter_CollectionReusableView

- (IBAction)doCheckAction:(id)sender {
    if (self.checkBtnClickBlock) {
        self.checkBtnClickBlock();
    }
}

@end
