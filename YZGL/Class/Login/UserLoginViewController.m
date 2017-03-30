//
//  UserLoginViewController.m
//  YZGL
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "NSNotificationCenter+JKMainThread.h"
#import "RequestManager.h"
#import "UserTool.h"
#import "RegistViewController.h"
#import "ForgetPasswordViewController.h"
#import "UserLoginViewController.h"

@interface UserLoginViewController ()
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *userName;
@property (nonatomic, strong) RETextItem *passWord;
@property (nonatomic, strong) UIButton *completeBtn;
@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登入";
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    
    self.userName = [RETextItem itemWithTitle:@"帐号" value:nil placeholder:@"请输入帐号"];
    self.passWord = [RETextItem itemWithTitle:@"密码" value:nil placeholder:@"请输入密码"];
    self.passWord.secureTextEntry = YES;
    
    [section addItem:self.userName];
    [section addItem:self.passWord];
    
    [self.view addSubview:self.completeBtn];
    self.completeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.tableview.frame), kScreenWidth-40, 40);
    self.completeBtn.layer.cornerRadius = 3;
    
    UIButton *forgetPasswordBtn = [UIButton XT_createBtnWithTitle:@"忘记密码" TitleColor:[UIColor jk_colorWithHexString:@"#dd534c"] TitleFont:@14 cornerRadio:nil BGColor:nil Borderline:nil BorderColor:nil target:self Method:@selector(forgetPasswordBtnClicked)];
    [self.view addSubview:forgetPasswordBtn];
    [forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.completeBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.centerX.mas_equalTo(self.completeBtn.mas_centerX).offset(40);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *registPasswordBtn = [UIButton XT_createBtnWithTitle:@"注册帐号" TitleColor:[UIColor jk_colorWithHexString:@"#dd534c"] TitleFont:@14 cornerRadio:nil BGColor:nil Borderline:nil BorderColor:nil target:self Method:@selector(registPasswordBtnClicked)];
    [self.view addSubview:registPasswordBtn];
    [registPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.completeBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
        make.centerX.mas_equalTo(self.completeBtn.mas_centerX).offset(-40);
        make.height.mas_equalTo(30);
    }];
}
-(void)registPasswordBtnClicked{
    [self.navigationController pushViewController:[RegistViewController new] animated:YES];
}

-(void)forgetPasswordBtnClicked{
    [self.navigationController pushViewController:[ForgetPasswordViewController new] animated:YES];
}
-(void)showMessage{
    [MBProgressHUD showError:@"登入已失效，请重新登入"];
}
-(void)completeClicked{
    if([UserTool isValidateMobile:self.userName.value]){
        @weakify(self);
        SHOWHUD
        [RequestManager loginWithPhoneNumber:self.userName.value password:self.passWord.value success:^(id response) {
            HIDEHUD
            @strongify(self);
            NSLog(@"登入成功返回的是:%@",response);
            NSString *code = response[@"code"];
            NSString *message = response[@"message"];
            switch ([code intValue]) {
                case 1:{
                    [UserModel shareManager].userToken = response[@"data"];
                    [[UserModel shareManager] save];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter]postNotificationName:DidLoginNotification object:@{@"userToken":response[@"data"]}];
                        
                    });
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                    break;
                default:{
                    [MBProgressHUD showError:message];
                }
                    break;
            }
            
        } error:^(id response) {
            [MBProgressHUD showError:@"请重试"];
        }];
    }else{
        [MBProgressHUD showError:@"手机号格式错误"];
        return;
    }
}






#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth, 100) style:UITableViewStylePlain];
        _tableview.tableFooterView = [UIView new];
        //        _tableview.separatorColor = [UIColor blackColor];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(UIButton*)completeBtn{
    if(!_completeBtn){
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor = [UIColor jk_colorWithHexString:@"#dd534c"];
        [_completeBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(completeClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}



































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
