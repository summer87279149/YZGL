//
//  LastCellAddPhotoCell.h
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import "LastCellItem.h"

@interface LastCellAddPhotoCell : RETableViewCell
@property (strong, nonatomic) UILabel *lab;
@property (strong, nonatomic) UIImageView *pictureView;
@property (strong, nonatomic) LastCellItem *imageItem;

@end
