//
//  UserTool.h
//  都市摇摇看
//
//  Created by admin on 15/12/4.
//  Copyright © 2015年 hackcc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserTool : NSObject
//正则判断纯数字
+ (BOOL)validateNumber:(NSString *) textString;
// 匹配手机号
+ (BOOL) isValidateMobile:(NSString *)mobile;
//2~6位中文用户名
+ (BOOL) validateNickname:(NSString *)nickname;
// 显示提示框
+ (void)alertViewDisplayTitle:(NSString *)title andMessage:(NSString *)message andDisplayValue:(double)value;
// md5加密
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
//判断仅仅是数字或者字母
+ (BOOL)deptIdInputShouldAlphaNum:(NSString *)str;
//匹配身份证
+ (BOOL)isIdentityCard:(NSString *)IDCardNumber;
@end
