//
//  PersonalAlreadyAuthCell.m
//  YZGL
//
//  Created by Admin on 17/3/31.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "PersonalAlreadyAuthCell.h"

@implementation PersonalAlreadyAuthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.upgradeBtn.layer.cornerRadius = 4;
    self.personalAuthBtn.layer.cornerRadius = 4;
}
- (IBAction)upgrade:(UIButton *)sender {
    if (self.changeBtnClicked) {
        self.changeBtnClicked();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
