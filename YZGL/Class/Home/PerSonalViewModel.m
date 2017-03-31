//
//  PerSonalViewModel.m
//  YZGL
//
//  Created by Admin on 17/3/31.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "PerSonalViewModel.h"
#import "RequestManager.h"
@implementation PerSonalViewModel
-(BOOL)isPersonalUser{
    if([[UserModel shareManager].personalOrCompany intValue]==1){
        return YES;
    }else{
        //company
        return NO;
    }
}
-(NSArray *)makeCellArr{
    NSString *phone = [NSString stringWithFormat:@"手机号:  %@",[UserModel shareManager].phoneNumber];
    NSString *userName = [NSString stringWithFormat:@"用户名:  %@",[UserModel shareManager].userName];
    NSString *companyName;
    if ([UserModel shareManager].com) {
        companyName  = [NSString stringWithFormat:@"公司名:  %@",[UserModel shareManager].com[@"comName"] ];
    }else{
        companyName = @"公司名:";
    }
    NSString *zhiwu = [NSString stringWithFormat:@"职务:  %@",[UserModel shareManager].post];
    return  @[phone,userName,companyName,zhiwu];
}

-(void)getUserInfoComplete:(void(^)(id response))complete{
    [RequestManager queryUserInfoSuccess:^(id response) {
        complete(response);
    } error:^(id response) {
    }];
}
-(void)switchCompany:(NSString*)comId Complete:(void(^)(id response))complete{
    [RequestManager switchCompanycomID:comId success:^(id response) {
        NSLog(@"切换成功返回:%@",response);
        if ([response[@"code"] intValue]==1) {
            //刷新页面
//            [self getUserInfo];
            complete(response);
        }
    } error:^(id response) {
        
    }];
}
@end
