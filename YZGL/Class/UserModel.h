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

//假名字
@property (copy, nonatomic) NSString *userName;
//真实名字
@property (nonatomic, copy) NSString *truename;
//密码
@property (copy, nonatomic) NSString *password;

//用户id
@property (copy, nonatomic) NSString *userId;

//用户token
@property (copy, nonatomic) NSString *userToken;

//手机号
@property (copy, nonatomic) NSString *phoneNumber;

//个人or公司  @“1”，@“2”
@property (strong, nonatomic) NSString *personalOrCompany;

//comID 单位id
@property (nonatomic, copy) NSString *comId;
//com 单位
@property (nonatomic, copy) NSDictionary *com;
//headimg
@property (nonatomic, copy) NSString *headimg;

//idcard
@property (nonatomic, copy) NSString *idcard;
//pass
@property (nonatomic, copy) NSString *pass;
//post 职位
@property (nonatomic, copy) NSString *post;
//role 角色
@property (nonatomic, copy) NSString *role;

//tel
@property (nonatomic, copy) NSString *tel;

//comList
@property (nonatomic, copy) NSArray *comList;

+(instancetype)shareManager;

- (void)save;

//+ (NSString *)username;

//+ (NSString *)phoneNumber;

+ (NSString *)password;

+ (NSString*)userToken;

+ (NSString *)userId;

+(NSString *)personalOrCompany;

+ (BOOL)didLogin;

- (void)logOut;


@end
