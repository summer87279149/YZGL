//
//  CheckRecordItemViewController.h
//  YZGL
//
//  Created by Admin on 17/3/3.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSUInteger,CheongsamBrand){
    CheongsamBrandAll,
    CheongsamBrandRecommand,
    CheongsamBrandDomestic,
    CheongsamBrandInternational,
};
@interface CheckRecordItemViewController : BaseViewController
@property (nonatomic,assign)CheongsamBrand cheongsamBrandType;

- (instancetype)initWithType:(CheongsamBrand)CheongsamBrandType;
@end
