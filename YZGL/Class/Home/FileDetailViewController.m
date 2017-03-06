//
//  FileDetailViewController.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "DXPopover.h"
#import "FileDetailViewController.h"

@interface FileDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) DXPopover *popover;
@property(nonatomic, strong) UITableView *popoverTableView;
@property(nonatomic, strong) MyLinearLayout *contentLayout;
@property(nonatomic, strong) NSArray *cellArr;
@end

@implementation FileDetailViewController

-(void)loadView{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.view = scrollView;
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    contentLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10); //设置布局内的子视图离自己的边距.
    contentLayout.myLeftMargin = 0;
    contentLayout.myRightMargin = 0;
    contentLayout.gravity = MyMarginGravity_Horz_Center;
    contentLayout.heightDime.lBound(scrollView.heightDime, 10, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    [scrollView addSubview:contentLayout];
    contentLayout.backgroundColor = [UIColor whiteColor];
    self.contentLayout = contentLayout;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文件详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"审核情况" style:UIBarButtonItemStylePlain target:self action:@selector(checkState:)];
    [self createSection];
    [self createrPopoverView];
    self.popover = [DXPopover popover];
}
-(void)createrPopoverView{
    
    
}
-(void)checkState:(UIBarButtonItem*)item{
    CGPoint point =  CGPointMake(kScreenWidth-30, 70);
    [_popover showAtPoint:point popoverPostion:DXPopoverPositionDown withContentView:self.popoverTableView inView:self.view];
//    [_popover showAtView:item popoverPostion:DXPopoverPositionDown withContentView:self.popoverTableView inView:self.view];
}
-(void)addPhotos{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:nil];
    [self.contentLayout addSubview:imageView];
}
-(void)agree:(UIButton*)sender{
    
    
    if (sender.tag == 20) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定同意该申请吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定拒绝该申请吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

-(void)createSection
{   //同意按钮
    UIButton *btn = [[UIButton alloc]init];
    btn.useFrame = YES;
    btn.frame = CGRectMake(0, kScreenHeight - 30*k_scaleHeight, kScreenWidth/2, 30*k_scaleHeight);
    [btn setTitle:@"同意" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = 20;
    btn.backgroundColor = [UIColor jk_colorWithHexString:@"#ff5722"];
    btn.showsTouchWhenHighlighted =  YES;
    [self.contentLayout addSubview:btn];
    //拒绝按钮
    UIButton *btn2 = [[UIButton alloc]init];
    btn2.useFrame = YES;
    btn2.frame = CGRectMake(kScreenWidth/2, kScreenHeight - 30*k_scaleHeight, kScreenWidth/2, 30*k_scaleHeight);
    [btn2 setTitle:@"拒绝" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 30;
    btn2.backgroundColor = [UIColor jk_colorWithHexString:@"#dd524d"];
    btn2.showsTouchWhenHighlighted =  YES;
    [self.contentLayout addSubview:btn2];
    
    
}
-(NSArray*)cellArr{
    if(!_cellArr){
        _cellArr = @[@{@"title":@"审核进度",@"value":@""},@{@"title":@"管理员-哈哈",@"value":@"未处理"}];
    }
    return _cellArr;
}
-(UITableView*)popoverTableView{
    if(!_popoverTableView){
        _popoverTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 180*k_scale, 100) style:UITableViewStylePlain];
        _popoverTableView.delegate = self;
        _popoverTableView.dataSource = self;
        _popoverTableView.tableFooterView = [UIView new];
    }
    return _popoverTableView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                          reuseIdentifier:tableCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.cellArr[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"value"];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
