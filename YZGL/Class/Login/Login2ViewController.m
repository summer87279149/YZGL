//
//  Login2ViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "RequestManager.h"
#import "CompanyModel.h"
#import "MapViewController.h"
#import "ChooseDateItem.h"
#import "ChooseDateCell.h"
#import "UIViewController+CameraAndPhoto.h"
#import "UIImage+Mo.h"
#import "BaseNavViewController.h"
#import "OrderAddressViewController.h"
#import "Login2ViewController.h"

@interface Login2ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) CompanyModel *companyModel;
@property (nonatomic, assign) SourceType sourceType;
@property (nonatomic, copy) NSDictionary *addressDicPara;
@property (nonatomic, strong) NSString *storeCertifyAddress;
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RENumberItem *certificate;
@property (nonatomic, strong) RETableViewItem *certifyAddress;
@property (nonatomic, strong) RETableViewItem *address;
@property (nonatomic, strong) RETextItem *companyName;
@property (nonatomic, strong) ChooseDateItem *chooseDateItem;
@end

@implementation Login2ViewController
- (instancetype)initSourceType:(SourceType)type
{
    self = [super init];
    if (self) {
        self.sourceType = type;
        self.companyModel =[[CompanyModel alloc]init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyAdd:) name:@"chooseAdd" object:nil];
    self.title = @"单位用户";
    [self setupview];
    [self addPhotoUI];
}
//完成按钮点击
-(void)completeBtnClicked{
    if([self.companyModel isSomeValueIsNil]){
        NSLog(@"有空值");
        [MBProgressHUD showError:@"信息不全! "];
        return;
    }
    //判断营业执照能不能用
    [RequestManager judgeBusinesslLicenseIsUsed:self.sourceType license:self.certificate.value success:^(id response) {
        if ([response[@"code"] intValue]==1) {
            [self auth];
        }else{
            [MBProgressHUD showError:response[@"message"]];
        }
    } error:^(id response) {
        
    }];
    
}
//上传前的认证
-(void)auth{
    [RequestManager companyFormAuth:self.sourceType license:self.certificate.value success:^(id response) {
        if ([response[@"code"]intValue]==1) {
            [self uploadForm];
        }else{
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"认证失败" message:@"是否继续保存" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self uploadForm];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } error:^(id response) {
        
    }];
}
//能用就上传表单
-(void)uploadForm{
    NSDictionary *dic;
    if (self.sourceType == SourceTypeRegister) {
        dic = @{};
    }else if(self.sourceType == SourceTypeDefault){
        dic = @{@"f":@"1"};
    }else {
        dic = @{@"f":@"1",@"comname":self.companyName.value};
    }
    NSDictionary* para  = @{@"type":@"2",@"uid":[UserModel userId],@"province":self.companyModel.provinceCode,@"city":self.companyModel.cityCode,@"area":self.companyModel.areaCode,@"address":self.companyModel.address,@"lng":self.companyModel.lng,@"lon":self.companyModel.lat,@"idcard":self.certificate.value,@"yxq":self.companyModel.validDate,@"longtime":self.companyModel.isLongTerm
                            };
    NSMutableDictionary *finalParas = [NSMutableDictionary dictionary];
    NSLog(@"看看参数:%@",finalParas);
    [finalParas addEntriesFromDictionary:dic];
    [finalParas addEntriesFromDictionary:para];
    [RequestManager companyAuthWithPara:finalParas scanImage:self.companyModel.scanImage companyImage:self.companyModel.companyImage success:^(id response) {
        NSLog(@"企业上传表单返回结果事:%@",response);
    } error:^(id response) {
        
    }];
}
#pragma mark - UI部分
-(void)addPhotoUI{
    MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    layout.frame = CGRectMake(0, 300, kScreenWidth, 120);
    layout.myLeftMargin = 0;
    layout.myRightMargin = 0;
    
    [layout addSubview:[self createImageView:2000 title:@"扫描件"]];
    [layout addSubview:[self createImageView:3000 title:@"公司外景"]];
    [layout averageMargin:YES];
    [self.view addSubview:layout];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake(60, kScreenHeight-100, kScreenWidth-120, 40);
    completeBtn.layer.cornerRadius = 10;
    completeBtn.layer.borderWidth = 1;
    completeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [completeBtn setTitle:@"完成 提交审核" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completeBtn addTarget: self action:@selector(completeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];

}

-(MyLinearLayout*)createImageView:(NSInteger)tag title:(NSString*)title{
    MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    layout.wrapContentHeight = YES;
    layout.myWidth = 100;
    layout.gravity = MyMarginGravity_Horz_Center;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.myLeftMargin = 5;
    imageView.myHeight = 100;
    imageView.tag = tag;
    imageView.myWidth = 100;
    [imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"addPic"]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    [label sizeToFit];
    [layout addSubview:imageView];
    [layout addSubview:label];
    [imageView addGestureRecognizer:tap];
    return layout;
}
-(void)tapImage:(UITapGestureRecognizer*)sender{
    UIImageView *view = (UIImageView*)sender.view;
    WS(weakSelf)
    self.xt_block = ^(NSData *data){
        view.image = [UIImage imageWithData:data];
        if (view.tag==2000) {
            weakSelf.companyModel.scanImage = view.image;
        }else{
            weakSelf.companyModel.companyImage = view.image;
        }
    };
    if (view.tag==2000) {
       [self openImagePickerWithType:XTCameraTypeHuKou];
    }else{
        [self openImagePickerWithType:XTCameraTypeA4Paper];
    }
    
}
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //证件号码
    WS(weakSelf)
    self.certificate = [RENumberItem itemWithTitle:@"证件号码:" value:nil placeholder:nil];
    self.certifyAddress = [RETableViewItem itemWithTitle:@"公司注册地:" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf pushVC];
    }];
    
    //公司地址
    self.address = [RETableViewItem itemWithTitle:@"公司地址:" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        [item deselectRowAnimated:YES];
        [weakSelf pushMapVC];
    }];
    
