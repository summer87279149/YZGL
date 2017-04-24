//
//  HomeViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "BaseNavViewController.h"
#import "RequestManager.h"
#import "Login2ViewController.h"
#import "BeforeScanSingleton.h"
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

@interface HomeViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>{
    MyLinearLayout *topLinearLayout;
    UILabel *phoneLab;
    UIImageView *imgView;
    UILabel *nameLab;
    UILabel *managerOrStuff;
}
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, copy) NSArray *cellArr;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self request];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveDidLoginNotification) name:DidLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(OtherAddressLogin) name:OtherAddressLogin object:nil];

}
-(void)OtherAddressLogin{
    UserLoginViewController*loginVc = [[UserLoginViewController alloc]init];
    loginVc.title = @"登入";
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:loginVc];
    [self presentViewController:nav animated:YES completion:nil];
    [loginVc showMessage];
    
}
-(void)receiveDidLoginNotification{
    [self request];
}
#pragma mark - 重新请求并刷新主页所有数据
-(void)request{
    if (![UserModel userToken]) {
//        NSLog(@"usertoken饰:%@",[UserModel userToken]);
        return;
    }
        WS(weakSelf)
        SHOWHUD
        [RequestManager queryHomeUserInfoSuccess:^(id response) {
            HIDEHUD
                [weakSelf getUserInfo];
                NSLog(@"图片请求:%@",response);
            NSDictionary *dic = response;
            NSString *codeStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
            if ( [codeStr isEqualToString:@"1"]) {
                NSString *str =[[dic[@"data"]objectForKey:@"imgs"][0] objectForKey:@"img"];
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:XT_IMAGE_URL(str)]];
                NSLog(@"图片地址: %@",XT_IMAGE_URL(str));
                dispatch_async(dispatch_get_main_queue(), ^{
                    topLinearLayout.backgroundImage = [UIImage imageWithData:imgData];
                });
                
            }
            
        } error:^(id response) {
            HIDEHUD;
        }];
}
-(void)getUserInfo{
    WS(weakSelf)
    [RequestManager queryUserInfoSuccess:^(id response) {
            [weakSelf refreshUI];
    } error:^(id response) {
    }];
}
-(void)refreshUI{
    HIDEHUD
    dispatch_async(dispatch_get_main_queue(), ^{
        [imgView sd_setImageWithURL:[NSURL URLWithString:XT_IMAGE_URL([UserModel shareManager].headimg)]placeholderImage:[UIImage imageNamed:@"defaultUserImg.jpg"]];
        nameLab.text = [UserModel shareManager].userName;
        NSLog(@"mingzi shi %@=",nameLab.text);
        phoneLab.text = [UserModel shareManager].phoneNumber;
        managerOrStuff.text = [[UserModel shareManager].personalOrCompany isEqualToString:@"1"]?@"个人用户":@"公司职员";
        if([[UserModel shareManager].role isEqualToString:@"2"]&&[[UserModel shareManager].personalOrCompany isEqualToString:@"2"]){
            managerOrStuff.text = @"公司管理员";
        }
        [self.tableview reloadData];
    });
    
}
#pragma mark -
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:UserInfoChangedNotification object:nil];
}


#pragma mark - UITableView
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{ [self.navigationController pushViewController:[CertificateManageViewController new] animated:YES];} break;
        case 1:{ [self.navigationController pushViewController:[SealManagerViewController new] animated:YES];} break;
        case 2:{ [self.navigationController pushViewController:[Login2ViewController new] animated:YES];}break;
        case 3:{ [self.navigationController pushViewController:[TrueAndFalseQueryViewController new] animated:YES];}break;
        case 4:{ [self.navigationController pushViewController:[ElectronicalRealViewController new] animated:YES];}break;
        case 5:{ [self.navigationController pushViewController:[MatterListViewController new] animated:YES];}break;
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
    //如果是个人用户
    if ([[UserModel shareManager].personalOrCompany isEqualToString:@"1"]) {
        if (indexPath.row==1||indexPath.row==2||indexPath.row==4) {
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.userInteractionEnabled = NO;
        }
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
    searchView.delegate = [RACSubject subject];
    WS(weakSelf)
    [searchView.delegate subscribeNext:^(id x) {
        [weakSelf erweima];
    }];
    [self.view addSubview:searchView];

    MyLinearLayout *rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    rootLayout.widthDime.equalTo(self.view.widthDime);
    rootLayout.myTopMargin = 64;
    rootLayout.wrapContentHeight = YES;
    
    topLinearLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
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
    
    imgView = [[UIImageView alloc]init];
    imgView.myWidth = imgView.myHeight = 60;
    imgView.myTopMargin = -10;
    imgView.layer.cornerRadius = 30;
    imgView.layer.masksToBounds = YES;
    imgView.backgroundColor = [UIColor blueColor];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[UserModel shareManager].headimg]placeholderImage:[UIImage imageNamed:@"defaultUserImg.jpg"]];
    [flowLayout addSubview:imgView];
    
    MyFlowLayout *flowLayout2 = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:2];
    flowLayout2.myHeight = 42*k_scale;
    flowLayout2.wrapContentWidth = YES;
    flowLayout2.myLeftMargin = 15;
    flowLayout2.myTopMargin = 3;
    flowLayout2.subviewVertMargin = 3;
    flowLayout2.gravity = MyMarginGravity_Vert_Center;
    nameLab = [[UILabel alloc]init];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.text =@"XXXXXXXXXX";
    [nameLab sizeToFit];
    nameLab.myHeight = 14*k_scale;
    [flowLayout2 addSubview:nameLab];
    
