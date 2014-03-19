//
//  NSBundle+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSBundle+VFoundation.h"
#import "VFoundation.h"
@implementation NSBundle (NSBundleVFoundation)
+ (NSString *)buildVersion {
	return [self objectForKey:(NSString *)kCFBundleVersionKey];
}

+ (NSString *)appVersion {
	return [self objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appName {
	return [self objectForKey:(NSString *)kCFBundleNameKey];
}

+ (NSString *)appDisplayName {
	return [self objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)identifier {
	return [self objectForKey:(NSString *)kCFBundleIdentifierKey];
}

+ (NSString *)executable {
	return [self objectForKey:(NSString *)kCFBundleExecutableKey];
}

+ (id)objectForKey:(NSString *)key {
	if (key) {
		return [[self infoDictionary] objectForKey:key];
	}
	return nil;
}

+ (NSDictionary *)infoDictionary {
	return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)pathForFile:(NSString *)fileName {
	return [[NSBundle mainBundle] pathForResource:[fileName deleteSuffixString] ofType:[fileName suffix]];
}

+ (NSData *)dataForFile:(NSString *)fileName {
	NSError *err = nil;
	NSString *filePath = [self pathForFile:fileName];
	return [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&err];
}

@end
