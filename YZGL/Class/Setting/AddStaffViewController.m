//
//  AddStaffViewController.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "RETableViewOptionsController.h"
#import "AddStaffViewController.h"

@interface AddStaffViewController ()<UITableViewDelegate,RETableViewManagerDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) RETextItem *duty;
@property (nonatomic, strong) RETextItem *vertifyCode;
@property (nonatomic, strong) RETextItem *name;
@property (nonatomic, strong) RENumberItem *phoneNumber;
@property (strong, readwrite, nonatomic) RERadioItem *radioItem;
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) UIButton *vertifyBtn;

@end

@implementation AddStaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加人员";
    [self setupview];
}

-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //职位
    
    self.radioItem = [RERadioItem itemWithTitle:@"职务类型" value:@"职员" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        WS(weakSelf)
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:weakSelf.arr multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
       [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    //验证码
    self.vertifyCode = [RETextItem itemWithTitle:@"验证码" value:nil placeholder:@"输入验证码"];
    self.vertifyBtn = [self createBtnWithTag:10];
    self.vertifyCode.accessoryView = self.vertifyBtn;
    //职务
    self.duty = [RETextItem itemWithTitle:@"职务" value:nil placeholder:@"请输入姓名"];

    //姓名
    self.name = [RETextItem itemWithTitle:@"姓名" value:nil placeholder:@"请输入姓名"];
    //确认密码
    self.phoneNumber = [RENumberItem itemWithTitle:@"手机号" value:nil  placeholder:@"请输入手机号"];
    [section addItem:self.duty];
    [section addItem:self.radioItem];
    [section addItem:self.name];
    [section addItem:self.phoneNumber];
    [section addItem:self.vertifyCode];
    [self.view addSubview:self.completeBtn];
    self.completeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.tableview.frame), kScreenWidth-40, 40);
    self.completeBtn.layer.cornerRadius = 3;
}
-(void)pushVC{
    [self xt_pushWithViewControllerClass:[UIViewController class]];
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
    __block int timeout=30; //倒计时时间
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


#pragma mark - lazy

-(NSArray*)arr{
    if(!_arr){
        _arr = @[@"管理层/授权人", @"职员"];
    }
    return _arr;
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
}



@end
