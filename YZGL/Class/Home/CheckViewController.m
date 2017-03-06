//
//  CheckViewController.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "ElectronicalRealViewCell.h"
#import "CheckViewController.h"

@interface CheckViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UISegmentedControl *topSwitch;

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审核记录";
    [self.view addSubview:self.topSwitch];
     [self.view addSubview:self.tableview];
    [self.topSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view).offset(-40);
        make.top.mas_equalTo(self.view).offset(74);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_topSwitch.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.view);
    }];
    
}
-(void)valueChanged:(UISegmentedControl*)sender{
    
    
}

-(UISegmentedControl*)topSwitch{
    if(!_topSwitch){
        _topSwitch = [[UISegmentedControl alloc]initWithItems:@[@"未审核",@"已同意",@"已拒绝"]];
        [_topSwitch setTintColor:[UIColor blackColor]];
        //        [_topSwitch setBackgroundColor: [UIColor blackColor]];
        _topSwitch.selectedSegmentIndex = 0;
        [_topSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        _topSwitch.layer.cornerRadius = 4;
    }
    return _topSwitch;
}

-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, kScreenWidth, 430) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        [_tableview registerNib:[UINib nibWithNibName:@"ElectronicalRealViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ElectronicalRealViewCellID"];
    }
    return _tableview;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ElectronicalRealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ElectronicalRealViewCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}






























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

















@end
