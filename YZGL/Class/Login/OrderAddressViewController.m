//
//  OrderAddressViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "OrderAddressViewController.h"

@interface OrderAddressViewController (){
    BOOL isSelectCity;
}
@property(nonatomic,strong)NSIndexPath *selectedIndexPath;//当前选中的NSIndexPath
@end

@implementation OrderAddressViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"地区";
    [self configureData];
    [self configureViews];
    
}


-(void)configureData{
    if (self.displayType == kDisplayProvince) {
        NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
        self.provinces = [NSArray arrayWithContentsOfFile:addressPath];
    }
}


-(void)configureViews{
    if (self.displayType == kDisplayProvince) { //只在选择省份页面显示取消按钮
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    }
    if (self.displayType == kDisplayArea) {//只在选择区域页面显示确定按钮
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    }
    CGRect frame = [self.view bounds];
    self.tableView = [[UITableView alloc]initWithFrame:frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.displayType == kDisplayProvince) {
        return self.provinces.count;
    }else if (self.displayType == kDisplayCity){
        return self.citys.count;
    }else{
        return self.areas.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"cityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        if (self.displayType == kDisplayArea) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    if (self.displayType == kDisplayProvince) {
        NSDictionary *province = self.provinces[indexPath.row];
        NSString *provinceName = [province objectForKey:@"text"];
        cell.textLabel.text= provinceName;
    }else if (self.displayType == kDisplayCity){
        NSDictionary *city = self.citys[indexPath.row];
        NSString *cityName = [city objectForKey:@"text"];
        cell.textLabel.text= cityName;
    }else{
        NSDictionary *dic = self.areas[indexPath.row];
        cell.textLabel.text= dic[@"text"] ;
        cell.imageView.image = [UIImage imageNamed:@"unchecked"];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.displayType == kDisplayProvince) {
        isSelectCity = NO;
        NSDictionary *province = self.provinces[indexPath.row];
        NSArray *citys = [province objectForKey:@"children"];
        self.selectedProvince = [province objectForKey:@"text"];
        
        //构建下一级视图控制器
        OrderAddressViewController *cityVC = [[OrderAddressViewController alloc]init];
        cityVC.displayType = kDisplayCity;//显示模式为城市
        cityVC.citys = citys;
        cityVC.selectedProvince = self.selectedProvince;
        cityVC.selectedProvinceCode = [province objectForKey:@"value"];
        [self.navigationController pushViewController:cityVC animated:YES];
    }else if (self.displayType == kDisplayCity){
        isSelectCity = NO;
        NSDictionary *city = self.citys[indexPath.row];
        self.selectedCity = [city objectForKey:@"text"];
        NSArray *areas = [city objectForKey:@"children"];
        //构建下一级视图控制器
        OrderAddressViewController *areaVC = [[OrderAddressViewController alloc]init];
        areaVC.displayType = kDisplayArea;//显示模式为区域
        areaVC.areas = areas;
        areaVC.selectedCity = self.selectedCity;
        areaVC.selectedProvince = self.selectedProvince;
        areaVC.selectedProvinceCode = self.selectedProvinceCode;
        areaVC.selectedCityCode = [city objectForKey:@"value"];
        [self.navigationController pushViewController:areaVC animated:YES];
    }
    else{
        isSelectCity = YES;
        //取消上一次选定状态
        UITableViewCell *oldCell =  [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        oldCell.imageView.image = [UIImage imageNamed:@"unchecked"];
        //勾选当前选定状态
        UITableViewCell *newCell =  [tableView cellForRowAtIndexPath:indexPath];
        newCell.imageView.image = [UIImage imageNamed:@"checked"];
        //保存
        NSDictionary *dic = self.areas[indexPath.row];
        self.selectedArea = [dic objectForKey:@"text"];
        self.selectedIndexPath = indexPath;
        self.selectedAreaCode = [dic objectForKey:@"value"];
    }
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
-(void)submit{
    if (isSelectCity == NO) {
        [MBProgressHUD showError:@"未选择城市"];
        
        return;
    }
    if (self.selectedProvince == nil) {
        self.selectedProvince =@"位置省份";
    }
    if (self.selectedCity==nil) {
        self.selectedCity=@"未知城市";
    }
    if (self.selectedArea==nil) {
        self.selectedArea=@"未知地区";
    }
//    NSString *msg = [NSString stringWithFormat:@"%@-%@-%@",self.selectedProvince,self.selectedCity,self.selectedArea];
//    NSLog(@"%@",msg);
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.selectedProvince,@"province",self.selectedCity,@"city",self.selectedArea,@"area",self.selectedCityCode,@"selectedCityCode",self.selectedProvinceCode,@"selectedProvinceCode",self.selectedAreaCode,@"selectedAreaCode", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"chooseAdd" object:nil userInfo:dict];
    
    
    [self sureCancel];
}


-(void)sureCancel{
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
