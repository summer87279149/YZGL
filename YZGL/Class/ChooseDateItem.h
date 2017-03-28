//
//  ChooseDateItem.h
//  YZGL
//
//  Created by Admin on 17/3/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>

@interface ChooseDateItem : RETableViewItem
@property (copy, readwrite, nonatomic) NSString *imageName;

+ (ChooseDateItem *)itemWithImageNamed:(NSString *)imageName;

@end
