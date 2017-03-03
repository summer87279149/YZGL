//
//  UserModel.m
//  YZGL
//
//  Created by Admin on 17/3/2.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(instancetype)shareManager
{
    static UserModel *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserModel alloc]init];
    });
    return manager;
}
- (void)save{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (self.userName) {
        [ud setObject:self.userName forKey:USER_NAME];
    }
    
    if (self.password) {
        [ud setObject:self.password forKey:USER_PASSWORD];
    }

    if (self.userId) {
        [ud setObject:self.userId forKey:USER_ID];
    }
    if (self.phoneNumber) {
        [ud setObject:self.phoneNumber forKey:USER_PHONE];
    }
    if(self.personalOrCompany){
        [ud setObject:self.personalOrCompany forKey:USER_PersonalOrCompany];
    }
    
    
    [ud synchronize];
}
+ (NSString *)username{
    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:USER_NAME];
    
    return username;
}
+ (NSString *)phoneNumber{
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PHONE];
    
    return  phoneNumber;
}
+ (NSString *)password{
    
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PASSWORD];
    
    return password;
}
+ (NSString *)userId{
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    return userId;
}
+(NSString *)personalOrCompany{
    NSString *personalOrCompany = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PersonalOrCompany];
    return personalOrCompany;
}
+ (BOOL)didLogin{
    
    BOOL login = NO;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([ud objectForKey:USER_PHONE] && [ud objectForKey:USER_PASSWORD]) {
        login = YES;
    }
    
    return login;
}
- (void)logOut{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:nil forKey:USER_NAME];
    [ud setObject:nil forKey:USER_PASSWORD];
    [ud setObject:nil forKey:USER_ID];
    [ud setObject:nil forKey:USER_PHONE];
    [ud setObject:nil forKey:USER_PersonalOrCompany];
    [ud synchronize];
}

+ (void)alertWithTitle:(NSString *)title{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

@end
