//
//  NSString+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSString+VFoundation.h"
#import <CommonCrypto/CommonDigest.h>
#import "AESCrypt.h"
#import "GTMBase64.h"
#import "JSONKit.h"
#import "VFoundationDefine.h"
#import "UIDevice+hardware.h"
#import "KeyChainManager.h"
#import <AdSupport/AdSupport.h>
#import "NSString+HTML.h"
#import "HTMLConverter.h"
#define KEYCHAIN_UDID @"udid"
@implementation NSString (NSStringVFoundation)
+ (NSString *)UDID {
	NSString *udid = [KeyChainManager objectForKey:KEYCHAIN_UDID];
	if (!udid) {
#ifdef IOS_VERSION_OVER_7
		udid = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
#else
		udid = [[UIDevice currentDevice] macAddress];
#endif
	}
	[KeyChainManager setObject:udid forKey:KEYCHAIN_UDID];
	return udid;
}

+ (NSString *)UUID {
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, uuid);
	CFRelease(uuid);
	return (__bridge_transfer NSString *)string;
}

- (NSString *)trim {
	return [self replace:nil ForTarget:@" "];
}

- (NSString *)trimEdge {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)replace:(NSString *)string ForTarget:(NSString *)target {
	if (!string) {
		string = @"";
	}
	if (target) {
		return [self stringByReplacingOccurrencesOfString:target withString:string];
	}
	return self;
}

- (NSString *)replace:(NSString *)string ForTargets:(NSString *)target, ...{
	NSString *result = [self replace:string ForTarget:target];
	va_list argList = nil;
	va_start(argList, target);
	NSString *arg = nil;
	while ((arg = va_arg(argList, NSString *))) {
		result = [result replace:string ForTarget:arg];
	}
	va_end(argList);
	return result;
}
- (BOOL)containString:(NSString *)str {
	return !NSEqualRanges([self rangeOfString:str], NSMakeRange(NSNotFound, 0));
}

- (BOOL)containStrings:(NSString *)str, ...{
	BOOL result = [self containString:str];
	if (!result) {
		va_list argList = nil;
		va_start(argList, str);
		NSString *arg = nil;
		while ((arg = va_arg(argList, NSString *))) {
			result = [self containString:arg];
			if (result == YES) {
				return result;
			}
		}
		va_end(argList);
	}
	return result;
}
- (NSString *)addString:(NSString *)str {
	if (str) {
		return [self stringByAppendingString:str];
	}
	return self;
}

- (NSString *)addStrings:(NSString *)str, ...{
	if (str) {
		NSMutableString *resultStr = [[NSMutableString alloc] initWithFormat:@"%@%@", self, str];
		va_list argList = nil;
		va_start(argList, str);
		NSString *arg = nil;
		while ((arg = va_arg(argList, NSString *))) {
			[resultStr appendString:arg];
		}
		va_end(argList);
		return resultStr;
	}
	return self;
}
- (NSString *)addFormat:(NSString *)format, ...{
	if (format) {
		va_list argList;
		va_start(argList, format);
		NSString *resultStr = [self addString:[[NSString alloc] initWithFormat:format arguments:argList]];
		va_end(argList);
		return resultStr;
	}
	return self;
}
- (NSString *)deleteString:(NSString *)str {
	return [self replace:nil ForTarget:str];
}

- (NSString *)deleteStrings:(NSString *)str, ...{
	NSString *result = [self deleteString:str];
	va_list argList = nil;
	va_start(argList, str);
	NSString *arg = nil;
	while ((arg = va_arg(argList, NSString *))) {
		result = [result deleteString:arg];
	}
	va_end(argList);
	return result;
}
- (BOOL)isMeaningful {
	NSString *tmp = [self trim];
	if (![tmp isEqualToString:@""] && tmp.length > 0 && ![tmp isEqual:[NSNull null]]) {
		return YES;
	}
	return NO;
}

@end
@implementation NSString (NSStringFile)


@end

@implementation NSString (NSStringURL)
- (NSString *)scheme {
	return [[NSURL URLWithString:[self URLEncodeAbsoluteString]] scheme];
}

- (NSString *)host {
	return [[NSURL URLWithString:[self URLEncodeAbsoluteString]] host];
}

