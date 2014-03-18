//
//  VFoundationDefine.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCategoryDefine.h"
#import "VUtilityDefine.h"


#define C_DEFAULT_ENCODING kCFStringEncodingUTF8
#define DEFAULT_ENCODING NSUTF8StringEncoding


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
#define IOS_VERSION_OVER_7 YES
#endif

@interface VFoundationDefine : NSObject

@end
