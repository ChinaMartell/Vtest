//
//  NSMutableArray+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableArray+VFoundation.h"

@implementation NSMutableArray (VFoundation)

@end




@implementation VNSMutableArray

- (void)addObject:(id)anObject {
	if (anObject) {
		[super addObject:anObject];
	}
	else {
		NSAssert(NO, @"the add object is nil");
	}
}

@end
