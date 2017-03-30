//
//  PersonaDIYCell.m
//  YZGL
//
//  Created by Admin on 17/3/30.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "PersonaDIYCell.h"

@implementation PersonaDIYCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rightTop.layer.cornerRadius = 4;
    self.rightBottom.layer.cornerRadius = 4;
    
}
- (IBAction)rightTopClicked:(UIButton *)sender {
    if (self.rightTopClickedCallBack) {
        [self.rightTopClickedCallBack sendNext:self];
    }
}
　
- (IBAction)rightBottomClicked:(UIButton *)sender {
    if (self.rightBottomCallback) {
        [self.rightBottomCallback sendNext:self];
    }
}

-(void)setModel:(PersonalDIYCellModel *)model{
    _model = model;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
