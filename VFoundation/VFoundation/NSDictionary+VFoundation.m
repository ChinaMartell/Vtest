//
//  NSDictionary+VFoundation.m
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSDictionary+VFoundation.h"
#import "SJHelper.h"
#import "VFoundation.h"


@implementation NSDictionary (NSDictionaryVFoundation)


+ (NSDictionary *)dictionaryWithDictionaries:(NSDictionary *)dict, ...NS_REQUIRES_NIL_TERMINATION
{
	NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:dict];
	va_list ap;
	va_start(ap, dict);
	NSDictionary *d = dict;
	while (d) {
		d = va_arg(ap, id);
		if ([d isKindOfClass:[NSDictionary class]]) {
			[dic addEntriesFromDictionary:d];
		}
	}
	va_end(ap);
	return dic;
}



- (NSMutableDictionary *)deepMutableCopy {
	return (__bridge_transfer NSMutableDictionary *)CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (__bridge CFDictionaryRef)self, kCFPropertyListMutableContainers);
}

- (BOOL)isEmpty {
	BOOL isEmpty = [super isEmpty];
	if (!isEmpty) {
		isEmpty = !(self.count > 0 && self.count != NSNotFound);
	}
	return isEmpty;
}

@end
