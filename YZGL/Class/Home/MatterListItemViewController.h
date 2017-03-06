//
//  MatterListItemViewController.h
//  YZGL
//
//  Created by Admin on 17/3/6.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSUInteger,MatterListItem){
    CMatterListItemAll,
    MatterListItemWait,
    MatterListItemAgree,
    MatterListItemRefuse,
};
@interface MatterListItemViewController : BaseViewController
@property (nonatomic,assign)MatterListItem matterListItemType;

- (instancetype)initWithType:(MatterListItem)matterListItemType;

@end
