//
//  SealManagerCell.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "SealManagerCell.h"
@interface SealManagerCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tongYiBianMa;
@property (weak, nonatomic) IBOutlet UILabel *qiYongShiJian;
@property (weak, nonatomic) IBOutlet UILabel *chiZhangRen;
@property (weak, nonatomic) IBOutlet UILabel *shengYu;
@property (weak, nonatomic) IBOutlet UILabel *yiZuoFei;

@property (weak, nonatomic) IBOutlet UIButton *shenQingShiYong;
@property (weak, nonatomic) IBOutlet UIButton *piLiangShenQing;

@end

@implementation SealManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.shenQingShiYong.layer.cornerRadius = 2;
    self.piLiangShenQing.layer.cornerRadius = 2;
    self.yiZuoFei.layer.cornerRadius = 9;






}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
