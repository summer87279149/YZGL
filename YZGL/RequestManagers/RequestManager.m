//
//  RequestManager.m
//  YZGL
//
//  Created by Admin on 17/3/30.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "RequestManager.h"
#import "XTRequestManager.h"
@implementation RequestManager

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
+(void)companyAuthWithPara:(NSDictionary*)para scanImage:(UIImage *)image1 companyImage:(UIImage *)image2 success:(Success)xt_success error:(Error)xt_error{
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
    NSString *fileName2 = [NSString stringWithFormat:@"%@2.jpg",str];
    [XTRequestManager POST:XT_REQUEST_URL(@"uploadRegInfo") parameters:para responseSeializerType:NHResponseSeializerTypeDefault constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(image1, 1);
        [formData appendPartWithFileData:data name:@"file1" fileName:fileName mimeType:@"image/jpeg"];
        
        NSData *data2 = UIImageJPEGRepresentation(image1, 1);
        [formData appendPartWithFileData:data2 name:@"file2" fileName:fileName2 mimeType:@"image/jpeg"];
        
    } success:^(id responseObject) {
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
+(void)queryUserInfoSuccess:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/user/getOprInfo") parameters:@{@"token":[UserModel userToken]} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        //拿到所有用户信息，并保存在单例种
        NSLog(@"查询信息返回=%@",responseObject);
        NSDictionary *dic = responseObject;
        NSString *codeaStr = [NSString stringWithFormat:@"%@",dic[@"code"]];
        if ([codeaStr isEqualToString:@"1"]) {
            UserModel *model = [UserModel shareManager];
            //user
            NSDictionary *userDic = [dic[@"data"] objectForKey:@"user"];
            model.comId = [NSString stringWithFormat:@"%@",[userDic objectForKey:@"comId"]];
            model.headimg = [NSString stringWithFormat:@"%@",userDic[@"headimg"]];
            NSLog(@"请求时候查看=%@ \n%@\n%@",model.headimg,userDic[@"headimg"],[UserModel shareManager].headimg);
            model.userId = [NSString stringWithFormat:@"%@",userDic[@"id"]];
            model.idcard = [NSString stringWithFormat:@"%@",userDic[@"idcard"]];
            model.pass = [NSString stringWithFormat:@"%@",userDic[@"pass"]];
            model.post = [NSString stringWithFormat:@"%@",userDic[@"post"]];
            model.role = [NSString stringWithFormat:@"%@",userDic[@"role"]];
            model.userName = [NSString stringWithFormat:@"%@",userDic[@"setName"]];
            model.phoneNumber = [NSString stringWithFormat:@"%@",userDic[@"tel"]];
            model.truename = [NSString stringWithFormat:@"%@",userDic[@"truename"]];
            model.personalOrCompany = [NSString stringWithFormat:@"%@",userDic[@"type"]];
            //comList
            model.comList = [dic[@"data"] objectForKey:@"comList"];
            
            //com
            model.com = [dic[@"data"] objectForKey:@"com"];
            [model save];
            xt_success(responseObject);
        }else{
            NSLog(@"queryUserInfoSuccess:(Success)xt_success error:(Error)xt_error 出错");
        }
        
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}

+(void)queryHomeUserInfoSuccess:(Success)xt_success error:(Error)xt_error{
    NSDictionary *dic;
    if ([UserModel userToken]) {
        dic = @{@"token":[UserModel userToken]};
    }else{
        [MBProgressHUD showError:@"没有userToken"];
    }
    NSLog(@"刷新的时候使用的userToken:%@",[UserModel userToken]);
    [XTRequestManager GET:XT_REQUEST_URL(@"/user/main") parameters: dic responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}

+(void)switchCompanycomID:(NSString*)comID success:(Success)xt_success error:(Error)xt_error{
    [XTRequestManager GET:XT_REQUEST_URL(@"/user/changeCom") parameters:@{@"comId":comID,@"token":[UserModel userToken]} responseSeializerType:NHResponseSeializerTypeDefault success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
+(void)changePortrait:(UIImage*)image Success:(Success)xt_success error:(Error)xt_error{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
    [XTRequestManager POST:XT_REQUEST_URL(@"/user/changeHeadimg") parameters:@{@"token":[UserModel userToken]} responseSeializerType:NHResponseSeializerTypeDefault constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(image, 1);
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(id responseObject) {
        xt_success(responseObject);
    } failure:^(NSError *error) {
        xt_error(error);
    }];
}
@end
