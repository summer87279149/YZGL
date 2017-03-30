//
//  PersonaDIYCell.h
//  YZGL
//
//  Created by Admin on 17/3/30.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalDIYCellModel.h"
@interface PersonaDIYCell : UITableViewCell
@property (nonatomic, strong) RACSubject *rightTopClickedCallBack;
@property (nonatomic, strong) RACSubject *rightBottomCallback;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UIButton *rightTop;
@property (weak, nonatomic) IBOutlet UIButton *rightBottom;
@property (nonatomic, strong) PersonalDIYCellModel *model;

@end
