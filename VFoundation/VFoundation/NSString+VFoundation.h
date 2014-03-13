//
//  NSString+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
/**
 *  NSString' category in VFoundation
 */
@interface NSString (NSStringVFoundation)
/**
 *  UUID get unique string
 *
 *  @return string
 */
- (NSString *)UUID;
/**
 *  Trim the entire string default
 *
 *  @return string
 */
- (NSString *)trim;
/**
 *  Trim only string edge
 *
 *  @return string
 */
- (NSString *)trimEdge;
/**
 *  Replace with the specified string
 *
 *  @param str
 *
 *  @return replaced string
 */
- (NSString *)replaceString:(NSString *)str;
/**
 *  Replace with the specified strings
 *
 *  @param str ...
 *
 *  @return replaced string
 */
- (NSString *)replaceStrings:(NSString *)str, ...NS_REQUIRES_NIL_TERMINATION;
/**
 *  Is contain the specified string
 *
 *  @param str
 *
 *  @return bool
 */
- (BOOL)containString:(NSString *)str;
/**
 *  Is contain the specified strings
 *
 *  @param str ...
 *
 *  @return bool
 */
- (BOOL)containStrings:(NSString *)str, ...NS_REQUIRES_NIL_TERMINATION;
/**
 *  It is the best replacement of isEmpty that string does not include @"",[NSNull null],and nil
 *
 *  @return bool
 */
- (BOOL)isMeaningful;
@end
@interface NSString (NSStringURL)
/**
 *  URL scheme like "http"
 *
 *  @return scheme
 */
- (NSString *)scheme;
/**
 *  URL host like "www.baidu.com"
 *
 *  @return host
 */
- (NSString *)host;
/**
 *  URL port lke "8080"
 *
 *  @return port
 */
- (NSNumber *)port;
/**
 *  URL bin like "www.baidu.com/search?txt=VFoundation" inside the "search"
 *
 *  @return bin
 */
- (NSString *)bin;
/**
 *  URL lastUrl by deleted the host like "/search?txt...."
 *
 *  @return lastUrlString
 */
- (NSString *)lastURL;
/**
 *  URL parameter for key
 *
 *  @param key
 *
 *  @return parameter value
 */
- (NSString *)parameterForKey:(NSString *)key;
/**
 *  URL paramter like @{@"name":@"shadow"} without encoded
 *
 *  @return key-value
 */
- (NSDictionary *)parameters;
/**
 *  URL encode if you want to auto encode like http:www.baidu.com/search?txt=VFoundation,you can use [NSString URLEncodeAbsoluteString]
 *
 *  @return urlString
 */
- (NSString *)URLEncodeString;
/**
 *  URL decode  if you want to auto decode like http:www.baidu.com/search?txt=VFoundation,you can use [NSString URLDecodeAbsoluteString]
 *
 *  @return string
 */
- (NSString *)URLDecodeString;
/**
 *  URL auto encode url,Recommend
 *
 *  @return encoded absoluteString
 */
- (NSString *)URLEncodeAbsoluteString;
/**
 *  URL auto decode url,Recommend
 *
 *  @return decoded absoluteString
 */
- (NSString *)URLDecodeAbsoluteString;

@end
@interface NSString (NSStringEncryption)
/**
 *  MD5 summarise 32 bit string
 *
 *  @return string
 */
- (NSString *)MD5Sum;
/**
 *  SHA1 summarise 32 bit string
 *
 *  @return string
 */
- (NSString *)SHA1Sum;
/**
 *  SHA256 summarise 32 bit string
 *
 *  @return string
 */
- (NSString *)SHA256Sum;
/**
 *  Base64 encode string
 *
 *  @return string
 */
- (NSString *)base64EncodeString;
/**
 *  Base64 decode string
 *
 *  @return string
 */
- (NSString *)base64decodeString;
/**
 *  AES encrypt string
 *
 *  @param key encrypt key
 *
 *  @return encrypted string
 */
- (NSString *)AESEncryptForKey:(NSString *)key;
/**
 *  AES decrypt string
 *
 *  @param key decrypt key
 *
 *  @return origin string
 */
- (NSString *)AESDecryptForKey:(NSString *)key;

@end
@interface NSString (NSStringHTML)
/**
 *  Remove all about html tag,style that only plain text
 *
 *  @return plain string
 */
- (NSString *)toText;

@end

@interface NSString (NSStringJSON)

@end
