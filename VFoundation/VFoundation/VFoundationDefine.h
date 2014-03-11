//
//  VFoundationDefine.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+VFoundation.h"

/**
 *  Define the macros, make safe the object.
 */
#define safe(object) [object safeClass]

@interface VFoundationDefine : NSObject

@end
