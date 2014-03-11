//
//  NSMutableDictionary+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableDictionary+VFoundation.h"

@implementation NSMutableDictionary (VFoundation)
- (BOOL)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey {
  if (anObject && aKey) {
    [self setObject:anObject forKey:aKey];
    return YES;
  }
  return NO;
}

@end
