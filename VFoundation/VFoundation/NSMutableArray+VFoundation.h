//
//  NSMutableArray+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  NSMutableArray' category in VFoundation
 */
@interface NSMutableArray (NSMutableArrayVFoundation)
/**
 *  Make safe when add nil object or nil key
 *
 *  @param mArray receiver
 *  @param object Can be nil
 *
 *  @return If set successfully it will be return YES,otherwise NO
 */
bool addObject(NSMutableArray *mArray, id object);

@end
