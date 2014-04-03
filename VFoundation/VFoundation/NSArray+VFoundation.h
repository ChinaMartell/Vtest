//
//  NSArray+VFoundation.h
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  NSArray' category in VFoundation
 */
@interface NSArray (VFoundation)
/**
 *  make deep copy of the array
 *
 *  @return the copy array
 */
- (NSArray *)trueDeepCopy;
- (NSArray *)arrayWithBlock:(id (^)(id obj, NSInteger index))block;
@end
