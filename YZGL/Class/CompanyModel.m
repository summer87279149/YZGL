//
//  CompanyModel.m
//  YZGL
//
//  Created by Admin on 17/3/29.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CompanyModel.h"
#import <objc/runtime.h>
@implementation CompanyModel

- (BOOL)isSomeValueIsNil
{
    unsigned int outCount;
    Ivar * ivars =class_copyIvarList([self class], &outCount);
    for (int i=0; i<outCount; ++i) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:name];
        if([self valueForKey:ivarName]==nil){
            return YES;
        }
    }

    return NO;
}
@end
