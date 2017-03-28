//
//  ChooseDateItem.m
//  YZGL
//
//  Created by Admin on 17/3/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "ChooseDateItem.h"

@implementation ChooseDateItem
+ (ChooseDateItem *)itemWithImageNamed:(NSString *)imageName
{
    ChooseDateItem *item = [[ChooseDateItem alloc] init];
    item.imageName = imageName;
    return item;
}
@end
