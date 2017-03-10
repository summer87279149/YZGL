//
//  PersonalDataViewController.m
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "Login3ViewController.h"
#import "Login2ViewController.h"
#import "UIViewController+CameraAndPhoto.h"
#import "PersonalDataViewController.h"

@interface PersonalDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableview;
@property (nonatomic, strong) UIImageView *image;
@end

@implementation PersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64);
        make.left.and.right.and.bottom.equalTo(self.view);
        
    }];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifyImage)];
    [view addGestureRecognizer:tap];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tableview.mas_right);
        make.top.mas_equalTo(self.tableview.mas_top);
        make.width.mas_equalTo(64*k_scale);
        make.height.mas_equalTo(88*k_scale);
    }];
    [view addSubview:self.image];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top);
        make.width.mas_equalTo(view.mas_width);
        make.height.mas_equalTo(view.mas_width);
        make.left.mas_equalTo(view.mas_left);
    }];
    _image.layer.cornerRadius = 32*k_scale;
    _image.layer.masksToBounds = YES;
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"修改头像";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_image.mas_bottom);
        make.left.right.mas_equalTo(_image);
    }];
}
-(void)modifyImage{
    @weakify(self)
    self.xt_block = ^(NSData*data){
        @strongify(self)
        self.image.image = [UIImage imageWithData:data];
    };
    [self openImagePickerWithType:XTCameraTypeSeal];
}
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.tableFooterView = [UIView new];
        _tableview.scrollEnabled = NO;
    }
    return _tableview;
}
-(UIImageView*)image{
    if(!_image){
        _image = [[UIImageView alloc]init];
        
    }
    return _image;
}
-(NSArray*)cellArr{
    if(!_cellArr){
        _cellArr = @[@"手机号",@"用户名",@"公司名",@"职务",@"未通过实名认证"];
    }
    return _cellArr;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        Login2ViewController *longin2 = [[Login2ViewController alloc]init];
        [self.navigationController pushViewController:longin2 animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell* )[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cellArr.count>0) {
        cell.textLabel.text = self.cellArr[indexPath.row];
    }
    if(indexPath.row == 4){
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"RealNameAauthentication"]];
    }
    
    return cell;
}
-(void)dealloc{
    self.xt_block = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
