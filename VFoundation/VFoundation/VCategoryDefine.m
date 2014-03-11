//
//  VCategoryDefine.m
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "VCategoryDefine.h"

@implementation VCategoryDefine
bool setObject(NSMutableDictionary *mDict, id object, id key) {
	if (object) {
		[mDict setObject:object forKey:key];
		return true;
	}
	return false;
}

bool addObject(NSMutableArray *mArray, id object) {
	if (object) {
		[mArray addObject:object];
		return true;
	}
	return false;
}

@end
