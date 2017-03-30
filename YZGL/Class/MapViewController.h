//
//  MapViewController.h
//  YZGL
//
//  Created by Admin on 17/3/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseViewController.h"

@interface MapViewController : BaseViewController
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) RACSubject *delegate;
- (instancetype)initWithAddress:(NSString *)addStr;
@end
