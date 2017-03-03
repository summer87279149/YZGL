//
//  SettingViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "StaffManageViewController.h"
#import "SecuritySettingViewController.h"
#import "QianZiCodeViewController.h"
#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableviewPersonal;
@property (nonatomic, strong) UITableView *tableviewCompany;
@property (nonatomic, strong) NSArray *cellPersonalArr;
@property (nonatomic, strong) NSArray *cellCompanyArr;
@property (nonatomic, strong) UISwitch *switchBool;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginNotify) name:@"login" object:nil];
    
    [self.view addSubview:self.tableviewCompany];

}
-(void)loginNotify{
    
}

-(void)modifyName{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改昵称" message:@"请输入新的昵称" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        NSLog(@"新输入的昵称是 = %@",userNameTextField.text);
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [self presentViewController:alertController animated:true completion:nil];
}
-(NSArray*)cellPersonalArr{
    if(!_cellPersonalArr){
        
        _cellPersonalArr = @[@[@"消息提示",@"签字码设置",@"安全设置"],@[@"意见反馈",@"关于我们"],@[@"退出登入"]];
    }
    return _cellPersonalArr;
}
-(NSArray*)cellCompanyArr{
    if(!_cellCompanyArr){
        
        _cellCompanyArr = @[@[@"昵称",@"人员管理"],@[@"消息提示",@"签字码设置",@"安全设置"],@[@"意见反馈",@"关于我们"],@[@"退出登入"]];
    }
    return _cellCompanyArr;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"昵称"]) {
        
    }
    
    if ([cell.textLabel.text isEqualToString:@"人员管理"]) {
        [self xt_pushWithViewControllerClass:[StaffManageViewController class]];
    }
    
    if ([cell.textLabel.text isEqualToString:@"签字码设置"]) {
        [self xt_pushWithViewControllerClass:[QianZiCodeViewController class]];
    }
    
    if ([cell.textLabel.text isEqualToString:@"安全设置"]) {
        SecuritySettingViewController*vc = [[SecuritySettingViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _tableviewPersonal) {
        return self.cellPersonalArr.count;
    }else{
        return self.cellCompanyArr.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableviewPersonal) {
        NSArray *arr = self.cellPersonalArr[section];
        return arr.count;
    }
    if (tableView == _tableviewCompany) {
        NSArray *arr = self.cellCompanyArr[section];
        return arr.count;
    }else{
        return 0;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableviewPersonal) {
        static NSString *tableCell = @"CellIdentifier";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
        }
        NSArray *arr = self.cellPersonalArr[indexPath.section];
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
    }else{
        static NSString *tableCell = @"CellIdentifier2";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
        }
        NSArray *arr = self.cellCompanyArr[indexPath.section];
        cell.textLabel.text = arr[indexPath.row];
        if (0 == indexPath.row && 0 == indexPath.section) {
            UIButton*btn = [UIButton XT_createBtnWithTitle:@"修改" TitleColor:[UIColor redColor] TitleFont:nil cornerRadio:nil BGColor:nil Borderline:@1 BorderColor:[UIColor redColor] target:self Method:@selector(modifyName)];
            btn.frame = CGRectMake(0, 5, 50, 30);
            cell.accessoryView = btn;
        }
        if (0 == indexPath.row && 1 == indexPath.section) {
            cell.accessoryView = self.switchBool;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.section == 3) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        return cell;
    }
    
}







































-(UISwitch*)switchBool{
    if(!_switchBool){
        _switchBool = [[UISwitch alloc]init];
        _switchBool.on = YES;
    }
    return _switchBool;
}

#pragma mark - tableview
-(UITableView*)tableviewPersonal{
    if(!_tableviewPersonal){
        _tableviewPersonal = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
        _tableviewPersonal.delegate = self;
        _tableviewPersonal.dataSource = self;
        _tableviewPersonal.tableFooterView = [UIView new];
    }
    return _tableviewPersonal;
}
-(UITableView*)tableviewCompany{
    if(!_tableviewCompany){
        _tableviewCompany = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70) style:UITableViewStylePlain];
        _tableviewCompany.delegate = self;
        _tableviewCompany.dataSource = self;
        _tableviewCompany.tableFooterView = [UIView new];
    }
    return _tableviewCompany;
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
