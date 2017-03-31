//
//  PersonalNoAuthCell.m
//  YZGL
//
//  Created by Admin on 17/3/31.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "PersonalNoAuthCell.h"

@implementation PersonalNoAuthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)changeToCpmpanyUser:(UIButton *)sender {
    if (self.changeBtnClicked) {
        self.changeBtnClicked();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
