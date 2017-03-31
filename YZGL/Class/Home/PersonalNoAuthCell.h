//
//  PersonalNoAuthCell.h
//  YZGL
//
//  Created by Admin on 17/3/31.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ChangeBtnClicked)();

@interface PersonalNoAuthCell : UITableViewCell
@property (nonatomic, copy) ChangeBtnClicked changeBtnClicked;
@property (weak, nonatomic) IBOutlet UIButton *upgradeBtn;



@end
