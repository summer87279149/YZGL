//
//  Login2ViewController.h
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SourceType){
    SourceTypeRegister,
    SourceTypeDefault,
    SourceTypePersonalToEnterprise,
};
@interface Login2ViewController : UIViewController
- (instancetype)initSourceType:(SourceType)type;
@end
