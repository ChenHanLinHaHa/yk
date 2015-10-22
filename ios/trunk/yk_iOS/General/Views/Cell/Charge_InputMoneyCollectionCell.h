//
//  Charge_InputMoneyCollectionCell.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/9.
//  Copyright © 2015年 yike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldDidEndEditingBlock)(double amount);

@interface Charge_InputMoneyCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;

@property (nonatomic, strong) TextFieldDidEndEditingBlock textFieldDidEndEditingBlock;

@end
