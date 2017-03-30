//
//  PersonalDataViewController.m
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UIColor+extend.h"
#import "PersonalDIYCellModel.h"
#import "PersonaDIYCell.h"
#import "RequestManager.h"
#import "Login3ViewController.h"
#import "Login2ViewController.h"
#import "UIViewController+CameraAndPhoto.h"
#import "PersonalDataViewController.h"

@interface PersonalDataViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PersonalDIYCellModel *lastTwoCellModel;
@property (strong, nonatomic)  UITableView *tableview;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UIButton *switchCompanyBtn;
@end

@implementation PersonalDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self makeCellArr];
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
    [_image sd_setImageWithURL:[NSURL URLWithString:XT_IMAGE_URL([UserModel shareManager].headimg)] placeholderImage:[UIImage imageNamed:@"defaultUserImg.jpg"]];
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

-(void)getUserInfo{
    SHOWHUD
    WS(weakSelf)
    [RequestManager queryUserInfoSuccess:^(id response) {
        HIDEHUD
        
        [weakSelf refreshUI];
    } error:^(id response) {
    }];
}
//拿到当前所在公司的所有信息
-(void)getCurrentCompanyInfo{
    
}
-(void)refreshUI{
    //重做前4个cell的数据源
    [self makeCellArr];
    [_image sd_setImageWithURL:[NSURL URLWithString:XT_IMAGE_URL([UserModel shareManager].headimg)] placeholderImage:[UIImage imageNamed:@"defaultUserImg.jpg"]];
    NSLog(@"刷新ui的时候查看头像地址:%@",[UserModel shareManager].headimg);
    [self.tableview reloadData];
    [[NSNotificationCenter defaultCenter]postNotificationName:UserInfoChangedNotification object:nil userInfo:nil];
    if (self.callBack) {
        [self.callBack sendNext:nil];
    }
}



-(void)modifyImage{
    @weakify(self)
    self.xt_block = ^(NSData*data){
        @strongify(self)
//        self.image.image = [UIImage imageWithData:data];
        SHOWHUD
        [RequestManager changePortrait:[UIImage imageWithData:data] Success:^(id response) {
            HIDEHUD
            NSLog(@"上传头像返回是:%@",response);
            if ([response[@"code"]intValue]==1) {
                [UserModel shareManager].headimg = response[@"message"];
                [self refreshUI];
            }
            [MBProgressHUD showSuccess:@"上传成功"];
        } error:^(id response) {
            HIDEHUD
        }];
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
        [_tableview registerNib:[UINib nibWithNibName:@"PersonaDIYCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PersonaDIYCellID"];
    }
    return _tableview;
}
-(UIImageView*)image{
    if(!_image){
        _image = [[UIImageView alloc]init];
    }
    return _image;
}
-(void)makeCellArr{
        NSString *phone = [NSString stringWithFormat:@"手机号:  %@",[UserModel shareManager].phoneNumber];
        NSString *userName = [NSString stringWithFormat:@"用户名:  %@",[UserModel shareManager].userName];
    NSString *companyName;
    if ([UserModel shareManager].com) {
        
      companyName  = [NSString stringWithFormat:@"公司名:  %@",[UserModel shareManager].com[@"comName"] ];
    }else{
        companyName = @"公司名:";
    }
    NSString *zhiwu = [NSString stringWithFormat:@"职务:  %@",[UserModel shareManager].post];
        _cellArr = @[phone,userName,companyName,zhiwu];
}
#pragma mark - tableviewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        Login2ViewController *longin2 = [[Login2ViewController alloc]initSourceType:SourceTypeDefault];
        [self.navigationController pushViewController:longin2 animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <= 3) {
        return 50;
    }else{
        return 80;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row!=4&&indexPath.row!=5) {
        static NSString *tableCell = @"CellIdentifier";
        UITableViewCell *cell = (UITableViewCell* )[tableView dequeueReusableCellWithIdentifier:tableCell];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:tableCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        NSLog(@"%@",[UserModel shareManager].comList);
        if (indexPath.row == 2&&[UserModel shareManager].comList.count>1) {
            cell.accessoryView = self.switchCompanyBtn;
        }
        if (self.cellArr.count>0) {
            cell.textLabel.text = self.cellArr[indexPath.row];
        }

        return cell;
    }else{
        PersonaDIYCell*cell = [tableView dequeueReusableCellWithIdentifier:@"PersonaDIYCellID" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 4) {
            //拿到当前所在公司所有信息,设置第四个cell
            NSDictionary *dic = [UserModel shareManager].com;
            if (dic[@"comName"]) {
                cell.name.text = [NSString stringWithFormat:@"企业名称:%@",dic[@"comName"]];
            }
            
            cell.number.text = [NSString stringWithFormat:@"营业执照号码:%@",dic[@"blNo"]];
            //如果没有通过实名认证
            if ([dic[@"pass"] intValue]!=1 ) {
                [cell.rightTop setTitle:@"未通过认证" forState:UIControlStateNormal];
                [cell.rightTop setTitle:@"未通过认证" forState:UIControlStateHighlighted];
                cell.rightBottom.hidden = YES;
            }
        }
        if (indexPath.row == 5) {
            cell.rightBottom.hidden = YES;
            [cell.rightTop setTitle:@"个人实名认证" forState:UIControlStateNormal];
            [cell.rightTop setTitle:@"个人实名认证" forState:UIControlStateHighlighted];
            cell.name.text = [NSString stringWithFormat:@"真实姓名:%@",[UserModel shareManager].truename];
            cell.number.text = [NSString stringWithFormat:@"省份证号:%@",[UserModel shareManager].idcard];
        }
        return cell;
    }
    
}
#pragma mark - 切换单位
-(UIButton*)switchCompanyBtn{
    if(!_switchCompanyBtn){
        _switchCompanyBtn = [UIButton XT_createBtnWithTitle:@"切换单位" TitleColor:[UIColor whiteColor] TitleFont:@14 cornerRadio:@3 BGColor:[UIColor getColor:@"00FF99"] Borderline:nil BorderColor:nil target:self Method:@selector(switchCompany)];
        _switchCompanyBtn.frame =CGRectMake(0, 0, 70, 20);
    }
    return _switchCompanyBtn;
}
-(void)switchCompany{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"切换单位" message:@"请选择要切换的单位" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    for (NSDictionary *dic in [UserModel shareManager].comList) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:dic[@"comName"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                SHOWHUD
                [RequestManager switchCompanycomID:dic[@"comId"] success:^(id response) {
                    NSLog(@"切换成功返回:%@",response);
                    HIDEHUD
                    if ([response[@"code"] intValue]==1) {
                        //刷新页面
                        [self getUserInfo];
                    }
                } error:^(id response) {
                    HIDEHUD
                }];
            }];
            [alertController addAction:okAction];
    }
    
    
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)dealloc{
    self.xt_block = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
