//
//  UIView+XTDraggable.h
//  大大舒服的
//
//  Created by Admin on 17/3/9.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XTDraggable)
@property(nonatomic,assign,getter = isDragEnable)   BOOL dragEnable;
@property(nonatomic,assign,getter = isAdsorbEnable) BOOL adsorbEnable;

@end
