//
//  RecordViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()<UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) REDateTimeItem *certifyDate;
@property (nonatomic, strong) RETextItem *queryContent;
@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(query)];
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //有效期
    
    self.certifyDate = [REDateTimeItem itemWithTitle:@"查询日期:" value:[NSDate date] placeholder:nil format:@"MM/dd/yyyy " datePickerMode:UIDatePickerModeDate];
    self.certifyDate.accessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.certifyDate.accessoryType = UITableViewCellAccessoryDetailButton;
    self.certifyDate.onChange = ^(REDateTimeItem *item){
        NSLog(@"选择时间: %@", item.value.description);
    };
    self.queryContent = [RETextItem itemWithTitle:@"查询内容:" value:nil placeholder:@"签字码/关键字"];
    [section addItem:self.certifyDate];
    [section addItem:self.queryContent];
}

-(void)query{
    
}























#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 130, kScreenWidth, 100) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.tableFooterView = [UIView new];
//        _tableview.separatorColor = [UIColor blackColor];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
