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
@interface NSMutableArray (VFoundation)
/**
 *  Make safe when add nil object
 *
 *  @param anObject Can be nil
 *
 *  @return If add successfully it will be return YES,otherwise NO
 */
- (BOOL)addObjectSafe:(id)anObject;
@end
