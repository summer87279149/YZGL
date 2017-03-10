//
//  VoiceView.m
//  YZGL
//
//  Created by Admin on 17/3/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "VoiceView.h"

@implementation VoiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordButton setBackgroundImage:[[UIImage imageNamed:@"btn_chatbar_press_normal" ] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_recordButton setBackgroundImage:[[UIImage imageNamed:@"btn_chatbar_press_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateSelected];
        _recordButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_recordButton setTitle:@"按住录音" forState:UIControlStateNormal];
        [_recordButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        [_recordButton addTarget:self action:@selector(startRecordVoice) forControlEvents:UIControlEventTouchDown];
        [_recordButton addTarget:self action:@selector(cancelRecordVoice) forControlEvents:UIControlEventTouchUpOutside];
        [_recordButton addTarget:self action:@selector(confirmRecordVoice) forControlEvents:UIControlEventTouchUpInside];
        [_recordButton addTarget:self action:@selector(updateCancelRecordVoice) forControlEvents:UIControlEventTouchDragExit];
        [_recordButton addTarget:self action:@selector(updateContinueRecordVoice) forControlEvents:UIControlEventTouchDragEnter];
        
        [_recordButton setFrame:CGRectMake(10, 0, kScreenWidth, 50)];
        [self addSubview:_recordButton];
        
        UIButton *cancel = [UIButton XT_createBtnWithTitle:@"确定" TitleColor:[UIColor blueColor] TitleFont:nil cornerRadio:nil BGColor:nil Borderline:nil BorderColor:nil target:self Method:@selector(close)];
        cancel.frame = CGRectMake(0, 100, 100, 30);
        [self addSubview:cancel];
    }
    return self;
}


-(void)startRecordVoice{
    if (self.start) {
        [self.start sendNext:self];
    }
}


-(void)cancelRecordVoice{
    if (self.cancel) {
        [self.cancel sendNext:self];
    }
}


-(void)confirmRecordVoice{
    if (self.confirm) {
        [self.confirm sendNext:self];
    }
}


-(void)updateCancelRecordVoice{
    if (self.updateCancel) {
        [self.updateCancel sendNext:self];
    }
}


-(void)updateContinueRecordVoice{
    if (self.updateContinue) {
        [self.updateContinue sendNext:self];
    }
}

-(void)close{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
