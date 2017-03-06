//
//  TrueAndFalseQueryViewController.m
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "TrueAndFalseQueryViewController.h"

@interface TrueAndFalseQueryViewController ()

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;
@end

@implementation TrueAndFalseQueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"签字码查询";
    [self setupUI];
}
-(void)complete{
    
}
-(UITextField*)createTextfield:(NSString *)str title:(NSString *)title{
    UILabel *lab = [[ UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    lab.text = title;
    [lab sizeToFit];
    [self.view addSubview:lab];
    UITextField* tex = [[UITextField alloc]init];
//    tex.backgroundColor = [UIColor whiteColor];
    tex.layer.cornerRadius = 3;
    
//    tex.layer.borderWidth = 1;
    tex.placeholder = str;
    tex.myHeight = 30*k_scale;
    tex.myLeftMargin = tex.myRightMargin = 25*k_scale;
    tex.leftViewMode=UITextFieldViewModeAlways;
    tex.leftView = lab;
    return tex;
}
-(void)setupUI{
    MyLinearLayout *vertyLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    vertyLayout.frame = CGRectMake(0, 70, kScreenWidth, kScreenHeight);
    vertyLayout.subviewMargin = 20;
    [self.view addSubview:vertyLayout];
    
    _textField1 = [self createTextfield:@"输入查询名称/编号" title:@"名称/编号 "];
    _textField2 = [self createTextfield:@"输入查询签字码" title:@"签字码  "];
    //横向2个
    MyLinearLayout *horzLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    horzLayout.frame = CGRectMake(0, 70, kScreenWidth, 40*k_scale);
    horzLayout.gravity = MyMarginGravity_Vert_Center;
    _textField3 = [self createTextfield:@"输入验证码" title:@"验证码  "];
    _textField3.myWidth = kScreenWidth - 165*k_scale;
    _textField3.myRightMargin = 10;
    [horzLayout addSubview:_textField3];
    UIView *vertifyCode = [[UIView alloc]init];
    vertifyCode.backgroundColor = [UIColor redColor];
    vertifyCode.myWidth = 135;
    vertifyCode.myHeight = 35;
    [horzLayout addSubview:vertifyCode];
    //shu xiang 3 个
    [vertyLayout addSubview:_textField1];
    [vertyLayout addSubview:_textField2];
    [vertyLayout addSubview:horzLayout];
    UIButton *btn = [UIButton XT_createBtnWithTitle:@"完成" TitleColor:[UIColor blackColor] TitleFont:nil cornerRadio:@4 BGColor:nil Borderline:@1 BorderColor:[UIColor blackColor] target:self Method:@selector(complete)];
    btn.myWidth = kScreenWidth - 100*k_scale;
    btn.myLeftMargin = 50*k_scale;
    btn.myHeight = 30*k_scale;
    
    [vertyLayout addSubview:btn];

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
