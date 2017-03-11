//
//  StaffManageViewController.m
//  YZGL
//
//  Created by Admin on 17/3/2.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "SerachResultTableViewController.h"
#import "AddStaffViewController.h"
#import "StaffManageViewController.h"
#import "StaffManageTableViewCell.h"
@interface StaffManageViewController ()<UITableViewDelegate,UITableViewDataSource>
//{
//    UISearchBar *searchBar;
//}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cellArr;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SerachResultTableViewController *searchResultVC;
@end

@implementation StaffManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
//    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20*k_scale, 70*k_scaleHeight, kScreenWidth-40*k_scale, 40)];
//    searchBar.translucent = YES;
//    searchBar.searchBarStyle = UISearchBarStyleMinimal;
//    searchBar.barStyle = UIBarStyleBlack;
//    searchBar.placeholder = @"输入职务/昵称/手机号进行搜索";
//    [self.view addSubview:searchBar];
    [self.view addSubview:self.tableview];
    [self.tableview setTableHeaderView:self.searchController.searchBar];
}

-(void)add{
    [self.navigationController pushViewController:[AddStaffViewController new] animated:YES];
}






#pragma mark - UISearchBarAll
#pragma mark - Getter
- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultVC];
        [_searchController.searchBar setPlaceholder:@"输入职务/昵称/手机号进行搜索"];
        [_searchController.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
        [_searchController.searchBar sizeToFit];
        [_searchController setSearchResultsUpdater:self.searchResultVC];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    }
    return _searchController;
}

- (SerachResultTableViewController *) searchResultVC
{
    if (_searchResultVC == nil) {
        _searchResultVC = [[SerachResultTableViewController alloc] init];
        _searchResultVC.cellArray = self.cellArr;
    }
    return _searchResultVC;
}


#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-75*k_scaleHeight-40) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        [_tableview registerNib:[UINib nibWithNibName:@"StaffManageTableViewCell" bundle:[NSBundle mainBundle] ]  forCellReuseIdentifier:@"StaffManageTableViewCellId"];
        [self.view addSubview:_tableview];
       
    }
    return _tableview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 101;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StaffManageTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"StaffManageTableViewCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cellArr.count>0) {
    }
    return cell;
}
-(NSMutableArray*)cellArr{
    if(!_cellArr){
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
