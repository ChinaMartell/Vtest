//
//  NSMutableArray+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableArray+VFoundation.h"


/**
 *  NSMutableArray's subclass
 */
@interface VNSMutableArray : NSMutableArray

@end


@implementation VNSMutableArray

- (void)addObject:(id)anObject {
	if (anObject) {
		[super addObject:anObject];
	}
	else {
	}
}

@end


@implementation NSMutableArray (VFoundation)
+ (Class)safeClass {
	return [VNSMutableArray class];
}

@end
