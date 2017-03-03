//
//  HurryContactViewController.m
//  YZGL
//
//  Created by Admin on 17/3/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "HurryContactViewController.h"

@interface HurryContactViewController ()<UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RENumberItem *originalPasswordCell;
@property (nonatomic, strong) UIButton *vertifyBtn;
@end

@implementation HurryContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"更换紧急手机";
    [self setupview];
}

-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    
    self.originalPasswordCell = [RENumberItem itemWithTitle:@"安全码校验" value:nil placeholder:@"请输入安全码"];
    self.vertifyBtn = [self createBtnWithTag:10];
    self.originalPasswordCell.accessoryView = self.vertifyBtn;
    
    
   
    
    [section addItem:self.originalPasswordCell];
    
    
}

-(void)completeClicked:(UIButton*)sender{
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
    [btn setTitle:@"校验" forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.layer.cornerRadius = 5;
    btn.tag = tag;
    btn.titleLabel.font = [UIFont systemFontOfSize:11];
    btn.tintColor = [UIColor blackColor];
    [btn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(completeClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.showsTouchWhenHighlighted = YES;
    return btn;
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
