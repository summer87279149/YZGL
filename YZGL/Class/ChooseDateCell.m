//
//  ChooseDateCell.m
//  YZGL
//
//  Created by Admin on 17/3/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ChooseDateCell.h"
#import <objc/runtime.h>
@implementation ChooseDateCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 44;
}
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.isLongTerm = NO;
    self.lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 7, 50, 30)];
    self.lab.text = @"有效期";
    self.lab.font = [UIFont systemFontOfSize:16];
    self.lab.textColor = [UIColor blackColor];
    [self.lab sizeToFit];
    [self.contentView addSubview:self.lab];
    //创建长期有效按钮
    UIView *red = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    red.layer.cornerRadius = 7;
    red.layer.borderWidth = 1;
    red.tag = 1200;
    red.backgroundColor = [UIColor whiteColor];
    UILabel*lab = [[UILabel alloc]init];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = @"长期有效";
    [lab sizeToFit];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-80, 7, 80, 30)];
    [view addSubview:red];
    [view addSubview:lab];
    [self.contentView addSubview:view];
    WS(weakSelf)
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.left.mas_equalTo(weakSelf.contentView.mas_left).offset(15);
    }];
    [red mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.mas_equalTo(view);
        make.width.height.mas_equalTo(14);
    }];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(red);
        make.left.mas_equalTo(red.mas_right);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [view addGestureRecognizer:tap];
    
    
    self.dateLab = [[UILabel alloc]init];
    self.dateLab.text = @"2017-01-01";
    self.dateLab.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.dateLab];
    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.lab.mas_right).offset(10);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(view.mas_left).offset(-10);
        make.height.mas_equalTo(weakSelf.contentView);
    }];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseDateTap)];
//    [self.contentView addGestureRecognizer:tap2];
  
}
-(void)chooseDateTap{
    UIViewController *vc = [self getCurrentViewController];
    [vc.view addSubview:self.datePicker];
    [vc.view bringSubviewToFront:self.datePicker];
    [UIView animateWithDuration:0.3 animations:^{
        _datePicker.frame = CGRectMake(0, kScreenHeight-200, kScreenWidth, 200);
        UIButton *btn = [UIButton XT_createBtnWithTitle:@"完成" TitleColor:[UIColor blackColor] TitleFont:@14 cornerRadio:nil BGColor:nil Borderline:nil BorderColor:nil target:self Method:@selector(complete:)];
        btn.frame = CGRectMake(0, kScreenHeight-230, kScreenWidth, 30);
        [vc.view addSubview:btn];
    }];
}
-(void)complete:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        _datePicker.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
    }];
    [sender removeFromSuperview];
    if (self.callBack) {
        self.callBack(self.isLongTerm,self.dateLab.text);
    }
}
-(UIDatePicker*)datePicker{
    if(!_datePicker){
        _datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,kScreenHeight,kScreenWidth,200)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.minimumDate = [NSDate date];
        _datePicker.backgroundColor = [UIColor whiteColor];
        [_datePicker addTarget:self action:@selector(choosedate:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
-(void)choosedate:(UIDatePicker *)picker{
    NSDate *date = picker.date;
    NSDateFormatter *fater = [[NSDateFormatter alloc]init];
    fater.dateFormat = @"yyyy-MM-dd";
    NSString *str = [fater stringFromDate:date];
    self.dateLab.text = str;
}

- (UIViewController*)getCurrentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
-(void)tapView:(UIGestureRecognizer *)gestureRecognizer{
   UIView*red = [gestureRecognizer.view viewWithTag:1200];
    if (red.backgroundColor == [UIColor redColor]) {
        red.backgroundColor = [UIColor whiteColor];
        self.isLongTerm = NO;
    }else{
        red.backgroundColor = [UIColor redColor];
        self.isLongTerm = YES;
    }
    if (self.callBack) {
        self.callBack(self.isLongTerm,self.dateLab.text);
    }
}
- (void)cellWillAppear
{
    [super cellWillAppear];
}

- (void)cellDidDisappear
{
    
}

@end
