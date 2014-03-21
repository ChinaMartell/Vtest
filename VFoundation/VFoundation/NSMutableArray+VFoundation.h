//
//  NSMutableArray+VFoundation.h
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  NSMutableArray' category in VFoundation
 */
@interface NSMutableArray (NSMutableArrayVFoundation)

/**
 *  move object
 *
 *  @return move Successful
 */
- (BOOL)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

/*
 *  swap Objects in array
 *
 *  @return swap Successful
 */
- (BOOL)swapObjectAtIndex:(NSUInteger)fromIndex withObjectAtIndex:(NSUInteger)toIndex;

- (void)removeFirstObject;
- (void)removeLastObject;

@end
