//
//  OrderAddressViewController.h
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import <UIKit/UIKit.h>
#define kDisplayProvince 0
#define kDisplayCity 1
#define kDisplayArea 2

@interface OrderAddressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)int displayType;
@property(nonatomic,strong)NSArray *provinces;
@property(nonatomic,strong)NSArray *citys;
@property(nonatomic,strong)NSArray *areas;
@property(nonatomic,strong)NSString *selectedProvince;//选中的省
@property(nonatomic,strong)NSString *selectedProvinceCode;//选中的省编码
@property(nonatomic,strong)NSString *selectedCity;//选中的市
@property(nonatomic,strong)NSString *selectedCityCode;//选中的市编码
@property(nonatomic,strong)NSString *selectedArea;//选中的区
@property(nonatomic,strong)NSString *selectedAreaCode;//选中的区编码

@end
