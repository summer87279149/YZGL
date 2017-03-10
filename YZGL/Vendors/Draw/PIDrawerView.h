//
//  PIDrawerView.h
//  PIImageDoodler
//
//  Created by Pavan Itagi on 07/03/14.
//  Copyright (c) 2014 Pavan Itagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+frame.h"
typedef NS_ENUM(NSInteger, DrawingMode) {
    DrawingModePaint,
    DrawingModeErase,
};

@interface PIDrawerView : UIView
@property (nonatomic, readwrite) DrawingMode drawingMode;

@property (nonatomic, assign) NSInteger rubberWidth;
@property (nonatomic, assign) NSInteger paintWidth;
@property (nonatomic, strong) UIColor *paintColor;

@property (nonatomic, strong) NSArray *passthroughViews;

- (void)initialize;




@end
