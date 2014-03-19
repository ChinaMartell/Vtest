//
//  NSMutableArray+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableArray+VFoundation.h"
#import "NSObject+VFoundation.h"

@implementation NSMutableArray (NSMutableArrayVFoundation)


/**
 *  swap Objects in array
 *
 *  @return swap Successful
 */
- (BOOL)swapObjectAtIndex:(NSInteger)fromIndex withObjectAtIndex:(NSInteger)toIndex {
	BOOL swapSuccess = FALSE;
	if (fromIndex >= 0 && fromIndex < [self count] && toIndex >= 0 && [self count] > toIndex) {
		id fromObject = [self objectAtIndex:fromIndex];
		id toObject = [self objectAtIndex:toIndex];
		[self replaceObjectAtIndex:fromIndex withObject:toObject];
		[self replaceObjectAtIndex:toIndex withObject:fromObject];
		swapSuccess = TRUE;
	}
	return swapSuccess;
}

/**
 *  move object
 *
 *  @return move Successful
 */
- (BOOL)moveObjectFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
	BOOL moveSuccess = FALSE;
	if (fromIndex >= 0 && fromIndex < [self count] && toIndex >= 0 && [self count] > toIndex) {
		id fromObj = [self objectAtIndex:fromIndex];
		[self removeObjectAtIndex:fromIndex];
		[self insertObject:fromObj atIndex:toIndex];
	}
	return moveSuccess;
}

- (BOOL)removeFirstObject {
	if (self.count > 0) {
		[self removeObjectAtIndex:0];
		return YES;
	}
	return NO;
}

@end
