//
//  QianZiCodeViewController.m
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "QianZiCodeViewController.h"
#import "UserTool.h"
@interface QianZiCodeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic, strong) MyLinearLayout *contentLayout;
@property(nonatomic, strong) MyFlowLayout *flowLayout;


@property(nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UILabel *filedNumberLabel;
@property (nonatomic, strong) NSArray *pickerArr;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIView *pickerView;
@property (nonatomic, strong) NSString *chooseTag;//@“0”选中第一个cell， or @“1”选中第二个cell
@property (nonatomic, strong) MyRelativeLayout  *firstCellLayout;
@property (nonatomic, strong) MyRelativeLayout  *secondCellLayout;
@end

@implementation QianZiCodeViewController
-(void)loadView{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.view = scrollView;
    
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    contentLayout.padding = UIEdgeInsetsMake(70, 10, 10, 10); //设置布局内的子视图离自己的边距.
    contentLayout.myLeftMargin = 0;
    contentLayout.myRightMargin = 0;                          //同时指定左右边距为0表示宽度和父视图一样宽
    contentLayout.heightDime.lBound(scrollView.heightDime, 10, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    contentLayout.gravity = MyMarginGravity_Horz_Fill;
    [scrollView addSubview:contentLayout];
    self.contentLayout = contentLayout;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签字码设置";
    _firstCellLayout = [self createCellWith:@"启用纯数字" tag:100];
    _secondCellLayout = [self createCellWith:@"启用数字及字母" tag:200];
    [self.contentLayout addSubview:_firstCellLayout];
    [self.contentLayout addSubview:_secondCellLayout];
    [self.contentLayout addSubview:[self createCell3]];
    [self.contentLayout addSubview:[self createCell4]];
    self.chooseTag = @"1";
    [RACObserve(self, chooseTag) subscribeNext:^(NSString* x) {
        if ([x isEqualToString:@"0"]) {
            [self state1];
        }
        if ([x isEqualToString:@"1"]) {
            [self state2];
        }
    }];
}

-(void)state1{
   UIView *cell1DotView = [_firstCellLayout viewWithTag:100+10];
    cell1DotView.backgroundColor = [UIColor blueColor];
   UIView* cell2DotView = [_secondCellLayout viewWithTag:200+10];
    cell2DotView.backgroundColor = [UIColor whiteColor];
}

-(void)state2{
    UIView *cell1DotView = [_firstCellLayout viewWithTag:100+10];
    cell1DotView.backgroundColor = [UIColor whiteColor];
    UIView* cell2DotView = [_secondCellLayout viewWithTag:200+10];
    cell2DotView.backgroundColor = [UIColor blueColor];
}

#pragma mark -- Handle Method
-(void)deleteAlert:(UIButton*)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定删除该字符吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UIView animateWithDuration:1 animations:^{
            sender.alpha = 0;
        } completion:^(BOOL finished) {
            [sender removeFromSuperview];
        }];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)pickerFinished{
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 240);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)alert{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"规避字符" message:@"请输入规避字符或数字" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *userNameTextField = alertController.textFields.firstObject;
        
        NSLog(@"规避字符是 = %@",userNameTextField.text);
        [self handleAddTagButtonWithTitle:userNameTextField.text];
    }]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    }];
    [self presentViewController:alertController animated:true completion:nil];
}

-(void)handleAddTagButtonWithTitle:(NSString*)title{
    if (title.length>1||title.length==0) {
        [MBProgressHUD showError:@"请输入单个字母或数字"];
        return;
    }else{
        BOOL b = [UserTool deptIdInputShouldAlphaNum:title];
        if (b) {
            if([self checkAllBtnTitles:title]){
                UIButton *btn = [self createDIYTagButton:title];
                [self.flowLayout insertSubview:btn atIndex:self.flowLayout.subviews.count ];
            }
        }else{
            [MBProgressHUD showError:@"请输入单个字母或数字"];
            return;
        }
    }
}

//查重
-(BOOL)checkAllBtnTitles:(NSString*)currentTitle{
    BOOL boolValue = YES;
    NSArray * btnArr = self.flowLayout.subviews;
    for (UIButton *btn in btnArr) {
        if ([currentTitle isEqualToString:btn.titleLabel.text]) {
            boolValue = NO;
            break;
        }
    }
    return boolValue;
}


