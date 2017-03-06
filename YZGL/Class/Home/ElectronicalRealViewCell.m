//
//  ElectronicalRealViewCell.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ElectronicalRealViewCell.h"
@interface ElectronicalRealViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet IBInspectable UILabel *label;

@end
@implementation ElectronicalRealViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _label.layer.cornerRadius = 2;
    _label.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
