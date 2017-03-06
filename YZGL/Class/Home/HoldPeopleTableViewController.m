//
//  HoldPeopleTableViewController.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "HoldPeopleTableViewController.h"

@interface HoldPeopleTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@end

@implementation HoldPeopleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择";
    [self.view addSubview:self.tableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray*)cellArr{
    if(!_cellArr){
        _cellArr = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    }
    return _cellArr;
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth,400) style:UITableViewStylePlain];
        _tableview.tableFooterView = [UIView new];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        
    }
    return _tableview;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.callBack) {
        self.callBack(indexPath.row);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:tableCell];
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"dfhead"]];
    cell.textLabel.text = @"张三";
    cell.detailTextLabel.text = @"18101508888";
    if (self.cellArr) {
        
    }
    
    return cell;
}

@end
