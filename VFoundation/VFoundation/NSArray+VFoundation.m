//
//  NSArray+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSArray+VFoundation.h"

@implementation NSArray (VFoundation)

/**
 *  Method swizzling for NSArray
 */
+ (void)load {
	[super load];
	Class arrayClass = NSClassFromString(@"__NSArrayM");

	Method originalMethod = class_getInstanceMethod(arrayClass, @selector(addObject:));
	Method categoryMethod = class_getInstanceMethod([NSArray class], @selector(addObjectSafe:));
	method_exchangeImplementations(originalMethod, categoryMethod);

	originalMethod = class_getInstanceMethod(arrayClass, @selector(objectAtIndex:));
	categoryMethod = class_getInstanceMethod([NSArray class], @selector(objectAtIndexSafe:));
	method_exchangeImplementations(originalMethod, categoryMethod);
}

/**
 *  to protect the array from inserting nil object
 *
 *  @param voidaddObjectSafe:id : the object needed to be inserted
 *
 *  @return void
 */
- (void)addObjectSafe:(id)anObject {
	if (anObject != nil) {
		[self addObjectSafe:anObject];
	}
}

/**
 *  to protect the array from accessing object at index beyond the array
 *
 *  @param index : the index of the object
 *
 *  @return the valid object at index or nil
 */
- (id)objectAtIndexSafe:(NSUInteger)index {
	id obj = nil;
	if (index < [self count]) {
		obj = [self objectAtIndex:index];
	}
	else {
		NSLog(@"数组越界");
	}
	return obj;
}


/**
 *  make deep mutable copy of the array
 *
 *  @return the copy mutable array
 */
- (NSMutableArray *)deepMutableCopy {
	return (__bridge_transfer NSMutableArray *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFArrayRef)self, kCFPropertyListMutableContainers);
}


/**
 *  make deep copy of the array
 *
 *  @return the copy array
 */
- (NSArray *)deepCopy {
	return [NSKeyedUnarchiver unarchiveObjectWithData:
	        [NSKeyedArchiver archivedDataWithRootObject:self]];
}

@end