//    UIButton *mapIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [mapIconBtn addTarget:self action:@selector(pushMapVC) forControlEvents:UIControlEventTouchUpInside];
//    mapIconBtn.frame = CGRectMake(0, 0, 25, 25);
//    [mapIconBtn setBackgroundImage:[UIImage imageNamed:@"mapIcon.png"] forState:UIControlStateNormal];
//    self.address.accessoryView = mapIconBtn;
    //有效期
    self.manager[@"ChooseDateItem"] = @"ChooseDateCell";
    self.chooseDateItem = [ChooseDateItem itemWithImageNamed:@"das"];
    self.chooseDateItem.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.sourceType == SourceTypePersonalToEnterprise) {
        self.companyName = [RETextItem itemWithTitle:@"单位名称:" value:nil];
        [section addItem:self.companyName];
    }
    [section addItem:self.certificate];
    [section addItem:self.certifyAddress];
    [section addItem:self.chooseDateItem];
    [section addItem:self.address];
    
    ChooseDateCell*cell = [self.tableview cellForRowAtIndexPath:self.chooseDateItem.indexPath];
    cell.callBack = ^(BOOL isLongTerm,NSString *date){
        self.companyModel.validDate = date;
        if (isLongTerm) {
            self.companyModel.isLongTerm = @"2";
        }else{
            self.companyModel.isLongTerm = @"1";
        }
        NSLog(@"选择日期完成%d,%@",isLongTerm,date);
    };
    self.chooseDateItem.selectionHandler = ^(ChooseDateItem* item){
        [cell chooseDateTap];
    };
    
}
#pragma mark - notification
-(void)modifyAdd:(NSNotification *)note{
    if (note.userInfo[@"city"]==nil||note.userInfo[@"province"]==nil||note.userInfo[@"area"]==nil) {
        return;
    }else{
        self.certifyAddress.title =[NSString  stringWithFormat:@"公司注册地: %@ %@ %@",note.userInfo[@"province"],note.userInfo[@"city"],note.userInfo[@"area"]];
        self.storeCertifyAddress = [NSString stringWithFormat:@"%@%@%@",note.userInfo[@"province"],note.userInfo[@"city"],note.userInfo[@"area"]];
        self.companyModel.provinceCode = note.userInfo[@"selectedProvinceCode"];
        self.companyModel.cityCode = note.userInfo[@"selectedCityCode"];
        self.companyModel.areaCode = note.userInfo[@"selectedAreaCode"];
        [self.certifyAddress reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - pushNavigitation
-(void)pushMapVC{
    if (!self.storeCertifyAddress) {
        [MBProgressHUD showError:@"请先选择公司注册地址"];
        return;
    }
    MapViewController *vc = [[MapViewController alloc]initWithAddress:self.storeCertifyAddress];
    vc.delegate = [RACSubject subject];
    [vc.delegate subscribeNext:^(NSDictionary *dic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.addressDicPara = dic;
            NSString *lat = dic[@"lat"];
            NSString *lng = dic[@"lng"];
            self.companyModel.lat = lat;
            self.companyModel.lng = lng;
            self.address.title = [NSString stringWithFormat:@"公司地址: %@",dic[@"address"]];
            self.companyModel.address = [dic[@"address"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [self.address reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
//             NSLog(@"选择的位置经纬度事1:%@==%@==%@==%@",lat,lon,dic[@"address"],dic[@"address2"]);
        });
    }];
    vc.title=@"选择位置";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushVC{
    OrderAddressViewController *vc =[[OrderAddressViewController alloc] init];
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth, 230) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
//        _tableview.separatorColor = [UIColor blackColor];
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
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.xt_block = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
