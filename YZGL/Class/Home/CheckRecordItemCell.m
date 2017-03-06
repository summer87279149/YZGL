//
//  CheckRecordItemCell.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CheckRecordItemCell.h"
@interface CheckRecordItemCell()
@property (weak, nonatomic) IBOutlet UILabel *shenQingGaiYao;
@property (weak, nonatomic) IBOutlet UILabel *shenQingShuLiang;
@property (weak, nonatomic) IBOutlet UILabel *yongTu;
@property (weak, nonatomic) IBOutlet UILabel *shenQingRen;
@property (weak, nonatomic) IBOutlet UILabel *shenPiRen;

@property (weak, nonatomic) IBOutlet UILabel *shiJian;
@property (weak, nonatomic) IBOutlet UILabel *weiChuLi;
@end

@implementation CheckRecordItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.weiChuLi.layer.cornerRadius = 11;
    self.weiChuLi.layer.masksToBounds = YES;
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
