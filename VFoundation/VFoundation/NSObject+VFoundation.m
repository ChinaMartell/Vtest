//
//  NSObject+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSObject+VFoundation.h"
#import "VFoundation.h"
@implementation NSObject (NSObjectVFoundation)
+ (id)sharedInstance {
	static dispatch_once_t once;
	static id sharedInstance;
	dispatch_once(&once, ^{
	    sharedInstance = [[self alloc] init];
	});
	return sharedInstance;
}

/**
 *  catch the error of setValue for undefined key
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
	NSAssert(NO, @"setValue:%@ for undefinedKey:%@", value, key);
}

- (BOOL)isEmpty {
	return [self isEqual:[NSNull null]];
}

@end
