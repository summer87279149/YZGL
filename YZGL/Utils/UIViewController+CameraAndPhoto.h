//
//  UIViewController+CameraAndPhoto.h
//  YZGL
//
//  Created by Admin on 17/2/28.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^getImageBlock)(NSData*data);

@interface UIViewController (CameraAndPhoto)<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic, copy) getImageBlock xt_block;

-(void)openImagePicker;
@end