//    UIImageView *tagImg = [[UIImageView alloc]init];
//    tagImg.myWidth = 40*k_scale;
//    tagImg.myHeight = 14*k_scale;
//    tagImg.myLeftMargin = 15;
//    tagImg.image = [UIImage imageNamed:@"CompanyManager"];
//    tagImg.layer.cornerRadius = 2;
//    tagImg.layer.masksToBounds = YES;
//    tagImg.backgroundColor = [UIColor blueColor];
//    [flowLayout2 addSubview:tagImg];
    
    managerOrStuff = [self managerOrStuff:@"2"];
    [flowLayout2 addSubview:managerOrStuff];
    
    
    
    
    phoneLab = [[UILabel alloc]init];
//    phoneLab.text = [UserModel shareManager].phoneNumber;
    phoneLab.textColor = [UIColor whiteColor];
    phoneLab.text = @"XXXXXXXXXXX";
    [phoneLab sizeToFit];
    [flowLayout2 addSubview:phoneLab];
    
    
    [flowLayout addSubview:flowLayout2];
    
    MyRelativeLayout *relativeLayout = [MyRelativeLayout new];
    relativeLayout.weight = 1;
    relativeLayout.myHeight = 42*k_scale;
    
    /*UIImageView *rightAuthenticationImg = [[UIImageView alloc]init];
    rightAuthenticationImg.myWidth = 80*k_scale;
    rightAuthenticationImg.myHeight = 25*k_scale;
    rightAuthenticationImg.rightPos.equalTo(relativeLayout.rightPos).offset(10);
    rightAuthenticationImg.centerYPos.equalTo(relativeLayout.centerYPos);
    rightAuthenticationImg.image = [UIImage imageNamed:@"rightAuthenticationImg"];
    [relativeLayout addSubview:rightAuthenticationImg];
    */
    [flowLayout addSubview:relativeLayout];
    [rootLayout addSubview:topLinearLayout];
    [self.view addSubview:rootLayout];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-topLinearLayout.myHeight-64-49) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
    [rootLayout addSubview:self.tableview];
}
-(UILabel *)managerOrStuff:(NSString *)type{
    UILabel *lal = [[UILabel alloc]init];
    lal.myWidth = 60*k_scale;
    lal.myHeight = 14*k_scale;
    lal.myLeftMargin = 3;
//    lal.myTopMargin = 5;
    lal.textColor = [UIColor whiteColor];
    lal.font  = [UIFont systemFontOfSize:14];
//    [lal sizeToFit];
    if ([type isEqualToString:@"1"]) {
       lal.text = @"个人用户";
    }else{
        lal.text = @"公司管理员";
    }
    lal.textAlignment = NSTextAlignmentCenter;
    lal.backgroundColor = [UIColor blueColor];
    lal.layer.cornerRadius = 3;
    lal.layer.masksToBounds = YES;
    return lal;
}
-(void)pushPersonalData{
    PersonalDataViewController *vc = [[PersonalDataViewController alloc]init];
    vc.callBack = [RACSubject subject];
    [vc.callBack  subscribeNext:^(id x) {
        [self request];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)erweima{
    [[BeforeScanSingleton shareScan] ShowSelectedType:AliPayStyle WithViewController:self];
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





-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
