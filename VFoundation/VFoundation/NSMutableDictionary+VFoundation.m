//
//  NSMutableDictionary+VFoundation.m
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableDictionary+VFoundation.h"

@implementation NSMutableDictionary (NSMutableDictionaryVFoundation)

- (void)mergeDictionary:(NSDictionary *)aMergedDict {
	NSArray *keys = [self allKeys];
	for (NSString *key in keys) {
		id mergedOB = [aMergedDict valueForKey:key];
		if (mergedOB) {
			NSMutableArray *mergedResults = nil;
			id ob = [self valueForKey:key];
			if (ob != mergedOB) {
				if ([ob isKindOfClass:[NSString class]] && [mergedOB isKindOfClass:[NSString class]]) {
					if ([ob isEqualToString:mergedOB]) {
						continue;
					}
				}
				if ([ob isKindOfClass:[NSArray class]]) {
					mergedResults = [NSMutableArray arrayWithArray:ob];
				}
				else {
					mergedResults = [NSMutableArray arrayWithObject:ob];
				}
				if ([mergedOB isKindOfClass:[NSArray class]]) {
					[mergedResults addObjectsFromArray:mergedOB];
				}
				else {
					[mergedResults addObject:mergedOB];
				}
				[self setValue:mergedResults forKey:key];
			}
		}
	}

	// 合并self中没有的key项
	for (NSString *key in aMergedDict) {
		id ob = [self valueForKey:key];
		if (!ob) {
			[self setValue:key forKey:[aMergedDict valueForKey:key]];
		}
	}
}

- (void)removeFirstObject {
	id key = [[self allKeys] firstObject];
	if (key != nil) {
		[self removeObjectForKey:key];
	}
}

- (void)removeLastObject {
	id key = [[self allKeys] lastObject];
	if (key != nil) {
		[self removeObjectForKey:key];
	}
}

@end
