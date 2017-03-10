//
//  AddCertifateViewController.m
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UIViewController+CameraAndPhoto.h"
#import "AddCertifateViewController.h"
typedef NS_ENUM(NSInteger,PhotoPicker) {
    PhotoPickerBtn1,
    PhotoPickerBtn2,
};
@interface AddCertifateViewController ()
@property (nonatomic, strong) MyLinearLayout*layot1;
@property (nonatomic, strong) MyLinearLayout*layot2;
@property (nonatomic, assign) PhotoPicker photoPicker;
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
    _layot1 =[self createImageView:0 title:str1];
    _layot2 =[self createImageView:2 title:str2];
    [layout addSubview:_layot1];
    [layout addSubview:_layot2];
    [layout averageMargin:YES];
    [self.view addSubview:layout];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn addTarget: self action:@selector(layot1BtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_layot1);
    }];
    
    UIButton *layot2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [layot2Btn addTarget: self action:@selector(layot2BtnBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:layot2Btn];
    [layot2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_layot2);
    }];
}

-(MyLinearLayout*)createImageView:(NSInteger)tag title:(NSString*)title{
    MyLinearLayout *layout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    layout.wrapContentHeight = YES;
    layout.myWidth = 100;
    layout.gravity = MyMarginGravity_Horz_Center;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.myLeftMargin = 5;
    imageView.myHeight = 100;
    imageView.tag = tag+1000;
    imageView.myWidth = 100;
    [imageView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"addPic"]];

    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    [label sizeToFit];
    [layout addSubview:imageView];
    [layout addSubview:label];
    return layout;
}
-(void)tapImage{
    
}


-(void)layot1BtnClicked{
    self.photoPicker = PhotoPickerBtn1;
    WS(weakSelf)
    UIImageView *view = [_layot1 viewWithTag:1000];
    if (weakSelf.photoPicker == PhotoPickerBtn1) {
        weakSelf.xt_block = ^(NSData *data){
            view.image = [UIImage imageWithData:data];
        };
    }
    switch (self.certifateType) {
        case CertifateTypeIDCard:
            [self openImagePickerWithType:XTCameraTypeIdCard];
            break;
        case CertifateTypeHuKouBu:
            [self openImagePickerWithType:XTCameraTypeHuKou];
            break;
        case CertifateTypeDIY:
            [self openImagePickerWithType:XTCameraTypeA4Paper];
            break;
        default:
            break;
    }
    
}
-(void)layot2BtnBtnClicked{
    self.photoPicker = PhotoPickerBtn2;
    UIImageView *view = [_layot2 viewWithTag:1002];
    WS(weakSelf)
    self.xt_block = ^(NSData *data){
        if (weakSelf.photoPicker == PhotoPickerBtn2) {
            view.image = [UIImage imageWithData:data];
        }
    };
    switch (self.certifateType) {
        case CertifateTypeIDCard:
            [self openImagePickerWithType:XTCameraTypeIdCard];
            break;
        case CertifateTypeHuKouBu:
            [self openImagePickerWithType:XTCameraTypeHuKou];
            break;
        case CertifateTypeDIY:
            [self openImagePickerWithType:XTCameraTypeA4Paper];
            break;
        default:
            break;
    }
}

















































































































































-(void)dealloc{
    self.xt_block = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
