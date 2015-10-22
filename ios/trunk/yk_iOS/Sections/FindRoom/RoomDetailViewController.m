//
//  RoomDetailViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/11.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "RoomDetailViewController.h"
#import "RoomDetail_HeaderPictureCell.h"
#import "RoomDetail_NameCell.h"
#import "RoomDetail_BaseInfoCell.h"
#import "RoomDetail_HMInfoCell.h"
#import "RoomDetail_BaseConfigCell.h"
#import "RoomDetail_RoomsStateCell.h"
#import "Me_RentViewController.h"
#import "RoomDetail_AddressCell.h"
#import "AddressMapViewController.h"
#import "PhotoBrowerHelper.h"
#import "RoomDetail_SameVillageCell.h"
#import "RoomDetail_SectionHeaderCell.h"
#import "RoomDetail_PublicConfigCell.h"
#import <QQApiInterface.h>
#import <WXApi.h>
#import <WeiboSDK.h>

@interface RoomDetailViewController ()
{
    IBOutlet UITableView *_myTableView;
    
    RoomDetailModel *_roomDetailModel;
    NSArray *_roomOthersArr;
    NSArray *_roomImagesArr;
    NSArray *_roomsSameVillageArr;
    NSDictionary *_roomGeoDic;
    NSString *_roomId;
    
    IBOutlet UIView *_shareView;
    IBOutlet UIImageView *_shareShadowImageView;
    IBOutlet UIButton *_cancelShareBtn;
    BOOL _isSharing;
}
@end

@implementation RoomDetailViewController

- (NSDictionary *)getCheckWhereKey {
    return @{@"RoomId":_roomId};
}

- (NSArray *)getRelationTitles {
    return @[@"RoomOthers",@"RoomImages",@"RoomsSameVillage",@"Location"];
}

- (UIView *)getSelfView {
    return self.view;
}

- (BOOL)isHaveTableView {
    return YES;
}

- (UITableView *)getSelfTableView {
    return _myTableView;
}

- (void)againRefresh {
    [self doRefresh];
}

- (BOOL)isCanLoadMore {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:@"share_image" showBadge:NO target:self action:@selector(doShareAction)];
    _roomId = self.roomModel.roomId;
    
    [self doRefresh];
    
    _cancelShareBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _cancelShareBtn.layer.borderWidth = 0.5;
    _cancelShareBtn.layer.cornerRadius = 8.0;
    _cancelShareBtn.layer.masksToBounds = YES;
    _isSharing = NO;
    [_shareShadowImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doHideShareView)]];
    url = @"www.qk365.com";
//    imgData = UIImageJPEGRepresentation([UIImage imageNamed:@"collection_selected_image"];
    imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
}

