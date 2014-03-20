//
//  NSMutableSet+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableSet+VFoundation.h"
#import <objc/runtime.h>
@implementation NSMutableSet (NSMutableSetVFoundation)
+ (void)load {
	[super load];
	Class mSetClass = NSClassFromString(@"__NSSetM");
	Method originalMethod = class_getInstanceMethod(mSetClass, @selector(addObject:));
	Method categoryMethod = class_getInstanceMethod([NSMutableSet class], @selector(__exchange__addObject:));
	method_exchangeImplementations(originalMethod, categoryMethod);
}

- (void)__exchange__addObject:(id)object {
	if (object != nil) {
		[self __exchange__addObject:object];
	}
}

@end
