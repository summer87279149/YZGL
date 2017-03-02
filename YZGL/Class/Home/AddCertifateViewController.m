//
//  AddCertifateViewController.m
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UIViewController+CameraAndPhoto.h"
#import "AddCertifateViewController.h"

@interface AddCertifateViewController ()

@end

@implementation AddCertifateViewController
- (instancetype)initWithCertifateType:(CertifateType)certifateType
{
    self = [super init];
    if (self) {
        self.certifateType = certifateType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"证件录入";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self addPhotoUI];
}

-(void)save{
    
}

#pragma mark - UI部分
-(void)addPhotoUI{
    
    MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    layout.gravity = MyMarginGravity_Horz_Center;
    layout.wrapContentHeight = YES;
    layout.myTopMargin = 70;
    layout.myLeftMargin = 0;
    layout.myRightMargin = 0;
    layout.subviewMargin = 20;
    NSString *str1; NSString *str2;
    switch (self.certifateType) {
        case CertifateTypeIDCard:
        {
            str1 = @"身份证正面";
            str2 = @"身份证反面";
        }
            break;
        case CertifateTypeHuKouBu:{
            str1 = @"户口簿正面";
            str2 = @"户口簿反面";
        }
            break;
        case CertifateTypeDIY:{
            str1 = @"选择添加";
            str2 = @"选择添加";
        }
            break;
        default:
            break;
    }
    
    [layout addSubview:[self createImageView:0 title:str1]];
    [layout addSubview:[self createImageView:2 title:str2]];
    [layout averageMargin:YES];
    [self.view addSubview:layout];
    /*
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.frame = CGRectMake(60, kScreenHeight-100, kScreenWidth-120, 40);
    completeBtn.layer.cornerRadius = 10;
    completeBtn.layer.borderWidth = 1;
    completeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [completeBtn setTitle:@"完成 提交审核" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completeBtn addTarget: self action:@selector(completeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];*/
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

-(void)completeBtnClicked{
    
}


















































































































































-(void)dealloc{
    self.xt_block = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
