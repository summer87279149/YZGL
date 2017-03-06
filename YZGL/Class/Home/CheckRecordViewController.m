//
//  CheckRecordViewController.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "CheckRecordItemViewController.h"
#import "CheckRecordViewController.h"

@interface CheckRecordViewController ()<WMPageControllerDelegate,WMMenuViewDataSource>

@end

@implementation CheckRecordViewController

- (void)viewDidLoad {
    self.title=@"审核记录";
//    self.menuView.myTopMargin = 200;
    self.viewFrame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
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
    
}

//设置viewcontroller的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return 5;
}


//设置对应的viewcontroller
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        return [[CheckRecordItemViewController alloc ]initWithType:CheongsamBrandAll];
    }else if(index == 1 ){
        return [[CheckRecordItemViewController alloc ]initWithType:CheongsamBrandRecommand];
    }else if(index == 2 ){
        return [[CheckRecordItemViewController alloc ]initWithType:CheongsamBrandDomestic];;
    }else if(index == 3){
        
    }
    return [[CheckRecordItemViewController alloc ]initWithType:CheongsamBrandInternational];;
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
