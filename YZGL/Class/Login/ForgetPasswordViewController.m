//
//  ForgetPasswordViewController.m
//  YZGL
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UserTool.h"
#import "RequestManager.h"
#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *phoneNum;
@property (nonatomic, strong) RENumberItem *vertifyCode;
@property (nonatomic, strong) RETextItem *password;
@property (nonatomic, strong) RETextItem *passwordVerify;

@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) UIButton *vertifyBtn;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"忘记密码";
    [self setupview];
}

-(void)setupview{
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    
    self.phoneNum = [RENumberItem itemWithTitle:@"手机号码:" value:@""];
    self.vertifyBtn = [self createBtnWithTag:10];
    self.phoneNum.accessoryView = self.vertifyBtn;
    self.vertifyCode = [RENumberItem itemWithTitle:@"验证码:" value:@""];
    self.password = [RETextItem itemWithTitle:@"密码:" value:@""];
    self.password.secureTextEntry = YES;
    self.passwordVerify = [RETextItem itemWithTitle:@"确定密码:" value:@""];
    self.passwordVerify.secureTextEntry = YES;
    
    [section addItem:self.phoneNum];
    [section addItem:self.vertifyCode];
    [section addItem:self.password];
    [section addItem:self.passwordVerify];
    [self.view addSubview:self.completeBtn];
    
    self.completeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.tableview.frame), kScreenWidth-40, 40);
    self.completeBtn.layer.cornerRadius = 3;
}


-(void)completeClicked{
    if (![self.passwordVerify.value isEqualToString:self.password.value]) {
        [MBProgressHUD showError:@"两次密码不一致"];
        return;
    }
    [RequestManager resetPasswordWith:self.phoneNum.value password:self.password.value smsCode:self.vertifyCode.value success:^(id response) {
        NSLog(@"打印一下修改密码:%@",response);
        NSString *code = response[@"code"];
        NSString *message = response[@"message"];
        [MBProgressHUD showSuccess:message];
        if ([code intValue]==1) {
            [self popoverPresentationController];
        }
    } error:^(id response) {
        [MBProgressHUD showError:@"请检查网络"];
    }];
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


- (void)codeCountDown:(UIButton*)sender
{
    if(![UserTool isValidateMobile:self.phoneNum.value]){
        [MBProgressHUD showError:@"错误的手机号"];
        return;
    }
    [self codeCountDownTimerWith:sender];
    [RequestManager sendVertifyCodeTel:self.phoneNum.value success:^(id response) {
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



#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth, 180) style:UITableViewStylePlain];
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
        [_completeBtn setTitle:@"重置密码" forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(completeClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
