//
//  BaseRequestManager.h
//  YZGL
//
//  Created by Admin on 17/3/16.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id response);
typedef void(^Error) (id response);
#define XT_BASEURL @"http://192.168.1.110:8081/seal_wx/apps/%@"
#define XT_REQUEST_URL(url)  [NSString stringWithFormat:XT_BASEURL,url]
#define XT_BASEIMAGEURL @"http://192.168.1.110:8081/files2/%@"
#define XT_IMAGE_URL(url) [NSString stringWithFormat:XT_BASEIMAGEURL,url]
@interface BaseRequestManager : NSObject


@end
