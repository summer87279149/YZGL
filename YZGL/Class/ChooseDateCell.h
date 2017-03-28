//
//  ChooseDateCell.h
//  YZGL
//
//  Created by Admin on 17/3/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "ChooseDateItem.h"
typedef void(^ChooseDateBlock)(BOOL isLongTerm,NSString *date);

@interface ChooseDateCell : RETableViewCell
@property (strong, nonatomic) UILabel *lab;
@property (strong, nonatomic) UILabel *dateLab;
@property (nonatomic, assign) ChooseDateBlock callBack;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, assign) BOOL isLongTerm;
@property (strong, nonatomic) ChooseDateItem *chooseDateItem;
-(void)chooseDateTap;
@end
