//
//  NSObject+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSObject+VFoundation.h"

@implementation NSObject (VFoundation)

/**
 *  catch the error of setValue for undefined key
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    NSAssert(NO, @"setValue:%@ for undefinedKey:%@", value, key);
}

@end
