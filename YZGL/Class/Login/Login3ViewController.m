//
//  Login3ViewController.m
//  YZGL
//
//  Created by Admin on 17/2/28.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "RequestManager.h"
#import "BaseNavViewController.h"
#import "UIViewController+CameraAndPhoto.h"
#import "OrderAddressViewController.h"
#import "Login3ViewController.h"

@interface Login3ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSString *provinceCode;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, strong) UIImage *frontImg;
@property (nonatomic, strong) UIImage *backImg;
@property (nonatomic, strong) UIImage *holdIDCardImg;



@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, assign) SourceType sourceType;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *name;
@property (nonatomic, strong) RENumberItem *idCard;
@property (nonatomic, strong) RETableViewItem *address;
@end


@implementation Login3ViewController
- (instancetype)initSourceType:(SourceType)type
{
    self = [super init];
    if (self) {
        self.sourceType = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyAdd:) name:@"chooseAdd" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.title = @"个人用户";
    [self setupview];
    [self addPhotoUI];
    

}

-(void)completeBtnClicked{
//    if(![UserTool validateNickname:self.name.value]){
//        [MBProgressHUD showError:@"请输入2～6位中文姓名"];
//        return;
//    }
//    if (![UserTool isIdentityCard:self.idCard.value]) {
//        [MBProgressHUD showError:@"请输入正确的身份号"];
//        return;
//    }
    [RequestManager judgeIDCardIsUsed:self.sourceType license:self.idCard.value success:^(id response) {
        [self auth];
    } error:^(id response) {
        
    }];
}
//上传前的认证
-(void)auth{
    [RequestManager personalFormAuth:self.sourceType name:self.name.value idcard:self.idCard.value success:^(id response) {
        NSLog(@"上传前的个人认证:%@",response);
        if ([[response[@"data"]objectForKey:@"error_code"]  intValue]==0  && [[[response[@"data"]objectForKey:@"result"]objectForKey:@"res" ]  intValue]==01) {
            [self uploadInfo];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"认证失败" message:[response[@"data"]objectForKey:@"reason"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self uploadInfo];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } error:^(id response) {
        
    }];
}
//个人上传
-(void)uploadInfo{
    NSDictionary *dic;
    if (self.sourceType == SourceTypeRegister) {
        dic = @{};
    }else {
        dic = @{@"f":@"1"};
    }
    NSDictionary* para  = @{@"type":@"1",@"uid":[UserModel userId],@"province":self.provinceCode,@"city":self.cityCode,@"area":self.areaCode,@"relname":self.name.value,@"idcard":self.idCard.value};
    NSMutableDictionary *finalParas = [NSMutableDictionary dictionary];
    NSLog(@"看看参数:%@",finalParas);
    [finalParas addEntriesFromDictionary:dic];
    [finalParas addEntriesFromDictionary:para];
        [RequestManager personalAuthWithPara:finalParas frontImg:self.frontImg backImg:self.backImg holdImg:self.holdIDCardImg success:^(id response) {
            NSLog(@"个人上传表单返回结果事:%@",response);
        } error:^(id response) {
            
        }];
}
-(void)addPhotoUI{
    
    MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    layout.frame = CGRectMake(0, 224, kScreenWidth, 120);
    layout.myLeftMargin = 0;
    layout.myRightMargin = 0;
    
    [layout addSubview:[self createImageView:1110 title:@"身份证正面照"]];
    [layout addSubview:[self createImageView:1111 title:@"身份证背面"]];
    [layout addSubview:[self createImageView:1112 title:@"手持身份证"]];
    [layout averageMargin:YES];
    [self.view addSubview:layout];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake(60, kScreenHeight-100, kScreenWidth-120, 40);
    completeBtn.layer.cornerRadius = 10;
    completeBtn.layer.borderWidth = 1;
    completeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [completeBtn setTitle:@"完成 提交审核" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [completeBtn addTarget: self action:@selector(completeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];
    RAC(completeBtn,enabled) = [RACSignal combineLatest:@[RACObserve(self.name, value),RACObserve(self.idCard, value),RACObserve(self, frontImg),RACObserve(self, backImg),RACObserve(self, holdIDCardImg)] reduce:^(NSString *nameStr, NSString *idStr,UIImage *img1,UIImage*img2,UIImage*img3){
        if([UserTool validateNickname:nameStr]&&[UserTool isIdentityCard:idStr]&&img1&&img2&&img3){
            return @1;
        }else{
            return @0;
        }
    }];
    
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
    WS(weakSelf)
    self.xt_block = ^(NSData *data){
        UIImageView *view = (UIImageView*)sender.view;
        view.image = [UIImage imageWithData:data];
        switch (view.tag) {
            case 1110:
                weakSelf.frontImg = view.image;
                [weakSelf openImagePickerWithType:XTCameraTypeIdCard];
                break;
            case 1111:
                weakSelf.backImg = view.image;
                [weakSelf openImagePickerWithType:XTCameraTypeIdCard];
                break;
            case 1112:
                weakSelf.holdIDCardImg = view.image;
                [weakSelf openImagePickerWithType:XTCameraTypeSeal];
                break;
            default:
                break;
        }
    };
}
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //name
    self.name = [RETextItem itemWithTitle:@"真实姓名:" value:nil placeholder:@"2～6位中文"];
    //证件号码
    self.idCard = [RENumberItem itemWithTitle:@"证件号码:" value:nil placeholder:@"请输入正确的身份证号"];
    //所属地区
    @weakify(self);
    self.address = [RETableViewItem itemWithTitle:@"所属地区:" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        @strongify(self);
        [item deselectRowAnimated:YES];
        [self pushVC];
    }];
   
    [section addItem:self.name];
    [section addItem:self.idCard];
    [section addItem:self.address];
    
}
-(void)pushVC{
    OrderAddressViewController *vc =[[OrderAddressViewController alloc] init];
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}
-(void)modifyAdd:(NSNotification *)note{
    if (note.userInfo[@"city"]==nil||note.userInfo[@"province"]==nil||note.userInfo[@"area"]==nil) {
        return;
    }else{
        self.address.title =[NSString  stringWithFormat:@"所属地区 : %@ %@ %@",note.userInfo[@"province"],note.userInfo[@"city"],note.userInfo[@"area"]];
        self.provinceCode = note.userInfo[@"selectedProvinceCode"];
        self.cityCode = note.userInfo[@"selectedCityCode"];
        self.areaCode = note.userInfo[@"selectedAreaCode"];
        [self.address reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.xt_block = nil;
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth, 180) style:UITableViewStylePlain];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
//        _tableview.separatorColor = [UIColor blackColor];
//        _tableview.scrollEnabled = NO;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
