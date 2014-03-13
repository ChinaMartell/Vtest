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

@end
@interface NSString (NSStringUrl)
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
- (NSString *)lastUrl;
/**
 *  URL paramter like @{@"name":@"shadow"}
 *
 *  @return key-value
 */
- (NSDictionary *)parameters;
/**
 *  URL encode parameter for key
 *
 *  @param key of the parameter
 *
 *  @return encodedString
 */
- (NSString *)encodeParameter:(NSString *)key;
/**
 *  URL encode Don' invoke over once
 *
 *  @return urlString
 */
- (NSString *)urlEncode;




@end
@interface NSString (NSStringJson)

@end
