//
//  AddressMapViewController.m
//  yk_iOS
//
//  Created by chenhanlin on 15/10/13.
//  Copyright © 2015年 yike. All rights reserved.
//

#import "AddressMapViewController.h"

@interface AddressMapViewController ()

@end

@implementation AddressMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapview viewWillAppear];
    _mapview.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放

    
    /*
     地图显示区域
     */
    CLLocationCoordinate2D coordinate; //设定经纬度
    coordinate.latitude =KLatitude; //纬度
    coordinate.longitude =KLongitude; //经度
    BMKCoordinateRegion viewRegion =BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.05,0.05));
    BMKCoordinateRegion adjustedRegion = [_mapview regionThatFits:viewRegion];
    [_mapview setRegion:adjustedRegion animated:YES];
    
    //初始化云检索服务
    _search = [[BMKCloudSearch alloc] init];
    _search.delegate = self;
    //[self doLocalSearch];
    
    //[self startLocationService];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self createAnnotation:[[self.addressDic objectForKey:@"latitude"] doubleValue] withLongitude:[[self.addressDic objectForKey:@"longitude"] doubleValue] withTitle:self.addressStr];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapview viewWillDisappear];
    _mapview.delegate = nil; // 不用时，置nil
}

- (void)createAnnotation:(double)latitude withLongitude:(double)longitude withTitle:(NSString *)title {
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = latitude;
    coor.longitude = longitude;
    annotation.coordinate = coor;
    annotation.title = title;
    [_mapview addAnnotation:annotation];
}

/*
 定位服务
 */
- (void)startLocationService {
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService
    BMKLocationService *locService = [[BMKLocationService alloc]init];
    locService.delegate = self;
    //启动LocationService
    [locService startUserLocationService];
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    _mapview.showsUserLocation = YES;//显示定位图层
    [_mapview updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _mapview.showsUserLocation = YES;//显示定位图层
    [_mapview updateLocationData:userLocation];
}

/*
 附近搜索服务
 */
- (void)doLocalSearch {
    BMKCloudLocalSearchInfo *cloudLocalSearch = [[BMKCloudLocalSearchInfo alloc] init];
    cloudLocalSearch.ak = @"B266f735e43ab207ec152deff44fec8b";//需要注册server段的ak
    cloudLocalSearch.geoTableId = 31869;//数据表编号
    cloudLocalSearch.pageIndex = 0;
    cloudLocalSearch.pageSize = 10;
    
    cloudLocalSearch.region = @"北京市";
    cloudLocalSearch.keyword = @"天安门";//必需
    BOOL flag = [_search localSearchWithSearchInfo:cloudLocalSearch];
    if(flag){
        NSLog(@"本地云检索发送成功");
    }else{
        NSLog(@"本地云检索发送失败");
    }
}

//返回云检索结果回调
- (void)onGetCloudPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapview.annotations];
    [_mapview removeAnnotations:array];
    if (error == BMKErrorOk) {
        BMKCloudPOIList* result = [poiResultList objectAtIndex:0];
        for (int i = 0; i < result.POIs.count; i++) {
            BMKCloudPOIInfo* poi = [result.POIs objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc] init];
            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ poi.longitude,poi.latitude};
            item.coordinate = pt;
            item.title = poi.title;
            [_mapview addAnnotation:item];
        }
    } else {
        NSLog(@"error ==%d",error);
    }
}

#pragma mark -BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
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
