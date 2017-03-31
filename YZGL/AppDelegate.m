//
//  AppDelegate.m
//  YZGL
//
//  Created by Admin on 17/2/27.
//  Copyright © 2017年 Admin. All rights reserved.
//
#import "BaseNavViewController.h"
#import "RequestManager.h"
#import "UserLoginViewController.h"
#import "HomeViewController.h"
#import "RecordViewController.h"
#import "SettingViewController.h"
#import "HintViewController.h"
#import "AppDelegate.h"
#import "UITabBarController+extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setRootVC];
    [self judgeIsLogin];
    
    return YES;
}










-(void)setRootVC{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *tabBarVC=[[UITabBarController alloc]init];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    backView.backgroundColor = [UIColor blackColor];
    [tabBarVC.tabBar insertSubview:backView atIndex:0];
    tabBarVC.tabBar.opaque = YES;
    [tabBarVC addViewController:[[HomeViewController alloc]init] withImage:@"1.png" WithSelectImage:@"1.png" WithTitle:@"首页"];
    [tabBarVC addViewController:[[RecordViewController alloc]init] withImage:@"2.png" WithSelectImage:@"2.png" WithTitle:@"记录"];
    [tabBarVC addViewController:[[HintViewController alloc]init] withImage:@"3.png" WithSelectImage:@"3.png" WithTitle:@"提示"];
    [tabBarVC addViewController:[[SettingViewController alloc]init] withImage:@"4.png" WithSelectImage:@"4.png" WithTitle:@"设置"];
    self.window.rootViewController=tabBarVC;
    [self.window makeKeyAndVisible];
    
}
-(void)judgeIsLogin{
    
    if (![UserModel didLogin]) {
        NSLog(@"打印token:%@",[UserModel userToken]);
        [self reLogin];
    }else{
        //如果登入了就验证token
        [MBProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
        [RequestManager loginWithTokenSuccess:^(id response) {
            [MBProgressHUD hideHUDForView:self.window.rootViewController.view animated:YES];
            NSLog(@"appdelegate 返回%@",response);
            NSString *code = response[@"code"];
            NSString *message = response[@"message"];
            if ([code intValue]!=1) {//如果token无效就重新登入
//                [MBProgressHUD showError:message];
//                 NSLog(@"token失效重新登入");
//                [self reLogin];
            }
        } error:^(id response) {
            [MBProgressHUD showError:@"请检查网络"];
        }];
    }
}
-(void)reLogin{
    UserLoginViewController*loginVc = [[UserLoginViewController alloc]init];
    loginVc.title = @"登入";
    BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:loginVc];
    [self.window.rootViewController presentViewController:nav animated:NO completion:nil];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
