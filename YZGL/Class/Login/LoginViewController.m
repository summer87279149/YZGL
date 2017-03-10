//
//  LoginViewController.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "UserLoginViewController.h"
#import "LoginViewController.h"
#import "RegistViewController.h"
@interface LoginViewController ()
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 

}


- (IBAction)login:(UIButton *)sender {
    [self.navigationController pushViewController:[UserLoginViewController new] animated:YES];
}



- (IBAction)regist:(UIButton *)sender {
    [self.navigationController pushViewController:[RegistViewController new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
