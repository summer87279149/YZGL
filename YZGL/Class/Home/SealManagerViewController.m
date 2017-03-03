//
//  SealManagerViewController.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "SealManagerCell.h"
#import "SealManagerViewController.h"
#import "UIScrollView+EmptyDataSet.h"
@interface SealManagerViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation SealManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button1 = [self createBtnWithTitle:@"申请记录"];
    [self.button1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.button2 = [self createBtnWithTitle:@"审核记录"];
    [self.button2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.frame = CGRectMake(0, 64, kScreenWidth/2, 30);
    self.button2.frame = CGRectMake(kScreenWidth/2, 64, kScreenWidth/2, 30);
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.tableview];
}
-(void)btnClicked:(UIButton*)sender{
    if (sender == self.button1) {
        
    }
    if (sender == self.button2) {
        
    }
}



-(UIButton*)createBtnWithTitle:(NSString*)title{
    UIButton *btn = [UIButton XT_createBtnWithTitle:title TitleColor:[UIColor jk_colorWithHexString:@"#ff5722"] TitleFont:nil cornerRadio:nil BGColor:nil Borderline:nil BorderColor:nil target:nil Method:nil];
    return btn;
}


#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+30, kScreenWidth, kScreenHeight-64-30) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"SealManagerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SealManagerCellId"];
        _tableview.tableFooterView = [UIView new];
        _tableview.emptyDataSetSource = self;
        _tableview.emptyDataSetDelegate = self;
        
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SealManagerCell*cell = [tableView dequeueReusableCellWithIdentifier:@"SealManagerCellId" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;
}

#pragma mark - DZNEmptyDataSetSource



-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text = @"没有数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"此处没有更多数据了";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    
        NSString *imageName = [@"placeholder_appstore" lowercaseString];
        return [UIImage imageNamed:imageName];
    
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    
    NSLog(@"点击了空数据");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
