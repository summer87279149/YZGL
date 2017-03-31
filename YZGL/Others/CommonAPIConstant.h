//
//  CommonAPIConstant.h
//  YZGL
//
//  Created by Admin on 17/3/25.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,SourceType){
    SourceTypeRegister,
    SourceTypeDefault,
    SourceTypePersonalToEnterprise,
};
@interface CommonAPIConstant : NSObject
UIKIT_EXTERN NSString *const NetWorkStatusChanged;
UIKIT_EXTERN NSString *const DidLoginNotification;
UIKIT_EXTERN NSString *const UserInfoChangedNotification;
UIKIT_EXTERN NSString *const OtherAddressLogin;
@end
