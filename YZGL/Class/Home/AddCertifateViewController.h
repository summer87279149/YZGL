//
//  AddCertifateViewController.h
//  YZGL
//
//  Created by Admin on 17/3/1.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger,CertifateType){
    CertifateTypeIDCard     = 0,
    CertifateTypeHuKouBu    = 1,
    CertifateTypeDIY        = 2,
};

@interface AddCertifateViewController : BaseViewController

@property (nonatomic, assign) CertifateType certifateType;

- (instancetype)initWithCertifateType:(CertifateType)certifateType;
@end