- (NSNumber *)port {
	NSURL *url = [NSURL URLWithString:[self URLEncodeAbsoluteString]];
	NSNumber *port = [url port];
	return port;
}

- (NSString *)bin {
	NSURL *url = [NSURL URLWithString:[self URLEncodeAbsoluteString]];
	return [url path];
}

- (NSString *)lastURLString {
	NSString *host = [self host];
	return [[self URLEncodeAbsoluteString] deleteString:host];
}

- (NSString *)parameterForKey:(NSString *)key {
	NSDictionary *parameters = [self parameters];
	return [parameters objectForKey:key];
}

- (NSDictionary *)parameters {
	NSURL *url = [NSURL URLWithString:[self URLEncodeAbsoluteString]];
	NSString *parameters = [url query];
	NSArray *parameterArray = [parameters componentsSeparatedByString:@"&"];
	NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
	for (NSString *kv in parameterArray) {
		NSArray *kvArray = [kv componentsSeparatedByString:@"="];
		[result setObject:kvArray[1] forKey:kvArray[0]];
	}
	return result;
}

- (NSString *)URLEncodeString {
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
	                                                                                         (CFStringRef)self, nil,
	                                                                                         (CFStringRef)@"!*'();:@&=+$,/?%#[]", C_DEFAULT_ENCODING));
	return result;
}

- (NSString *)URLDecodeString {
	NSString *result = [(NSString *)self stringByReplacingOccurrencesOfString : @"+" withString : @" "];
	result = [result stringByReplacingPercentEscapesUsingEncoding:DEFAULT_ENCODING];
	return result;
}

- (NSString *)URLEncodeAbsoluteString {
	if ([self containString:@"://"]) {
		NSURL *url = [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(C_DEFAULT_ENCODING)]];
		NSString *scheme = [[[url scheme] URLEncodeString] addString:@"://"];
		NSString *host = [[url host] URLEncodeString];
		NSArray *binTmpArray = [url pathComponents];
		NSMutableArray *mBinArray = [[NSMutableArray alloc] init];
		for (NSString *str in binTmpArray) {
			NSString *strEncoded = str;
			if (![str isEqualToString:@"/"]) {
				strEncoded = [str URLEncodeString];
			}
			[mBinArray addObject:strEncoded];
		}
		NSArray *parameterTmpArray = [[url query] componentsSeparatedByString:@"&"];
		NSMutableArray *mParameterArray = [[NSMutableArray alloc] init];
		for (NSString *kv in parameterTmpArray) {
			NSArray *kvArray = [kv componentsSeparatedByString:@"="];
			[mParameterArray addObject:[[kvArray[0] URLEncodeString] addString:[kvArray[1] URLEncodeString]]];
		}
		return [scheme addStrings:host, [mBinArray componentsJoinedByString:@""], [mParameterArray componentsJoinedByString:@""], nil];
	}
	return self;
}

- (NSString *)URLDecodeAbsoluteString {
	if ([self containString:@"://"]) {
		NSURL *url = [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(C_DEFAULT_ENCODING)]];
		NSString *scheme = [[[url scheme] URLDecodeString] addString:@"://"];
		NSString *host = [[url host] URLDecodeString];
		NSArray *binTmpArray = [url pathComponents];
		NSMutableArray *mBinArray = [[NSMutableArray alloc] init];
		for (NSString *str in binTmpArray) {
			NSString *strEncoded = str;
			if (![str isEqualToString:@"/"]) {
				strEncoded = [str URLDecodeString];
			}
			[mBinArray addObject:strEncoded];
		}
		NSArray *parameterTmpArray = [[url query] componentsSeparatedByString:@"&"];
		NSMutableArray *mParameterArray = [[NSMutableArray alloc] init];
		for (NSString *kv in parameterTmpArray) {
			NSArray *kvArray = [kv componentsSeparatedByString:@"="];
			[mParameterArray addObject:[[kvArray[0] URLDecodeString] addString:[kvArray[1] URLDecodeString]]];
		}
		return [scheme addStrings:host, [mBinArray componentsJoinedByString:@""], [mParameterArray componentsJoinedByString:@""], nil];
	}
	return self;
}

@end

