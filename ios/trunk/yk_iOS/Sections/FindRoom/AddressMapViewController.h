//
//  AddressMapViewController.h
//  yk_iOS
//
//  Created by chenhanlin on 15/10/13.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressMapViewController : BaseViewController<BMKMapViewDelegate,BMKCloudSearchDelegate,BMKLocationServiceDelegate> {
    
    IBOutlet BMKMapView *_mapview;
    BMKCloudSearch* _search;
}

@property (nonatomic, strong) NSString *addressStr;
@property (nonatomic, strong) NSDictionary *addressDic;

@end
