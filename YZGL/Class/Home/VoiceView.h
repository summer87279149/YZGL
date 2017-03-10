//
//  VoiceView.h
//  YZGL
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceView : UIView
@property (nonatomic, strong) UIButton    *recordButton;
@property (nonatomic, strong) RACSubject *start;
@property (nonatomic, strong) RACSubject *cancel;
@property (nonatomic, strong) RACSubject *confirm;
@property (nonatomic, strong) RACSubject *updateCancel;
@property (nonatomic, strong) RACSubject *updateContinue;
@end
