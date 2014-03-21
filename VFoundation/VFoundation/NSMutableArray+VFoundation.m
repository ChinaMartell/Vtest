//
//  NSMutableArray+VFoundation.m
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableArray+VFoundation.h"
#import "NSObject+VFoundation.h"

@implementation NSMutableArray (NSMutableArrayVFoundation)

- (BOOL)swapObjectAtIndex:(NSUInteger)fromIndex withObjectAtIndex:(NSUInteger)toIndex {
	BOOL swapSuccess = FALSE;
	if (fromIndex < [self count] && [self count] > toIndex) {
		id fromObject = [self objectAtIndex:fromIndex];
		id toObject = [self objectAtIndex:toIndex];
		[self replaceObjectAtIndex:fromIndex withObject:toObject];
		[self replaceObjectAtIndex:toIndex withObject:fromObject];
		swapSuccess = TRUE;
	}
	return swapSuccess;
}

- (BOOL)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
	BOOL moveSuccess = FALSE;
	if (fromIndex < [self count] && [self count] > toIndex) {
		id fromObj = [self objectAtIndex:fromIndex];
		[self removeObjectAtIndex:fromIndex];
		[self insertObject:fromObj atIndex:toIndex];
	}
	return moveSuccess;
}

@end
