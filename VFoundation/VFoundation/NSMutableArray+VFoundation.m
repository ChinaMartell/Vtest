//
//  NSMutableArray+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableArray+VFoundation.h"
#import <objc/runtime.h>
@interface VNSMutableArray : NSMutableArray


@end

@implementation VNSMutableArray

- (void)addObject:(id)anObject {
	NSLog(@"fff");
}

@end

@implementation NSMutableArray (NSMutableArrayVFoundation)
bool addObject(NSMutableArray *mArray, id object) {
	if (object) {
		[mArray addObject:object];
		return true;
	}
	return false;
}

- (NSUInteger)logLength {
	NSUInteger length = [self logLength];
	NSLog(@"Logging: %d", length);
	return length;
}

+ (void)load {
	Method original, swizzle;

	original = class_getInstanceMethod(self, @selector(addObject:));
	swizzle  = class_getInstanceMethod(self, @selector(logLength));
	method_exchangeImplementations(original, swizzle);
}

@end
