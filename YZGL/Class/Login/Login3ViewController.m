//
//  Login3ViewController.m
//  YZGL
//
//  Created by Admin on 17/2/28.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "BaseNavViewController.h"
#import "UIViewController+CameraAndPhoto.h"
#import "OrderAddressViewController.h"
#import "Login3ViewController.h"

@interface Login3ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *name;
@property (nonatomic, strong) RENumberItem *idCard;
@property (nonatomic, strong) RETableViewItem *address;
@end


@implementation Login3ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyAdd:) name:@"chooseAdd" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.title = @"个人用户";
    [self setupview];
    [self addPhotoUI];

}
-(void)addPhotoUI{
    
    MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    layout.frame = CGRectMake(0, 224, kScreenWidth, 120);
    layout.myLeftMargin = 0;
    layout.myRightMargin = 0;
    
    [layout addSubview:[self createImageView:0 title:@"身份证正面照"]];
    [layout addSubview:[self createImageView:2 title:@"身份证背面"]];
    [layout addSubview:[self createImageView:2 title:@"手持身份证"]];
    [layout averageMargin:YES];
    [self.view addSubview:layout];
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
    self.xt_block = ^(NSData *data){
        UIImageView *view = (UIImageView*)sender.view;
        view.image = [UIImage imageWithData:data];
    };
    [self openImagePicker];
    
}
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //name
    self.name = [RETextItem itemWithTitle:@"真实姓名:" value:nil placeholder:nil];
    //证件号码
    self.idCard = [RENumberItem itemWithTitle:@"证件号码:" value:nil placeholder:nil];
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
