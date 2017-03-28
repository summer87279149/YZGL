//
//  SafePasswordViewController.m
//  YZGL
//
//  Created by Admin on 17/3/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "SafePasswordViewController.h"

@interface SafePasswordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RERadioItem *address;
@property (nonatomic, strong) RETextItem *originalPasswordCell;
@property (nonatomic, strong) RETextItem *PasswordCell1;
@property (nonatomic, strong) RETextItem *PasswordCell2;
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) UIButton *vertifyBtn;

@end

@implementation SafePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置安全密码";
    [self setupview];

}

-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    
    //验证紧急联系人
    @weakify(self);
    self.address = [RERadioItem itemWithTitle:@"验证紧急联系人:"  value:@" 请选择紧急联系人        " selectionHandler:^(RERadioItem *item) {
        @strongify(self);
        [item deselectRowAnimated:YES];
        [self pushVC];
    }];
    
    self.originalPasswordCell = [RETextItem itemWithTitle:@"验证码" value:nil placeholder:@"输入验证码"];
    self.vertifyBtn = [self createBtnWithTag:10];
    self.originalPasswordCell.accessoryView = self.vertifyBtn;
    
    //安全密码
    self.PasswordCell1 = [RETextItem itemWithTitle:@"安全密码" value:nil placeholder:@"请输入安全密码"];
    //确认密码
    self.PasswordCell2 = [RETextItem itemWithTitle:@"确认密码" value:nil  placeholder:@"请输入确认密码"];
    [section addItem:self.address];
    [section addItem:self.originalPasswordCell];
    [section addItem:self.PasswordCell1];
    [section addItem:self.PasswordCell2];
    
    [self.view addSubview:self.completeBtn];
    self.completeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.tableview.frame), kScreenWidth-40, 40);
    self.completeBtn.layer.cornerRadius = 3;
}
-(void)pushVC{
    [self.navigationController pushViewController:[UIViewController new] animated:YES];
}
-(void)completeClicked{
    if([self validateButtonPressed]){
        
    }
}
- (BOOL)validateButtonPressed
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
        return NO;
    } else {
        NSLog(@"All good, no errors!");
        return YES;
    }
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
- (void)codeCountDown:(UIButton*)sender
{
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

-(UIButton*)completeBtn{
    if(!_completeBtn){
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor = [UIColor jk_colorWithHexString:@"#dd534c"];
        [_completeBtn setTitle:@"确认设置" forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(completeClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth, 180) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.tableFooterView = [UIView new];
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
    // Dispose of any resources that can be recreated.
}






@end
