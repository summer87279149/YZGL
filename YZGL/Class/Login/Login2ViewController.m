//
//  Login2ViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "MapViewController.h"
#import "ChooseDateItem.h"
#import "ChooseDateCell.h"
#import "UIViewController+CameraAndPhoto.h"
#import "UIImage+Mo.h"
#import "BaseNavViewController.h"
#import "OrderAddressViewController.h"
#import "Login2ViewController.h"

@interface Login2ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RENumberItem *certificate;
@property (nonatomic, strong) RETableViewItem *certifyAddress;
@property (nonatomic, strong) RETextItem *address;

@property (nonatomic, strong) ChooseDateItem *chooseDateItem;
@end

@implementation Login2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyAdd:) name:@"chooseAdd" object:nil];
    self.title = @"单位用户";
    [self setupview];
    [self addPhotoUI];
}
-(void)completeBtnClicked{
    
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
    self.xt_block = ^(NSData *data){
        view.image = [UIImage imageWithData:data];
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
    self.certificate = [RENumberItem itemWithTitle:@"证件号码:" value:nil placeholder:nil];
    @weakify(self);
    self.certifyAddress = [RETableViewItem itemWithTitle:@"公司注册地:" accessoryType:UITableViewCellAccessoryDisclosureIndicator selectionHandler:^(RETableViewItem *item) {
        @strongify(self);
        [item deselectRowAnimated:YES];
        [self pushVC];
    }];
    
    //公司地址
    self.address = [RETextItem itemWithTitle:@"公司地址:" value:nil placeholder:nil];
    UIButton *mapIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapIconBtn addTarget:self action:@selector(pushMapVC) forControlEvents:UIControlEventTouchUpInside];
    mapIconBtn.frame = CGRectMake(0, 0, 25, 25);
    [mapIconBtn setBackgroundImage:[UIImage imageNamed:@"mapIcon.png"] forState:UIControlStateNormal];
    self.address.accessoryView = mapIconBtn;
    //有效期
    self.manager[@"ChooseDateItem"] = @"ChooseDateCell";
    self.chooseDateItem = [ChooseDateItem itemWithImageNamed:@"das"];
    self.chooseDateItem.selectionStyle = UITableViewCellSelectionStyleNone;
  
    [section addItem:self.certificate];
    [section addItem:self.certifyAddress];
    [section addItem:self.chooseDateItem];
    [section addItem:self.address];
    
    ChooseDateCell*cell = [self.tableview cellForRowAtIndexPath:self.chooseDateItem.indexPath];
    cell.callBack = ^(BOOL isLongTerm,NSString *date){
        NSLog(@"选择日期完成%d,%@",isLongTerm,date);
    };
    self.chooseDateItem.selectionHandler = ^(ChooseDateItem* item){
        [cell chooseDateTap];
    };
}
-(void)pushMapVC{
    MapViewController *vc = [[MapViewController alloc]init];
    vc.title=@"选择位置";
    [self.navigationController pushViewController:vc animated:YES];
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
//        NSLog(@"citycode:%@，provinceCode:%@,areaCode:%@",note.userInfo[@"selectedCityCode"],note.userInfo[@"selectedProvinceCode"],note.userInfo[@"selectedAreaCode"]);
        self.certifyAddress.title =[NSString  stringWithFormat:@"公司注册地: %@ %@ %@",note.userInfo[@"province"],note.userInfo[@"city"],note.userInfo[@"area"]];
        [self.certifyAddress reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }
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
