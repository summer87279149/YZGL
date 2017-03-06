//
//  AddSealViewController.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "HoldPeopleTableViewController.h"
#import "UIViewController+CameraAndPhoto.h"
#import "LastCellAddPhotoCell.h"
#import "LastCellItem.h"
#import "RETableViewOptionsController.h"
#import "AddSealViewController.h"

@interface AddSealViewController ()<UITableViewDelegate,RETableViewManagerDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) RETableViewManager *manager;
@property (nonatomic, strong) NSArray *arr;

@property (nonatomic, strong) RETextItem *name;
@property (nonatomic, strong) RETextItem *code;
@property (nonatomic, strong) REDateTimeItem *time;
@property (nonatomic, strong) RERadioItem *holdPeople;

@property (strong, readwrite, nonatomic) RERadioItem *state;
@property (nonatomic, strong) LastCellItem *addPhotoItem;
@property (nonatomic, strong) UIButton *completeBtn;

@end

@implementation AddSealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加人员";
    [self setupview];
}
-(void)setupview{
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableview];
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Test"];
    section.headerHeight = 0;
    [self.manager addSection:section];
    //名称
    self.name = [RETextItem itemWithTitle:@"印章名称" value:nil placeholder:@"印章名称"];
    self.code = [RETextItem itemWithTitle:@"统一编码" value:nil placeholder:@"统一编码"];
    self.time = [REDateTimeItem itemWithTitle:@"启用时间:" value:[NSDate date] placeholder:nil format:@"MM/dd/yyyy " datePickerMode:UIDatePickerModeDate];
    self.time.accessoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.time.accessoryType = UITableViewCellAccessoryDetailButton;
    self.time.onChange = ^(REDateTimeItem *item){
        NSLog(@"选择时间: %@", item.value.description);
    };
    self.holdPeople = [RERadioItem itemWithTitle:@"持章人" value:@"张三" selectionHandler:^(RERadioItem *item) {
        HoldPeopleTableViewController *vc = [[HoldPeopleTableViewController alloc]init];
        vc.callBack = ^(NSInteger row){
            NSLog(@"row是:%ld",(long)row);
        };
        [self.navigationController pushViewController:vc animated:YES];
    }];

    //印章状态
    WS(weakSelf)
    self.state = [RERadioItem itemWithTitle:@"印章状态" value:@"使用中" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:weakSelf.arr multipleChoice:NO completionHandler:^(RETableViewItem *selectedItem){
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
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
        [self openImagePicker];
    };
 
    [section addItem:self.name];
    [section addItem:self.code];
    [section addItem:self.time];
    [section addItem:self.holdPeople];
    [section addItem:self.state];
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



-(NSArray*)arr{
    if(!_arr){
        _arr = @[@"使用中", @"作废"];
    }
    return _arr;
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
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kScreenWidth,400) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.tableFooterView = [UIView new];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
