//
//  CompanyNoAuthCell.m
//  YZGL
//
//  Created by Admin on 17/3/31.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CompanyNoAuthCell.h"

@implementation CompanyNoAuthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.auth.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
