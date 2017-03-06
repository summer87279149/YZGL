//
//  ElectronicalRealViewController.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "FileDetailViewController.h"
#import "UploadFileViewController.h"
#import "CheckViewController.h"
#import "AddElectronicalRealViewController.h"
#import "ElectronicalRealViewController.h"
#import "ElectronicalRealViewCell.h"
@interface ElectronicalRealViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UISegmentedControl *topSwitch;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) UIBarButtonItem*item;
@end

@implementation ElectronicalRealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"电子印章管理";
    _item = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    self.navigationItem.rightBarButtonItem = _item;
    
    [self.view addSubview:self.topSwitch];
    [self.topSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view).offset(-40);
        make.top.mas_equalTo(self.view).offset(74);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.topSwitch).offset(-10);
        make.top.mas_equalTo(self.topSwitch.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(25);
    }];
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom).offset(10);
        make.bottom.left.right.mas_equalTo(self.view);
    }];
    
}

-(void)add:(UIBarButtonItem*)sender{
    
    if ([sender.title isEqualToString:@"添加"]) {
        AddElectronicalRealViewController*vc = [[AddElectronicalRealViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        CheckViewController *vc = [[CheckViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)valueChanged:(UISegmentedControl*)sender{
    if (sender.selectedSegmentIndex == 0) {
        _item.title = @"添加";
        _searchBar.placeholder = @"输入印章名称进行检索";
//        _tableview.hidden = NO;
    }else{
        _item.title = @"审批";
        _searchBar.placeholder = @"输入印章名称/签字码进行检索";
//        _tableview.hidden = YES;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.topSwitch.selectedSegmentIndex == 0) {
        [self xt_pushWithViewControllerClass:[UploadFileViewController class]];
    }else{
        [self xt_pushWithViewControllerClass:[FileDetailViewController class]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ElectronicalRealViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ElectronicalRealViewCellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, kScreenWidth, 430) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        [_tableview registerNib:[UINib nibWithNibName:@"ElectronicalRealViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ElectronicalRealViewCellID"];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
-(UISearchBar*)searchBar{
    if(!_searchBar){
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.myLeftMargin = 15;
        _searchBar.myHeight = 40;
        _searchBar.myWidth = kScreenWidth - 75;
        _searchBar.translucent = YES;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.barStyle = UIBarStyleBlack;
        _searchBar.placeholder = @"输入证件名称/编号进行检索";
    }
    return _searchBar;
}


-(UISegmentedControl*)topSwitch{
    if(!_topSwitch){
        _topSwitch = [[UISegmentedControl alloc]initWithItems:@[@"电子印章",@"使用记录"]];
        //        [_topSwitch setTitle:@"证件原件" forSegmentAtIndex:0];
        //        [_topSwitch setTitle:@"防伪原件" forSegmentAtIndex:1];
        [_topSwitch setTintColor:[UIColor blackColor]];
        //        [_topSwitch setBackgroundColor: [UIColor blackColor]];
        _topSwitch.selectedSegmentIndex = 0;
        [_topSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        _topSwitch.layer.cornerRadius = 4;
    }
    return _topSwitch;
}













































































































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
