//
//  NSMutableArray+Test.m
//  Vtest
//
//  Created by shadow on 14-3-13.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableArray+Test.h"
#import <objc/runtime.h>
@implementation NSMutableArray (Test)
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
