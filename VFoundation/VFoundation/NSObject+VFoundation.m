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
	static NSMutableDictionary *instanceDict;
	dispatch_once(&once, ^{
	    instanceDict = [[NSMutableDictionary alloc] init];
	});
	NSString *instanceKey = NSStringFromClass([self class]);
	id sharedInstance = [instanceDict objectForKey:instanceKey];
	if (!sharedInstance) {
		sharedInstance = [[[self class] alloc] init];
		[instanceDict setObject:sharedInstance forKey:instanceKey];
	}
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

- (BOOL)isMeaningful {
	return ![self isEmpty];
}

@end
