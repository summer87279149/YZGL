//
//  MapViewController.m
//  YZGL
//
//  Created by Admin on 17/3/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    [self.view addSubview:self.mapView];
    self.mapView.userTrackingMode = MKUserTrackingModeNone;
    self.mapView.mapType = MKMapTypeStandard;
    NSLog(@"用户位置是:%@",self.mapView.userLocation);
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
