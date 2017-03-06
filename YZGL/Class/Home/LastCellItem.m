//
//  LastCellItem.m
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "LastCellItem.h"

@implementation LastCellItem

+ (LastCellItem *)itemWithImageNamed:(NSString *)imageName
{
    LastCellItem *item = [[LastCellItem alloc] init];
    item.imageName = imageName;
    return item;
}
@end
