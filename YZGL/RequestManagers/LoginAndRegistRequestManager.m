//
//  LoginAndRegistRequestManager.m
//  YZGL
//
//  Created by Admin on 17/3/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LoginAndRegistRequestManager.h"
#import "XTRequestManager.h"
@implementation LoginAndRegistRequestManager

+(void)loginWithPhoneNumber:(NSString *)tel password:(NSString *)psw success:(Success)xt_success error:(Error)xt_error{
    NSDictionary *para = @{@"username":tel,@"password":psw};
    [XTRequestManager GET:XT_REQUEST_URL(@"dologin") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}

+(void)loginWithTokenSuccess:(Success)xt_success error:(Error)xt_error{
    NSString *token = [UserModel userToken];
    NSDictionary *para = @{@"token":token};
    [XTRequestManager GET:XT_REQUEST_URL(@"login") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}

+(void)resetPasswordWith:(NSString *)telNumber password:(NSString *)newPassword smsCode:(NSString *)code success:(Success)xt_success error:(Error)xt_error{
    NSDictionary *para = @{@"tel":telNumber,@"password":newPassword,@"yzm":code};
    NSLog(@"修改密码参数:%@",para);
    [XTRequestManager POST:XT_REQUEST_URL(@"resetPwd") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)logOutSuccess:(Success)xt_success error:(Error)xt_error{
    NSString *token = [UserModel userToken];
    NSDictionary *para = @{@"token":token};
    [XTRequestManager GET:XT_REQUEST_URL(@"logout") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)registWith:(NSString *)userName password:(NSString *)psw smsCode:(NSString *)code tel:(NSString *)tel type:(NSInteger)type companyName:(NSString *)comname success:(Success)xt_success error:(Error)xt_error{
    NSNumber *typeNum = [NSNumber numberWithInteger:type+1];
    NSDictionary *para;
    if ([typeNum  isEqual: @2]) {
        para = @{@"type":typeNum,@"username":userName,@"password":psw,@"tel":tel,@"yzm":code,@"comname":comname};
    }else{
        para = @{@"type":typeNum,@"username":userName,@"password":psw,@"tel":tel,@"yzm":code};
    }
    [XTRequestManager POST:XT_REQUEST_URL(@"saveRegInfo") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject){
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}

/**
 验证码

 */
+(void)sendVertifyCodeTel:(NSString *)phoneNumber success:(Success)xt_success error:(Error)xt_error{
    NSDictionary *para = @{@"mobile":phoneNumber,@"type":@"10"};
    [XTRequestManager GET:XT_REQUEST_URL(@"sendYzm") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)companyAuthWithPara:(NSDictionary*)para success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager POST:XT_REQUEST_URL(@"uploadRegInfo") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)personalAuthWithPara:(NSDictionary *)para success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager POST:XT_REQUEST_URL(@"uploadRegInfo") parameters:para responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
@end
