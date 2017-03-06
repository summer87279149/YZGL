//
//  MatterListItemCell.m
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "MatterListItemCell.h"

@interface MatterListItemCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *peopleName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *checkManName;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end

@implementation MatterListItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _hintLabel.layer.cornerRadius = 3;
    _hintLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
