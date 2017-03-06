//
//  HoldPeopleTableViewController.h
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^selectedCallBack)(NSInteger row);

@interface HoldPeopleTableViewController : BaseViewController
@property (nonatomic, copy) NSMutableArray *cellArr;
@property (nonatomic, copy) selectedCallBack callBack;

@end
