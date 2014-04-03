//
//  VCategoryDefine.h
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger, NSValueType) {
	NSValueTypeInt,
	NSValueTypeUInt,
	NSValueTypeShort,
	NSValueTypeUShort,
	NSValueTypeLong,
	NSValueTypeULong,
	NSValueTypeLongLong,
	NSValueTypeULongLong,
	NSValueTypeBool,
	NSValueTypeFloat,
	NSValueTypeDouble,
	NSValueTypeChar,
	NSValueTypeUChar,
	NSValueTypeUnKnown,
};
@interface VCategoryDefine : NSObject

@end
