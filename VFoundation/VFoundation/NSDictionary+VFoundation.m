//
//  NSDictionary+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSDictionary+VFoundation.h"

@implementation NSDictionary (VFoundation)


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

@end
