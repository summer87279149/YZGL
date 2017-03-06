//
//  LastCellAddPhotoCell.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LastCellAddPhotoCell.h"
@interface LastCellAddPhotoCell()
//@property (strong, readwrite, nonatomic) UIImageView *pictureView;
//@property(nonatomic,strong)UIImageView *addImage;
@end
@implementation LastCellAddPhotoCell

+ (CGFloat)heightWithItem:(NSObject *)item tableViewManager:(RETableViewManager *)tableViewManager
{
    return 120;
}

- (void)cellDidLoad
{
    [super cellDidLoad];

    self.lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 30)];
    self.lab.text = @"上传印章";
    self.lab.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.lab];
    
    self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-110, 10, 100, 100)];
    self.pictureView.backgroundColor = [UIColor grayColor];
    self.pictureView.layer.cornerRadius = 3;
    [self.contentView addSubview:self.pictureView];
    self.pictureView.image = [UIImage imageNamed:@"addPic.png"];
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
//    self.addImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-110, 10, 100, 100)];
//    self.addImage.backgroundColor = [UIColor blueColor];
//    [self addSubview:self.addImage];
//    self.addImage.image = [UIImage imageNamed:@"addPic.png"];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
//    [self.pictureView setImage:[UIImage imageNamed:self.imageItem.imageName]];
}

- (void)cellDidDisappear
{
    
}


@end
