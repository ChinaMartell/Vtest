//
//  NSString+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSString+VFoundation.h"
#import "JSONKit.h"
@implementation NSString (NSStringVFoundation)


@end
@implementation NSString (NSStringUrl)

@end
@implementation NSString (NSStringJson)
- (NSString *)toJson {
	return [self JSONString];
}

@end
