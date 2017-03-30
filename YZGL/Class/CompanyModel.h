//
//  CompanyModel.h
//  YZGL
//
//  Created by Admin on 17/3/29.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyModel : NSObject

@property (nonatomic, strong) NSString *provinceCode;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *areaCode;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *lat;
//@property (nonatomic, strong) NSString *comname;
@property (nonatomic, strong) NSString *validDate;
@property (nonatomic, strong) NSString *isLongTerm;
@property (nonatomic, strong) UIImage *scanImage;
@property (nonatomic, strong) UIImage *companyImage;
@end
