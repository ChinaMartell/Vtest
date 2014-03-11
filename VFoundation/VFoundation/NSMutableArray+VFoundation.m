//
//  NSMutableArray+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableArray+VFoundation.h"
@implementation NSMutableArray (VFoundation)
- (BOOL)addObjectSafe:(id)anObject {
  if (anObject) {
    [self addObject:anObject];
    return YES;
  }
  return NO;
}
@end
