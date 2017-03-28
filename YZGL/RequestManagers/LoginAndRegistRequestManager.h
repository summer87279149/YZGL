//
//  LoginAndRegistRequestManager.h
//  YZGL
//
//  Created by Admin on 17/3/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseRequestManager.h"

@interface LoginAndRegistRequestManager : BaseRequestManager

/**
 *  登入
 *
 *  @param tel        手机号
 *  @param psw        密码
 *  @param xt_success 成功回调
 *  @param xt_error   失败回调
 */
+(void)loginWithPhoneNumber:(NSString *)tel password:(NSString *)psw success:(Success)xt_success error:(Error)xt_error;

/**
 token登入

 @param xt_success xt_success description
 @param xt_error xt_error description
 */
+(void)loginWithTokenSuccess:(Success)xt_success error:(Error)xt_error;

/**
 注册

 @param psw 密码
 @param code 验证码
 @param tel 手机号
 @param type 1:个人 2:企业
 @param xt_success xt_success description
 @param xt_error xt_error description
 */
+(void)registWith:(NSString *)userName password:(NSString *)psw smsCode:(NSString *)code tel:(NSString *)tel type:(NSInteger)type companyName:(NSString *)comname success:(Success)xt_success error:(Error)xt_error;

/**
 *  重置密码
 *
 *  @param telNumber   手机号
 *  @param newPassword 新密码
 *  @param code        验证码
 *  @param xt_success  成功回调
 *  @param xt_error    失败回调
 */
+(void)resetPasswordWith:(NSString *)telNumber password:(NSString *)newPassword smsCode:(NSString *)code success:(Success)xt_success error:(Error)xt_error;

/**
 退出登入

 @param xt_success xt_success description
 @param xt_error xt_error description
 */
+(void)logOutSuccess:(Success)xt_success error:(Error)xt_error;

/**
 发送验证码

 @param phoneNumber phoneNumber description
 */
+(void)sendVertifyCodeTel:(NSString *)phoneNumber success:(Success)xt_success error:(Error)xt_error;

/**
 公司认证

 @param para <#para description#>
 @param xt_success <#xt_success description#>
 @param xt_error <#xt_error description#>
 */
+(void)companyAuthWithPara:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error;

/**
 个人认证

 @param para <#para description#>
 @param xt_success <#xt_success description#>
 @param xt_error <#xt_error description#>
 */
+(void)personalAuthWithPara:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error;
@end
