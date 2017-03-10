//
//  AddElectronicalRealViewController.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "HoldPeopleTableViewController.h"
#import "LastCellAddPhotoCell.h"
#import "RETableViewOptionsController.h"
#import "UIViewController+CameraAndPhoto.h"
#import "AddElectronicalRealViewController.h"
#import "LastCellItem.h"
@interface AddElectronicalRealViewController ()
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) RETextItem *name;
@property (nonatomic, strong) RETextItem *code;

@property (nonatomic, strong) LastCellItem *addPhotoItem;
@property (nonatomic, strong) UIButton *completeBtn;

@property (nonatomic, strong) NSArray *arr;

@end

@implementation AddElectronicalRealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加印章";
    [self setupview];
}
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //名称
    self.name = [RETextItem itemWithTitle:@"印章名称" value:nil placeholder:@"印章名称"];
    self.code = [RETextItem itemWithTitle:@"备案号" value:nil placeholder:@"印章备案号"];
    
    
    self.manager[@"LastCellItem"] = @"LastCellAddPhotoCell";
    _addPhotoItem = [LastCellItem itemWithImageNamed:@"addPic.png"];
    _addPhotoItem.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(self)
    _addPhotoItem.selectionHandler = ^(LastCellItem* item){
        @strongify(self)
        LastCellAddPhotoCell*cell = [self.tableview cellForRowAtIndexPath:item.indexPath];
        self.xt_block = ^(NSData *data){
            cell.pictureView.image = [UIImage imageWithData:data];
        };
        [self openImagePickerWithType:XTCameraTypeSeal];
    };
    
    [section addItem:self.name];
    [section addItem:self.code];
    [section addItem:_addPhotoItem];
    [self.view addSubview:self.completeBtn];
    self.completeBtn.frame = CGRectMake(20, CGRectGetMaxY(self.tableview.frame), kScreenWidth-40, 40);
    self.completeBtn.layer.cornerRadius = 3;
}
-(void)completeClicked{
    
}
-(void)dealloc{
    self.xt_block = nil;
}



-(UIButton*)completeBtn{
    if(!_completeBtn){
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.backgroundColor = [UIColor jk_colorWithHexString:@"#dd534c"];
        [_completeBtn setTitle:@"确认添加" forState:UIControlStateNormal];
        [_completeBtn addTarget:self action:@selector(completeClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
}
#pragma mark - tableview
-(UITableView*)tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth,250) style:UITableViewStylePlain];
        _tableview.tableFooterView = [UIView new];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
