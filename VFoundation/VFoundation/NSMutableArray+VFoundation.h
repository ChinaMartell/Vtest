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

- (BOOL)moveObjectFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
- (BOOL)swapObjectAtIndex:(NSInteger)fromIndex withObjectAtIndex:(NSInteger)toIndex;

- (BOOL)removeFirstObject;

@end