- (void)doRefresh {
    [self beginRefreshWithDataType:Room_Detail_Data withRefreshResultBlock:^(BOOL isSuccess, NSArray *objects) {
        _roomDetailModel = objects.firstObject;
        [_myTableView reloadData];
    } withRoomDetailRelationResultBlock:^(BOOL isSuccess, id result, NSString *title) {
        if ([title isEqualToString:@"RoomOthers"]) {
            _roomOthersArr = result;
            [_myTableView reloadData];
        } else if ([title isEqualToString:@"RoomImages"]) {
            _roomImagesArr = result;
            [_myTableView reloadData];
        } else if ([title isEqualToString:@"RoomsSameVillage"]) {
            _roomsSameVillageArr = result;
            [_myTableView reloadData];
        } else if ([title isEqualToString:@"Location"]) {
            _roomGeoDic = result;
            [_myTableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 7) {
        return _roomOthersArr.count+1;
    } else if (section == 8) {
        return _roomsSameVillageArr.count+1;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RoomDetail_HeaderPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_HeaderPictureCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[RoomDetail_HeaderPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_HeaderPictureCell"];
        }
        cell.imageClickBlock = ^(NSArray *imagesArr, NSUInteger index) {
            [[PhotoBrowerHelper defaultPhotoBrowerHelper] showBrowserWithImages:imagesArr];
        };
        if (self.roomOriginalVC == Me_ReverseVC || self.roomOriginalVC == Me_MyRoomVC) {
            cell.collectBtn.hidden = YES;
        }
        if (self.roomOriginalVC == CollectionVC || self.isCollected) {
            [cell.collectBtn setImage:[UIImage imageNamed:@"collection_selected_image"] forState:UIControlStateNormal];
            cell.collectBtn.isCollectFlag = YES;
        }
        cell.roomModel = self.roomModel;
        cell.collectBtnClickBlock = ^(BOOL isCollect) {
            if (self.roomDetailCollectClickBlock) {
                self.roomDetailCollectClickBlock(isCollect);
            }
        };
        if (_roomImagesArr.count > 0) {
            cell.roomImages = _roomImagesArr;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"房间租金";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_NameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_NameCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_NameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_NameCell"];
            }
            cell.reverseClickBlock = ^(int index) {
                if (index == 0) {
                    //全额支付
                    Me_RentViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_RentViewController"];
                    vc.rentType = AllMoney_Reverse;
                    vc.roomModel = self.roomModel;
                    vc.reverseBlock = ^(void) {
                        if (self.reverseFinishBlock) {
                            self.reverseFinishBlock();
                        }
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                } else if (index == 1) {
                    //订金
                    Me_RentViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"Me_RentViewController"];
                    vc.rentType = Deposit_Reverse;
                    vc.roomModel = self.roomModel;
                    vc.reverseBlock = ^(void) {
                        if (self.reverseFinishBlock) {
                            self.reverseFinishBlock();
                        }
                    };
                    [self.navigationController pushViewController:vc animated:YES];
                }
            };
            if (self.roomOriginalVC == Me_ReverseVC || self.roomOriginalVC == Me_MyRoomVC) {
                cell.reverseRoomBtn.hidden = YES;
            }
            cell.roomModel = self.roomModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"小区地址";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_AddressCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_AddressCell"];
            }
            if (_roomDetailModel) {
                cell.addressLabel.text = _roomDetailModel.RoomVillage;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"房间介绍";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_BaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_BaseInfoCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_BaseInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_BaseInfoCell"];
            }
            if (_roomDetailModel) {
                cell.roomDetailModel = _roomDetailModel;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"房屋管理员";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_HMInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_HMInfoCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_HMInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_HMInfoCell"];
            }
            if (_roomDetailModel) {
                cell.telephoneLabel.text = _roomDetailModel.RoomManagerTel;
                cell.HMNameLabel.text = _roomDetailModel.RoomManager;
            }
            cell.callBlock = ^(NSString *telephone) {
                [[AlertViewHelper defaultAlertViewHelper] showAlertView:telephone withRightTitle:@"拨打" withCertainClickBlock:^{
                    //拨打电话
                }];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    } else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"房间设施";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_BaseConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_BaseConfigCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_BaseConfigCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_BaseConfigCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (indexPath.section == 6) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"公共设施";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_PublicConfigCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_PublicConfigCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_PublicConfigCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_PublicConfigCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else if (indexPath.section == 7) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"其它房间";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_RoomsStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_RoomsStateCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_RoomsStateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_RoomsStateCell"];
            }
            if (_roomOthersArr.count > 0) {
                [cell reloadData:_roomOthersArr[indexPath.row-1]];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    } else if (indexPath.section == 8) {
        if (indexPath.row == 0) {
            RoomDetail_SectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SectionHeaderCell" forIndexPath:indexPath];
            if (!cell) {
                cell = [[RoomDetail_SectionHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SectionHeaderCell"];
            }
            cell.headerLabel.text = @"同小区其它房屋";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            RoomDetail_SameVillageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomDetail_SameVillageCell" forIndexPath:indexPath];
            if (!cell ) {
                cell = [[RoomDetail_SameVillageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomDetail_SameVillageCell"];
            }
            if (_roomsSameVillageArr.count > 0) {
                RoomsSameVilage *roomsSameVilageModel = _roomsSameVillageArr[indexPath.row-1];
                cell.roomsSameVilageModel = roomsSameVilageModel;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 195;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 148;
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 44;
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 96;
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 80;
    } else if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 55;
    } else if (indexPath.section == 6) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 55;
    }else if (indexPath.section == 7) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 55;
    } else if (indexPath.section == 8) {
        if (indexPath.row == 0) {
            return 30;
        }
        return 100;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (indexPath.row > 0) {
            if (_roomDetailModel) {
                AddressMapViewController *vc = [kMainStoryboard instantiateViewControllerWithIdentifier:@"AddressMapViewController"];
                vc.addressStr = _roomDetailModel.RoomVillage;
                vc.addressDic = [NSDictionary dictionaryWithObjects:@[@"34.7568711",@"113.683221"] forKeys:@[@"latitude",@"longitude"]];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        
    } else if (indexPath.section == 7) {
        if (indexPath.row > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            RoomOthers *model = _roomOthersArr[indexPath.row];
            _roomId = model.RoomId;
            [self doRefresh];
        }
        
    } else if (indexPath.section == 8) {
        if (indexPath.row > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [_myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            RoomsSameVilage *model = _roomsSameVillageArr[indexPath.row];
            _roomId = model.RoomId;
            [self doRefresh];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doShareAction {
    _isSharing = !_isSharing;
    if (_isSharing) {
        //显示
        _shareShadowImageView.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            _shareView.frame = CGRectMake(0, kScreen_Height-KShareViewHeight, kScreen_Width, KShareViewHeight);
            _shareView.alpha = 1;
        } completion:nil];
    } else {
        //隐藏
        [UIView animateWithDuration:0.25 animations:^{
            _shareView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, KShareViewHeight);
            _shareView.alpha = 0;
            _shareShadowImageView.hidden = YES;
        } completion:^(BOOL finished) {
        }];
    }
}

- (IBAction)doCancelShareAction:(id)sender {
    [self hideShareView:^{
        
    }];
}

- (void)doHideShareView {
    [self hideShareView:^{
        
    }];
}

- (void)hideShareView:(void(^)(void))finish {
    _isSharing = NO;
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, KShareViewHeight);
        _shareView.alpha = 0;
        _shareShadowImageView.hidden = YES;
    } completion:^(BOOL finished) {
        finish();
    }];
}

//qq分享
- (IBAction)doQQShareAction:(id)sender {
    [self hideShareView:^{
        if ([QQApiInterface isQQInstalled]) {
            QQApiNewsObject* newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:@"title" description:@"description" previewImageData:imgData];
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:newsObj];
            
            QQApiSendResultCode sent = [QQApiInterface sendReq:req];
            
            [self handleQQSendResult:sent];
        } else {
            [SVProgressHUD showInfoWithStatus:@"您没有安装QQ"];
        }
    }];
}
//微信朋友圈分享
- (IBAction)doQQFriendShareAction:(id)sender {
    [self shareToWeixinOrWeixinFriend:NO];
}
//qq空间分享
- (IBAction)doQzoneShareAction:(id)sender {
    [self hideShareView:^{
        if ([QQApiInterface isQQInstalled]) {
            QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:@"title" description:@"description" previewImageData:imgData];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            //将内容分享到qq
            QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
            
            [self handleQQSendResult:sent];
        } else {
            [SVProgressHUD showInfoWithStatus:@"您没有安装QQ"];
        }
    }];
}
//微信分享
- (IBAction)doWeixinShareAction:(id)sender {
    [self shareToWeixinOrWeixinFriend:YES];
}
//微博分享
- (IBAction)doWeiboShareAction:(id)sender {
    [self hideShareView:^{
        if ([WeiboSDK isWeiboAppInstalled]) {
            
            WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
            authRequest.redirectURI = @"http://www.sina.com";
            authRequest.scope = @"all";
            
            WBMessageObject *message = [WBMessageObject message];
            message.text = NSLocalizedString(@"测试!", nil);
            
            WBWebpageObject *webpage = [WBWebpageObject object];
            webpage.objectID = @"identifier1";
            webpage.title = NSLocalizedString(@"分享网页标题", nil);
            webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
            //图片
            webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
            webpage.webpageUrl = url;
            message.mediaObject = webpage;
            
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
            request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                 @"Other_Info_1": [NSNumber numberWithInt:123],
                                 @"Other_Info_2": @[@"obj1", @"obj2"],
                                 @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
            //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
            [WeiboSDK sendRequest:request];
        } else {
            [SVProgressHUD showInfoWithStatus:@"您没有安装微博"];
        }
    }];
    
}


- (void)shareToWeixinOrWeixinFriend:(BOOL)isWeixin {
    [self hideShareView:^{
        if ([WXApi isWXAppInstalled]) {
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            if (isWeixin) {
                req.scene = WXSceneSession;
            } else {
                req.scene = WXSceneTimeline;
            }
            req.message = WXMediaMessage.message;
            req.message.title = @"APP";
            [self setThumbImage:req];
            if (url) {
                WXWebpageObject *webObject = WXWebpageObject.object;
                webObject.webpageUrl = [[NSURL URLWithString:url] absoluteString];
                req.message.mediaObject = webObject;
            } else {
                if ((image)) {
                    WXImageObject *imageObject = WXImageObject.object;
                    imageObject.imageData = imgData;
                }
            }
            [WXApi sendReq:req];
        } else {
            [SVProgressHUD showInfoWithStatus:@"您没有安装微信"];
        }
    }];
    
}

- (void)setThumbImage:(SendMessageToWXReq *)req
{
    if (image) {
        CGFloat width = 320.f;
        CGFloat height = image.size.height * 320.f / image.size.width;
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [image drawInRect:CGRectMake(0, 0, width, height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *thumbImageData = UIImageJPEGRepresentation(scaledImage, 1.0);
        
        //thumbImage 压缩至32kb以内
        for (int i = 1.0 ; thumbImageData.length > 30720 && i > 0; i = i-0.05) {
            thumbImageData = UIImageJPEGRepresentation(scaledImage, i);
        }
        scaledImage = [UIImage imageWithData:thumbImageData];
        
        [req.message setThumbImage:scaledImage];
    }
}

- (void)handleQQSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            [SVProgressHUD showErrorWithStatus:@"QQ分享失败，APP未注册"];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            [SVProgressHUD showErrorWithStatus:@"QQ分享失败，发送参数错误"];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            [SVProgressHUD showInfoWithStatus:@"您没有安装QQ"];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            [SVProgressHUD showErrorWithStatus:@"QQ分享失败，API接口不支持"];
            break;
        }
        case EQQAPISENDFAILD:
        {
            [SVProgressHUD showErrorWithStatus:@"QQ分享失败，发送失败"];
            break;
        }
        default:
        {
            break;
        }
    }
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
