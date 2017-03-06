//
//  UploadFileViewController.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "TZImagePickerController.h"
#import "UploadFileViewController.h"

@interface UploadFileViewController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *selectedPhotos;
//@property (nonatomic, strong) NSMutableArray *selectedAssets;

@property(nonatomic, strong) MyLinearLayout *contentLayout;
@end

@implementation UploadFileViewController

-(void)loadView{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.view = scrollView;
    MyLinearLayout *contentLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    contentLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10); //设置布局内的子视图离自己的边距.
    contentLayout.myLeftMargin = 0;
    contentLayout.myRightMargin = 0;
    contentLayout.gravity = MyMarginGravity_Horz_Center;
    contentLayout.heightDime.lBound(scrollView.heightDime, 10, 1); //高度虽然是wrapContentHeight的。但是最小的高度不能低于父视图的高度加10.
    [scrollView addSubview:contentLayout];
    contentLayout.backgroundColor = [UIColor whiteColor];
    self.contentLayout = contentLayout;
    [self createSection1:contentLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传文件";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [self.selectedPhotos removeAllObjects];
}
-(void)save{
    
}

//线性布局片段1：上面编号文本，下面一个编辑框
-(void)createSection1:(MyLinearLayout*)contentLayout
{
    UIButton *btn = [[UIButton alloc]init];
    btn.myWidth = btn.myHeight = 50*k_scale;
//    btn.titleLabel.text = @"添加";
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    btn.myTopMargin = 70;
    [contentLayout addSubview:btn];
}


-(void)addPhoto{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingVideo = NO;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage *image in photos) {
            [self.selectedPhotos addObject:image];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            [self.contentLayout addSubview:imageView];
        }
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(NSMutableArray*)selectedPhotos{
    if(!_selectedPhotos){
        _selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}
-(void)dealloc{
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
