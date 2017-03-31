//
//  PerSonalViewModel.h
//  YZGL
//
//  Created by Admin on 17/3/31.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PerSonalViewModel : NSObject
-(void)getUserInfoComplete:(void(^)(id response))complete;
-(NSArray *)makeCellArr;
-(BOOL)isPersonalUser;
-(void)switchCompany:(NSString*)comId Complete:(void(^)(id response))complete;
@end