-(void)cellClicked:(UIButton*)sender{
    if (sender.tag == 100) {
        self.chooseTag = @"0";
    }else{
        self.chooseTag = @"1";
    }
}
#pragma mark - createCells
-(MyRelativeLayout *)createCellWith:(NSString *)title tag:(NSInteger)tag{
    MyRelativeLayout *cell1 = [MyRelativeLayout new];
    cell1.bottomBorderLine = [[MyBorderLineDraw alloc]initWithColor:[UIColor lightGrayColor]];
    cell1.bottomBorderLine.headIndent = 10;
    cell1.bottomBorderLine.tailIndent = 10;
    cell1.myHeight = 44;
    UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(cellClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [cell1 addSubview:btn];
    btn.myMargin = 0;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    [label sizeToFit];
    label.myLeftMargin = 10;
    label.centerYPos.equalTo(cell1.centerYPos);
    [cell1 addSubview:label];
    
    UIView *view = [[UIView alloc]init];
    view.myWidth = view.myHeight = 30;
    view.layer.cornerRadius = 15;
    view.layer.borderWidth = 1;
    view.tag = tag+10;
    view.myRightMargin = 10;
    view.centerYPos.equalTo(cell1.centerYPos);
    view.layer.borderColor = [UIColor blackColor].CGColor;
    [cell1 addSubview:view];
    return cell1;
}
-(MyFlowLayout *)createCell3{
    self.flowLayout = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:4];
    self.flowLayout.wrapContentHeight = YES;
    self.flowLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    self.flowLayout.bottomBorderLine = [[MyBorderLineDraw alloc]initWithColor:[UIColor lightGrayColor]];
    self.flowLayout.bottomBorderLine.headIndent = 10;
    self.flowLayout.bottomBorderLine.tailIndent = 10;
    self.flowLayout.subviewMargin = 10;   //流式布局里面的子视图的水平和垂直间距都设置为10
    self.flowLayout.gravity = MyMarginGravity_Horz_Fill;  //流式布局里面的子视图的宽度将平均分配。
    //    self.flowLayout.weight = 1;   //流式布局占用线性布局里面的剩余高度。
    NSArray *arr = @[@"L",@"O",@"I"];
    for (NSInteger i = 0; i < 3; i++){
        [self.flowLayout addSubview:[self createTagButton:arr[i]]];
    }
    self.addButton = [self createAddButton];
    [self.flowLayout addSubview:self.addButton];
    return self.flowLayout;
}
-(MyLinearLayout *)createCell4{
    MyLinearLayout *cell4 = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    cell4.gravity = MyMarginGravity_Vert_Center;
    cell4.myHeight = 44;
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"字段位数";
    [label sizeToFit];
    label.myLeftMargin = 10;
    label.centerYPos.equalTo(cell4.centerYPos);
    [cell4 addSubview:label];
//    [cell4 setTouchDownTarget:self action:@selector(picker)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.useFrame = YES;
    btn.frame = CGRectMake(0, 0, kScreenWidth, 44);
    [btn addTarget:self action:@selector(pickerPresent) forControlEvents:UIControlEventTouchUpInside];
    UILabel *weishu = [[UILabel alloc]init];
    weishu.text = [NSString stringWithFormat:@"%d位",4];
    [weishu sizeToFit];
    weishu.myLeftMargin = 30;
    weishu.centerYPos.equalTo(cell4.centerYPos);
    [weishu addSubview:label];
    self.filedNumberLabel = weishu;
    
    [cell4 addSubview:label];
    [cell4 addSubview:self.filedNumberLabel];
     [cell4 addSubview:btn];
    return cell4;
}

#pragma mark - creteBtn
//自定义标签按钮
-(UIButton*)createDIYTagButton:(NSString*)text
{
    UIButton *tagButton = [UIButton new];
    [tagButton setTitle:text forState:UIControlStateNormal];
    tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    tagButton.backgroundColor = [UIColor blueColor];
    tagButton.layer.cornerRadius = 2;
    tagButton.heightDime.equalTo(@44);
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 70)/4;
    tagButton.myWidth = width;
    [tagButton addTarget:self action:@selector(deleteAlert:) forControlEvents:UIControlEventTouchUpInside];
    
    return tagButton;
}
//创建添加按钮
-(UIButton*)createAddButton
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [addButton setTitle:@"自定义" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:15];
    addButton.layer.cornerRadius = 2;
        addButton.backgroundColor = [UIColor redColor];
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 70)/4;
    addButton.heightDime.equalTo(@44);
    addButton.myWidth = width;
    [addButton addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    return addButton;
}
//创建标签按钮
-(UIButton*)createTagButton:(NSString*)text
{
    UIButton *tagButton = [UIButton new];
    [tagButton setTitle:text forState:UIControlStateNormal];
    tagButton.titleLabel.font = [UIFont systemFontOfSize:14];
    tagButton.backgroundColor = [UIColor lightGrayColor];
    tagButton.layer.cornerRadius = 2;
    tagButton.enabled = NO;
    tagButton.heightDime.equalTo(@44);
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width - 70)/4;
    tagButton.myWidth = width;
//    [tagButton addTarget:self action:@selector(handleTouchUp:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    return tagButton;
    
}
#pragma mark - UIPickerViewDelegate and datasource

-(void)pickerPresent{
    [self.pickerView addSubview:self.picker];
    [self.view addSubview:self.pickerView];
    [UIView animateWithDuration:0.5 animations:^{
        self.pickerView.frame = CGRectMake(0, kScreenHeight-240, kScreenWidth, 240);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickerArr[row];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.filedNumberLabel.text = self.pickerArr[row];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerArr.count;
}

#pragma mark - lazy
-(NSArray*)pickerArr{
    if(!_pickerArr){
        _pickerArr = @[@"4",@"6",@"8",@"12"];
    }
    return _pickerArr;
}

-(UIPickerView*)picker{
    if(!_picker){
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 200)];
        _picker.delegate = self;
        _picker.dataSource = self;
        _picker.backgroundColor = RGBA(0, 0, 0, 0.4);
    }
    return _picker;
}
-(UIView*)pickerView{
    if(!_pickerView){
        _pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 240)];
//        _pickerView.layer.borderWidth = 1;
//        _pickerView.layer.borderColor = [UIColor blackColor].CGColor;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pickerFinished) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(kScreenWidth-55, 5, 50, 35);
        [_pickerView addSubview:btn];
    }
    return _pickerView;
}





































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
