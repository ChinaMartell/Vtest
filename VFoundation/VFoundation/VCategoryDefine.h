//
//  VCategoryDefine.h
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionary+VFoundation.h"
#import "NSMutableArray+VFoundation.h"
/**
 *  Macros:make safe when set nil object or nil key
 */
#define setObject(mDict, object, key) [mDict setObjectSafe:object forKey:key]

/**
 *  Macros:make safe when add nil object or nil key
 */
#define addObject(mArray, object) [mArray addObjectSafe:object]

@interface VCategoryDefine : NSObject

@end
