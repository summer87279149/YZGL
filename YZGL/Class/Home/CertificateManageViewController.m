//
//  CertificateManageViewController.m
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "AddCertifateViewController.h"
#import "CertificateManageTableViewCell.h"
#import "CertificateManageViewController.h"

@interface CertificateManageViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UISegmentedControl *topSwitch;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation CertificateManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"证件管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
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
-(void)add{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"身份证" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddCertifateViewController *vc = [[AddCertifateViewController alloc]initWithCertifateType:CertifateTypeIDCard];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *hukou = [UIAlertAction actionWithTitle:@"户口簿" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddCertifateViewController *vc = [[AddCertifateViewController alloc]initWithCertifateType:CertifateTypeHuKouBu];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *DIY = [UIAlertAction actionWithTitle:@"自定义证件" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AddCertifateViewController *vc = [[AddCertifateViewController alloc]initWithCertifateType:CertifateTypeDIY];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [alertController addAction:okAction];
    [alertController addAction:hukou];
    [alertController addAction:DIY];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)valueChanged:(UISegmentedControl*)sender{
//    sender.selectedSegmentIndex;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificateManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"certiCell" forIndexPath:indexPath];
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
        [_tableview registerNib:[UINib nibWithNibName:@"CertificateManageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"certiCell"];
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
        _topSwitch = [[UISegmentedControl alloc]initWithItems:@[@"证件原件",@"防伪原件"]];
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
