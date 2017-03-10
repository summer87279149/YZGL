//
//  HomeViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UserLoginViewController.h"
#import "MatterListViewController.h"
#import "ElectronicalRealViewController.h"
#import "SealManagerViewController.h"
#import "TrueAndFalseQueryViewController.h"
#import "CertificateManageViewController.h"
#import "PersonalDataViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "SearchView.h"

@interface HomeViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, copy) NSArray *cellArr;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - UITableView
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{ [self xt_pushWithViewControllerClass:[CertificateManageViewController class]]; } break;
        case 1:{ [self xt_pushWithViewControllerClass:[SealManagerViewController class]]; } break;
        case 3:{ [self xt_pushWithViewControllerClass:[TrueAndFalseQueryViewController class]]; }break;
        case 4:{ [self xt_pushWithViewControllerClass:[ElectronicalRealViewController class]]; }break;
        case 5:{ [self xt_pushWithViewControllerClass:[MatterListViewController class]]; }break;
        default:{
            UserLoginViewController *vc = [[UserLoginViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*k_scale;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellArr.count;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
    [self.view resignFirstResponder];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableCell = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell* )[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:tableCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.cellArr.count>0) {
        NSDictionary *dic = self.cellArr[indexPath.row];
        cell.textLabel.text = dic[@"title"];
        cell.detailTextLabel.text = dic[@"detail"];
        cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    }
    
    return cell;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
#pragma mark - setupView
-(void)setupView{
    self.navigationController.delegate = self;
    SearchView *searchView = [[SearchView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    [self.view addSubview:searchView];
//    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(44);
//        make.top.mas_equalTo(self.view).offset(20);
//        make.width.mas_equalTo(self.view);
//        make.left.mas_equalTo(self.view);
//    }];
    MyLinearLayout *rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    rootLayout.widthDime.equalTo(self.view.widthDime);
    rootLayout.myTopMargin = 64;
    rootLayout.wrapContentHeight = YES;
    
    MyLinearLayout *topLinearLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    topLinearLayout.myWidth = kScreenWidth;
    topLinearLayout.backgroundImage = [UIImage imageNamed:@"TopImage.jpg"];
    topLinearLayout.myHeight = 175*k_scale;
    
    MyFlowLayout *flowLayout = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:3];
    flowLayout.backgroundColor = RGBA(157, 28, 9, 0.8);
    flowLayout.myHeight = 42*k_scale;
    flowLayout.myWidth = kScreenWidth;
    flowLayout.myTopMargin = 175*k_scale - 42*k_scale;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushPersonalData)];
    [flowLayout addGestureRecognizer:tap];
    [topLinearLayout addSubview:flowLayout];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.myWidth = imgView.myHeight = 60;
    imgView.myTopMargin = -10;
    imgView.layer.cornerRadius = 30;
    imgView.layer.masksToBounds = YES;
    imgView.backgroundColor = [UIColor blueColor];
    [flowLayout addSubview:imgView];
    
    MyFlowLayout *flowLayout2 = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:2];
    flowLayout2.myHeight = 42*k_scale;
    flowLayout2.wrapContentWidth = YES;
    flowLayout2.myLeftMargin = 15;
    flowLayout2.myTopMargin = 10;
    UILabel *nameLab = [[UILabel alloc]init];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.text = @"用户姓名";
    [nameLab sizeToFit];
    [flowLayout2 addSubview:nameLab];
    
    UIImageView *tagImg = [[UIImageView alloc]init];
    tagImg.myWidth = 40*k_scale;
    tagImg.myHeight = 14*k_scale;
    tagImg.myLeftMargin = 15;
    tagImg.image = [UIImage imageNamed:@"CompanyManager"];
    tagImg.layer.cornerRadius = 2;
    tagImg.layer.masksToBounds = YES;
    tagImg.backgroundColor = [UIColor blueColor];
    [flowLayout2 addSubview:tagImg];
    
    UILabel *phoneLab = [[UILabel alloc]init];
    phoneLab.text = @"18101508289";
    phoneLab.textColor = [UIColor whiteColor];
    [phoneLab sizeToFit];
    [flowLayout2 addSubview:phoneLab];
    
    
    [flowLayout addSubview:flowLayout2];
    
    MyRelativeLayout *relativeLayout = [MyRelativeLayout new];
    relativeLayout.weight = 1;
    relativeLayout.myHeight = 42*k_scale;
    
    UIImageView *rightAuthenticationImg = [[UIImageView alloc]init];
    rightAuthenticationImg.myWidth = 80*k_scale;
    rightAuthenticationImg.myHeight = 25*k_scale;
    rightAuthenticationImg.rightPos.equalTo(relativeLayout.rightPos).offset(15);
    rightAuthenticationImg.centerYPos.equalTo(relativeLayout.centerYPos);
    rightAuthenticationImg.image = [UIImage imageNamed:@"rightAuthenticationImg"];
    [relativeLayout addSubview:rightAuthenticationImg];
    [flowLayout addSubview:relativeLayout];
    [rootLayout addSubview:topLinearLayout];
    
    [self.view addSubview:rootLayout];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-topLinearLayout.myHeight-64-49) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
    [rootLayout addSubview:self.tableview];

}
-(void)pushPersonalData{
    PersonalDataViewController *vc = [[PersonalDataViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSArray*)cellArr{
    if (!_cellArr) {
        _cellArr = @[@{@"title":@"证件管理",
                       @"image":@"11",
                       @"detail":@"您的证件复印件管理专家"
                       
                       },@{@"title":@"印章管理",
                           @"image":@"22",
                           @"detail":@"公司印章签字码安全使用"
                           
                           },@{@"title":@"签字码管理",
                               @"image":@"33",
                               @"detail":@"安全使用记录不遗漏"
                               
                               },@{@"title":@"真伪查询",
                                   @"image":@"44",
                                   @"detail":@"证件合同轻松辨真伪查询"
                                   
                                   },@{@"title":@"电子印章",
                                       @"image":@"55",
                                       @"detail":@"随身的便携印章使用"
                                       
                                       },@{@"title":@"签字确定",
                                           @"image":@"66",
                                           @"detail":@"事项确定简易双方协定"
                                           }
                     ];
    }
    return _cellArr;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
