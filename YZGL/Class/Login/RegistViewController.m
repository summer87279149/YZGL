//
//  RegistViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UserTool.h"
#import "LoginAndRegistRequestManager.h"
#import "Login3ViewController.h"
#import "Login2ViewController.h"
#import "RegistViewController.h"
#import "UIButton+JKCountDown.h"

@interface RegistViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UITableView *tableview2;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETableViewManager *manager2;
@property (nonatomic, strong) RETableViewSection *section;
@property (nonatomic, strong) RETextItem *companyName;
@property (nonatomic, strong) RETextItem *userName;
@property (nonatomic, strong) RETextItem *password;
@property (nonatomic, strong) RETextItem *passwordVerify;
@property (nonatomic, strong) RENumberItem *phoneNum;
@property (nonatomic, strong) RENumberItem *hurryPhoneNum;
@property (nonatomic, strong) RENumberItem *vertifyCode;
@property (nonatomic, strong) RENumberItem *hurryVertifyCode;
@property (nonatomic, strong) UIButton *vertifyBtn;
@property (nonatomic, strong) UIButton *hurryVertifyBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    _nextBtn.layer.borderWidth = 1;
    _nextBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _nextBtn.layer.cornerRadius = 3;
    
    [self setupview1];
//    [self setupview2];//打开就会遮住tableview
}
- (IBAction)switchValue:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex==0) {
        [self.section removeItemAtIndex:0];
        
    }else{
        self.companyName = [RETextItem itemWithTitle:@"公司名称:" value:@""];
        [self.section insertItem:self.companyName  atIndex:0];
    }
    [self.tableview reloadData];
}

-(void)setupview1{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    self.section = section;
    [self.manager addSection:section];
    
    self.userName = [RETextItem itemWithTitle:@"用户名:" value:@""];
    self.password = [RETextItem itemWithTitle:@"密码:" value:@""];
    self.password.secureTextEntry = YES;
    self.passwordVerify = [RETextItem itemWithTitle:@"确定密码:" value:@""];
    self.passwordVerify.secureTextEntry = YES;
    //
    self.phoneNum = [RENumberItem itemWithTitle:@"手机号码:" value:@""];
    self.vertifyBtn = [self createBtnWithTag:10];
    self.phoneNum.accessoryView = self.vertifyBtn;
    self.vertifyCode = [RENumberItem itemWithTitle:@"验证码:" value:@""];
    //
    self.hurryPhoneNum = [RENumberItem itemWithTitle:@"紧急手机号:" value:@""];
    self.hurryVertifyBtn = [self createBtnWithTag:20];
    self.hurryPhoneNum.accessoryView = self.hurryVertifyBtn;
    self.hurryVertifyCode = [RENumberItem itemWithTitle:@"验证码:" value:@""];
    //add
    [section addItem:self.userName];
    [section addItem:self.password];
    [section addItem:self.passwordVerify];
    [section addItem:self.phoneNum];
    [section addItem:self.vertifyCode];
//    [section addItem:self.hurryPhoneNum];
//    [section addItem:self.hurryVertifyCode];
}
-(UIButton*)createBtnWithTag:(NSInteger)tag{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [btn setTitle:@"验证码" forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.cornerRadius = 5;
    btn.tag = tag;
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    btn.tintColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(codeCountDown:) forControlEvents:UIControlEventTouchUpInside];
    btn.showsTouchWhenHighlighted = YES;
    return btn;
}

- (void)validateButtonPressed
{
    NSArray *managerErrors = self.manager.errors;
    if (managerErrors.count > 0) {
        NSMutableArray *errors = [NSMutableArray array];
        for (NSError *error in managerErrors) {
            [errors addObject:error.localizedDescription];
        }
        NSString *errorString = [errors componentsJoinedByString:@"\n"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息不全" message:errorString delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alert show];
    } else {
        NSLog(@"All good, no errors!");
    }
}
- (IBAction)nextBtnClicked:(UIButton *)sender {
   
    @weakify(self)
    [self validateButtonPressed];
    if(![UserTool isValidateMobile:self.phoneNum.value]){
        [MBProgressHUD showError:@"错误的手机号"];
        return;
    }
    if (![self.password.value isEqualToString:self.passwordVerify.value]) {
        [MBProgressHUD showError:@"两次密码不相等"];
        return;
    }
    SHOWHUD
    [LoginAndRegistRequestManager registWith:self.userName.value password:self.password.value smsCode:self.vertifyCode.value tel:self.phoneNum.value type:self.switchBtn.selectedSegmentIndex companyName:self.companyName.value success:^(id response) {
        @strongify(self)
        HIDEHUD
        NSLog(@"个人用户注册成功:%@",response);
        NSString *code = response[@"code"];
        NSString *message = response[@"message"];
        if ([code intValue]==1) {
            //成功注册
            [MBProgressHUD showSuccess:message];
            [self showAlertWithType:self.switchBtn.selectedSegmentIndex];
        }else{
            [MBProgressHUD showError:message];
        }

    } error:^(id response) {
        HIDEHUD
        [MBProgressHUD showError:@"请检查网络"];
    }];
    }
-(void)showAlertWithType:(NSInteger)typeNum{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否前往实名认证" message:@"稍后也可以自行前往认证" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self popoverPresentationController];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        typeNum==0?[self.navigationController pushViewController:[[Login3ViewController alloc]init] animated:YES]:[self.navigationController pushViewController:[[Login2ViewController alloc]init] animated:YES];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)setupview2{
    self.manager2 = [[RETableViewManager alloc] initWithTableView:self.tableview2];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
}

- (void)codeCountDown:(UIButton*)sender
{
    if(![UserTool isValidateMobile:self.phoneNum.value]){
        [MBProgressHUD showError:@"错误的手机号"];
        return;
    }
    [self codeCountDownTimerWith:sender];
//    WS(weakSelf)
    [LoginAndRegistRequestManager sendVertifyCodeTel:self.phoneNum.value success:^(id response) {
        NSString *code = response[@"code"];
        NSString *message = response[@"message"];
        if ([code intValue]==1) {
            [MBProgressHUD showSuccess:message];
        }else{
            [MBProgressHUD showError:message];
            return ;
        }
        
    } error:^(id response) {
        [MBProgressHUD showError:@"无网络"];
    }];
   
}

-(void)codeCountDownTimerWith:(UIButton*)sender{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据需求设置
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                sender.enabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                sender.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}










#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, kScreenWidth, 430) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
//        _tableview.separatorColor = [UIColor blackColor];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(UITableView*)tableview2{
    if(!_tableview2){
        _tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, kScreenWidth, kScreenHeight-90-120) style:UITableViewStylePlain];
        _tableview2.delegate = self;
        _tableview2.dataSource = self;
        _tableview2.tableFooterView = [UIView new];
        _tableview2.separatorColor = [UIColor blackColor];
        [self.view addSubview:_tableview2];
    }
    return _tableview2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
