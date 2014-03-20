//
//  NSNumber+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  NSNumber' category in VFoundation
 */
@interface NSNumber (NSNumberVFoundation)
/**
 *  Get a number with a point x and y,this doesn't work for numbers above 32767
 *
 *  @param x
 *  @param y
 *
 *  @return number
 */
+ (NSNumber *)numberWithX:(NSInteger)x andY:(NSInteger)y;
/**
 *  Get a point number x
 *
 *  @return int
 */
- (NSInteger)x;
/**
 *  Get a point number y
 *
 *  @return y
 */
- (NSInteger)y;
/**
 *  Get a number with a point x and y,this is so you can write NSNumber *coord = [@4 xAndY:5]
 *
 *  @param y
 *
 *  @return number
 */
- (NSNumber *)xAndY:(NSInteger)y;
@end
