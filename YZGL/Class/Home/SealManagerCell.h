//
//  SealManagerCell.h
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SealManagerCell : UITableViewCell

@property (nonatomic, strong) RACSubject *shenQingShiYongClicked;
@property (nonatomic, strong) RACSubject *piLiangShenQingClicked;

@end
