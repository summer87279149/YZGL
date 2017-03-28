//
//  UserModel.h
//  YZGL
//
//  Created by Admin on 17/3/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define USER_NAME                           @"ud_user_name"
#define USER_PASSWORD                       @"ud_user_password"
#define USER_ID                             @"ud_user_id"
#define USER_PHONE                          @"phoneNumber"
#define USER_PersonalOrCompany              @"Personal_Company"
#define USER_TOKEN                          @"ud_user_token"
@interface UserModel : NSObject

//用户名
@property (strong, nonatomic) NSString *userName;

//密码
@property (strong, nonatomic) NSString *password;

//用户id
@property (strong, nonatomic) NSString *userId;

//用户token
@property (strong, nonatomic) NSString *userToken;

//手机号
@property (strong, nonatomic) NSString *phoneNumber;

//个人or公司  @“0”，@“1”
@property (strong, nonatomic) NSString *personalOrCompany;

+(instancetype)shareManager;

- (void)save;

+ (NSString *)username;

+ (NSString *)phoneNumber;

+ (NSString *)password;

+ (NSString*)userToken;

+ (NSString *)userId;

+(NSString *)personalOrCompany;

+ (BOOL)didLogin;

- (void)logOut;


@end
