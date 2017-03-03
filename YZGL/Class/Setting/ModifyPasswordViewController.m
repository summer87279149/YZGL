//
//  ModifyPasswordViewController.m
//  YZGL
//
//  Created by Admin on 17/3/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ModifyPasswordViewController.h"

@interface ModifyPasswordViewController ()<UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *originalPasswordCell;
@property (nonatomic, strong) RETextItem *PasswordCell1;
@property (nonatomic, strong) RETextItem *PasswordCell2;
@property (nonatomic, strong) UIButton *completeBtn;
@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改登入密码";
    [self setupview];
}
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    
    self.originalPasswordCell = [RETextItem itemWithTitle:@"原密码" value:nil placeholder:@"请输入原密码"];
    self.PasswordCell1 = [RETextItem itemWithTitle:@"新密码" value:nil
                                         placeholder:@"请输入新密码"];
    self.PasswordCell2 = [RETextItem itemWithTitle:@"确认密码" value:nil
                                           placeholder:@"请再次输入新密码"];
    
    [section addItem:self.originalPasswordCell];
    [section addItem:self.PasswordCell1];
    [section addItem:self.PasswordCell2];
    
    [self.view addSubview:self.completeBtn];
    self.completeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.tableview.frame), kScreenWidth-40, 40);
    self.completeBtn.layer.cornerRadius = 3;
}

-(UIButton*)completeBtn{
    if(!_completeBtn){
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor = [UIColor jk_colorWithHexString:@"#dd534c"];
        [_completeBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    }
    return _completeBtn;
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth, 180) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.tableFooterView = [UIView new];
//        _tableview.separatorColor = [UIColor blackColor];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}











































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
