//
//  SettingViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "SecuritySettingViewController.h"
#import "QianZiCodeViewController.h"
#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, strong) UISwitch *switchBool;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.tableview];

}

-(NSArray*)cellArr{
    if(!_cellArr){
        _cellArr = @[@[@"消息提示",@"签字码设置",@"安全设置"],@[@"意见反馈",@"关于我们"],@[@"退出登入"]];
    }
    return _cellArr;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 1:
        {
            [self xt_pushWithViewControllerClass:[QianZiCodeViewController class]];
        }
            break;
        case 2:{
            SecuritySettingViewController*vc = [[SecuritySettingViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.cellArr[section];
    return arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
    }
    NSArray *arr = self.cellArr[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    if (0 == indexPath.row && 0 == indexPath.section) {
        cell.accessoryView = self.switchBool;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section == 2) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}







































-(UISwitch*)switchBool{
    if(!_switchBool){
        _switchBool = [[UISwitch alloc]init];
        _switchBool.on = YES;
    }
    return _switchBool;
}

#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        _tableview.separatorColor = [UIColor blackColor];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
