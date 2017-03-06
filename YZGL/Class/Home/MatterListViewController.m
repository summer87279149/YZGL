//
//  MatterListViewController.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "MatterListItemViewController.h"
#import "MatterListViewController.h"

@interface MatterListViewController ()<WMPageControllerDelegate,WMMenuViewDataSource>
@property (nonatomic, strong) UISegmentedControl *segment;

@end

@implementation MatterListViewController

- (void)viewDidLoad {
    self.title=@"事项列表";
    //    self.menuView.myTopMargin = 200;
    self.viewFrame = CGRectMake(0, 64+50, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50-64);
    self.menuHeight = 44; //导航栏高度
    self.menuItemWidth = 70; //每个 MenuItem 的宽度
    self.menuBGColor = [UIColor whiteColor];
    self.menuViewStyle = 1;//这里设置菜单view的样式
    self.progressHeight = 4;//下划线的高度，需要WMMenuViewStyleLine样式
    self.progressColor = [UIColor redColor];//设置下划线(或者边框)颜色
    self.titleSizeSelected = 18;//设置选中文字大小
    self.titleColorSelected = [UIColor redColor];//设置选中文字颜色
    self.titleSizeNormal = 14;
    self.selectIndex = 1;
    [super viewDidLoad];//这里注意，需要写在最后面，要不然上面的效果不会出现}
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"创建" style:UIBarButtonItemStylePlain target:self action:@selector(create:)];
    [self createSegment];
}

-(void)create:(UIBarButtonItem*)item{
    
}

-(void)createSegment{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"全部",@"我审核的",@"我提交的"]];
    //        [_topSwitch setTitle:@"证件原件" forSegmentAtIndex:0];
    //        [_topSwitch setTitle:@"防伪原件" forSegmentAtIndex:1];
    [self.segment setTintColor:[UIColor blackColor]];
    self.segment.selectedSegmentIndex = 0;
    [self.segment addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segment.layer.cornerRadius = 4;
    [self.view addSubview:self.segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view).offset(-40);
        make.top.mas_equalTo(self.view).offset(74);
        make.left.mas_equalTo(self.view).offset(20);
    }];

}
-(void)valueChanged:(UISegmentedControl*)sender{
    switch (sender.selectedSegmentIndex ) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
   
}
//设置viewcontroller的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 5;
}


//设置对应的viewcontroller
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        return [[MatterListItemViewController alloc ]initWithType:CMatterListItemAll];
    }else if(index == 1 ){
        return [[MatterListItemViewController alloc ]initWithType:MatterListItemWait];
    }else if(index == 2 ){
        return [[MatterListItemViewController alloc ]initWithType:MatterListItemAgree];;
    }else if(index == 3){
        
    }
    return [[MatterListItemViewController alloc ]initWithType:MatterListItemRefuse];
}
//设置每个viewcontroller的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    if (index == 0) {
        return @"全部";
    }else if (index ==1 ){
        return @"未处理";
    }else if (index == 2){
        return @"已确认";
    }else if(index == 3){
        return @"已拒绝";
    }
    return @"待复传";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
