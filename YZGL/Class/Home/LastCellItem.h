//
//  LastCellItem.h
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface LastCellItem : RETableViewItem
@property (copy, readwrite, nonatomic) NSString *imageName;

+ (LastCellItem *)itemWithImageNamed:(NSString *)imageName;

@end
