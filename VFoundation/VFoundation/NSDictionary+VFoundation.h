//
//  NSDictionary+VFoundation.h
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  NSDictionary' category in VFoundation
 */
@interface NSDictionary (NSDictionaryVFoundation)

+ (NSDictionary *)dictionaryWithDictionaries:(NSDictionary *)dict, ...NS_REQUIRES_NIL_TERMINATION;
- (NSMutableDictionary *)deepMutableCopy NS_RETURNS_RETAINED;
@end
