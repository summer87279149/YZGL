//
//  MapViewController.m
//  YZGL
//
//  Created by Admin on 17/3/28.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "CLLocation+YCLocation.h"
#import "MKMapView+JKZoomLevel.h"
#import "MapViewController.h"
#import "CCLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface MapViewController ()<MKMapViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    CGPoint mapMidPoint;
    CLLocationCoordinate2D mapMidPointCoordinate;
    CLGeocoder *geocoder;
}
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (strong, nonatomic)  UITableView *tableview;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic, strong) CCLocationManager *locationManager;

@end

@implementation MapViewController
- (instancetype)initWithAddress:(NSString *)addStr
{
    self = [super init];
    if (self) {
        self.address = addStr;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc]init];
    WS(weakSelf)
    [geocoder geocodeAddressString:self.address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            CLPlacemark *mark = placemarks[0];
            CLLocation*location = [mark.location locationMarsFromEarth];
            [weakSelf setMapCenterAndGetAroundInfoWithCoordinate:location.coordinate];
//            NSLog(@"城市的经纬度是:%lu",placemarks.count);
        }
    }];
    
    self.cellArr = [NSMutableArray array];
    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 300)];
    [self.view addSubview:self.mapView];
    self.mapView.userTrackingMode = MKUserTrackingModeNone;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsScale=YES;
    self.mapView.showsCompass=YES;
    self.mapView.showsTraffic=YES;
    self.mapView.showsBuildings=YES;
    self.mapView.showsUserLocation=YES;
    self.mapView.showsPointsOfInterest=YES;
    self.mapView.delegate = self;
    self.mapView.userTrackingMode = MKUserTrackingModeNone;
    NSLog(@"用户位置是:%@",self.mapView.userLocation);
    UIImageView *anno = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    anno.image = [UIImage imageNamed:@"startIcon.png"];
    mapMidPoint = self.mapView.center;
    [self.view addSubview:anno];
    anno.center = mapMidPoint;
    
    [self.view addSubview:self.tableview];
    
    
    
}







#pragma mark - 根据coordinate居中地图，并查找coordinate周围信息
-(void)setMapCenterAndGetAroundInfoWithCoordinate:(CLLocationCoordinate2D)coordinate2D{
    [self.mapView jk_setCenterCoordinate:coordinate2D zoomLevel:13 animated:YES];
    [self getAroundInfoMationWithCoordinate:coordinate2D];
}
#pragma mark - delegate
//当前位置更新
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    NSLog(@"用户位置更新:longitude:%f---latitude:%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
}
//地图显示区域将要改变
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
//    NSLog(@"地图将要改变");
}
//地图显示区域已经改变
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    mapMidPointCoordinate = [self.mapView convertPoint:mapMidPoint toCoordinateFromView:_mapView];
//    NSLog(@"新的坐标是:%f-%f",mapMidPointCoordinate.latitude,mapMidPointCoordinate.longitude);
    //    [self getAddressByLatitude:mapMidPointCoordinate.latitude longitude:mapMidPointCoordinate.longitude];
    [self getAroundInfoMationWithCoordinate:mapMidPointCoordinate];
    
    
}
#pragma mark 根据坐标取得地名
-(void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            [self initialData:placemarks];
        }else{
            NSLog(@"error:%@",error.localizedDescription);
        }
        
    }];
}

#pragma mark - Initial Data
-(void)initialData:(NSArray *)places
{
    [self.cellArr removeAllObjects];
    for (CLPlacemark *placemark in places) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:placemark.name forKey:@"name"];
        if (placemark.thoroughfare) {
            [dic setObject:placemark.thoroughfare forKey:@"address"];\
        }
        
        NSString *lat = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
        NSString*lon = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
        [dic setObject:lat forKey:@"lat"];
        [dic setObject:lon forKey:@"lng"];
        [self.cellArr insertObject:dic atIndex:0];
    }
    [self.tableview reloadData];
}
#pragma mark - 获取坐标周围信息
-(void)getAroundInfoMationWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 50, 50);
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.region = region;
    request.naturalLanguageQuery = @"公司";
    MKLocalSearch *localSearch = [[MKLocalSearch alloc]initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        if (!error) {
            [self getAroundInfomation:response.mapItems];
        }else{
            //            NSLog(@"Quest around Error:%@",error.localizedDescription);
        }
    }];
}

-(void)getAroundInfomation:(NSArray *)array
{
    [self.cellArr removeAllObjects];
    for (MKMapItem *item in array) {
        MKPlacemark * placemark = item.placemark;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:placemark.name forKey:@"name"];
        if (placemark.thoroughfare!=nil) {
            [dic setObject:placemark.thoroughfare forKey:@"address"];
        }
        if (placemark.subThoroughfare!=nil) {
            [dic setObject:placemark.thoroughfare forKey:@"address2"];
        }
        NSString *lat = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
        NSString*lon = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
        [dic setObject:lat forKey:@"lat"];
        [dic setObject:lon forKey:@"lng"];
        [self.cellArr addObject:dic];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableview reloadData];
    });
    
}







#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 364, kScreenWidth, kScreenHeight-364) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.tableFooterView = [UIView new];
    }
    return _tableview;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tableCell];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_cellArr) {
        NSDictionary *dic = self.cellArr[indexPath.row];
        cell.textLabel.text = dic[@"name"];
        cell.detailTextLabel.text = dic[@"address"];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.cellArr[indexPath.row];
    if (self.delegate) {
        [self.delegate sendNext:dic];
    }

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArr.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    NSLog(@"delloc");
}
@end
