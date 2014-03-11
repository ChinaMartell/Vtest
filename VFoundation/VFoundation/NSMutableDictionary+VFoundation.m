//
//  NSMutableDictionary+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableDictionary+VFoundation.h"


/**
 *  NSMutableDictionary's subclass
 */
@interface VNSMutableDictionary : NSMutableDictionary

@end


@implementation VNSMutableDictionary
- (void)setObject:(id)anObject forKey:(id <NSCopying> )aKey {
	if (anObject && aKey) {
		[super setObject:anObject forKey:aKey];
	}
	else {
	}
}

@end


@implementation NSMutableDictionary (VFoundation)
+ (Class)safeClass {
	return [VNSMutableDictionary class];
}

@end