@implementation NSString (NSStringCrypto)
- (NSString *)MD5Sum {
	const char *cStr = [self UTF8String];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, strlen(cStr), digest);
	NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
		[result appendFormat:@"%02x", digest[i]];
	return result;
}

- (NSString *)MD516Sum {
	NSString *md5_32Bit_String = [self MD5Sum];
	NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];
	return result;
}

- (NSString *)SHA1Sum {
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:self.length];
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(data.bytes, data.length, digest);
	NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
		[result appendFormat:@"%02x", digest[i]];
	}
	return result;
}

- (NSString *)SHA256Sum {
	const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:self.length];
	uint8_t digest[CC_SHA256_DIGEST_LENGTH];
	CC_SHA1(data.bytes, data.length, digest);
	NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
	for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
		[result appendFormat:@"%02x", digest[i]];
	}
	return result;
}

- (NSString *)base64EncodeString {
	NSData *data = [self dataUsingEncoding:DEFAULT_ENCODING];
	return [GTMBase64 stringByEncodingData:data];
}

- (NSString *)base64DecodeString {
	NSString *result = [[NSString alloc] initWithData:[GTMBase64 decodeString:self] encoding:DEFAULT_ENCODING];
	return result;
}

- (NSString *)AESEncryptForKey:(NSString *)key {
	return [AESCrypt encrypt:self password:key];
}

- (NSString *)AESDecryptForKey:(NSString *)key {
	return [AESCrypt decrypt:self password:key];
}

@end
@implementation NSString (NSStringHTML)
- (NSString *)toText {
	return [self stringByConvertingHTMLToPlainText];
}

- (NSString *)toHTML {
	return [[[HTMLConverter alloc] init] toHTML:self];
}

- (NSString *)escapeHTML {
	NSMutableString *result = [NSMutableString string];
	NSUInteger start = 0;
	NSUInteger len = [self length];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\"…"];

	while (start < len) {
		NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len - start)];
		if (r.location == NSNotFound) {
			[result appendString:[self substringFromIndex:start]];
			break;
		}

		if (start < r.location) {
			[result appendString:[self substringWithRange:NSMakeRange(start, r.location - start)]];
		}
		unichar c = [self characterAtIndex:r.location];
		if (c == '<') {
			[result appendString:@"&lt;"];
		}
		else if (c == '>') {
			[result appendString:@"&gt;"];
		}
		else if (c == '"') {
			[result appendString:@"&quot;"];
		}
		else if (c == [NSString quote:@"…"]) {
			[result appendString:@"&hellip;"];
		}
		else if (c == '&') {
			[result appendString:@"&amp;"];
		}
		start = r.location + 1;
	}

	return result;
}

- (NSString *)unEscapeHTML {
	NSMutableString *result = [NSMutableString string];
	NSMutableString *target = [self mutableCopy];
	NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];

	while ([target length] > 0) {
		NSRange r = [target rangeOfCharacterFromSet:chs];
		if (r.location == NSNotFound) {
			[result appendString:target];
			break;
		}

		if (r.location > 0) {
			[result appendString:[target substringToIndex:r.location]];
			[target deleteCharactersInRange:NSMakeRange(0, r.location)];
		}

		if ([target hasPrefix:@"&lt;"]) {
			[result appendString:@"<"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		}
		else if ([target hasPrefix:@"&gt;"]) {
			[result appendString:@">"];
			[target deleteCharactersInRange:NSMakeRange(0, 4)];
		}
		else if ([target hasPrefix:@"&quot;"]) {
			[result appendString:@"\""];
			[target deleteCharactersInRange:NSMakeRange(0, 6)];
		}
		else if ([target hasPrefix:@"&#39;"]) {
			[result appendString:@"'"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		}
		else if ([target hasPrefix:@"&amp;"]) {
			[result appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 5)];
		}
		else if ([target hasPrefix:@"&hellip;"]) {
			[result appendString:@"…"];
			[target deleteCharactersInRange:NSMakeRange(0, 8)];
		}
		else {
			[result appendString:@"&"];
			[target deleteCharactersInRange:NSMakeRange(0, 1)];
		}
	}

	return result;
}

+ (unichar)quote:(NSString *)string {
	if ([string isMeaningful]) {
		return [string characterAtIndex:0];
	}
	return '0';
}

@end
