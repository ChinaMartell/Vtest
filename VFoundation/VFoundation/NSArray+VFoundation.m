//
//  NSArray+VFoundation.m
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSArray+VFoundation.h"
#import "SJHelper.h"

@implementation NSArray (VFoundation)

/**
 *  Method swizzling for NSArray
 */
+ (void)load {
	[super load];
	Class arrayClass = NSClassFromString(@"__NSArrayM");

	Method originalMethod = class_getInstanceMethod(arrayClass, @selector(addObject:));
	Method categoryMethod = class_getInstanceMethod([NSArray class], @selector(sjAddObjectSafe:));
	[[SJHelper sharedHelper] swizzlingMethod:originalMethod withAnotherMethod:categoryMethod];

	originalMethod = class_getInstanceMethod(arrayClass, @selector(objectAtIndex:));
	categoryMethod = class_getInstanceMethod([NSArray class], @selector(sjObjectAtIndexSafe:));
	[[SJHelper sharedHelper] swizzlingMethod:originalMethod withAnotherMethod:categoryMethod];
}

/**
 *  to protect the array from inserting nil object
 *
 *  @param voidaddObjectSafe:id : the object needed to be inserted
 *
 *  @return void
 */
- (void)sjAddObjectSafe:(id)anObject {
	if (anObject != nil) {
		[self sjAddObjectSafe:anObject];
	}else{
        NSAssert(NO, @"addObject:nil");
    }
}

/**
 *  to protect the array from accessing object at index beyond the array
 *
 *  @param index : the index of the object
 *
 *  @return the valid object at index or nil
 */
- (id)sjObjectAtIndexSafe:(NSUInteger)index {
	id obj = nil;
	if (index < [self count]) {
		obj = [self sjObjectAtIndexSafe:index];
	}
	else {
		NSAssert(NO, @"index %d is beyond the count of the array", index);
	}
	return obj;
}


- (NSArray *)trueDeepCopy {
	return [NSKeyedUnarchiver unarchiveObjectWithData:
	        [NSKeyedArchiver archivedDataWithRootObject:self]];
}

@end
