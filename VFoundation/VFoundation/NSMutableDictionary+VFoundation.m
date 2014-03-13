//
//  NSMutableDictionary+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSMutableDictionary+VFoundation.h"

@implementation NSMutableDictionary (VFoundation)

bool setObject(NSMutableDictionary *mDict, id object, id key) {
	if (object) {
		[mDict setObject:object forKey:key];
		return true;
	}
	return false;
}

@end
