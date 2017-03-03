

//
//  StaffManageTableViewCell.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "StaffManageTableViewCell.h"
@interface StaffManageTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UIImageView *managerImage;
@property (weak, nonatomic) IBOutlet UIButton *redPhoneImage;

@end

@implementation StaffManageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
