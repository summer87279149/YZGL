//
//  PersonalAlreadyAuthCell.h
//  YZGL
//
//  Created by Admin on 17/3/31.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangeClicked)();
@interface PersonalAlreadyAuthCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *personalAuthBtn;
@property (weak, nonatomic) IBOutlet UIButton *upgradeBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, copy) ChangeClicked changeBtnClicked;
@property (weak, nonatomic) IBOutlet UILabel *number;
@end
