//
//  WelcomeViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/22.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *leadImageView;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _leadImageView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1 animations:^{
            self.view.alpha = 0;
            self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }completion:^(BOOL finished) {
            [self.view removeFromSuperview];
        }];
        
    });
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
