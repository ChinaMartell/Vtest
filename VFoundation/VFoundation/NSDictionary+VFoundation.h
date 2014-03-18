//
//  NSDictionary+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  NSDictionary' category in VFoundation
 */
@interface NSDictionary (VFoundation)

+ (NSDictionary *)dictionaryWithDictionaries:(NSDictionary *)dict, ...NS_REQUIRES_NIL_TERMINATION;

@end
