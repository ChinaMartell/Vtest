//
//  NSMutableDictionary+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSMutableDictionary' category in VFoundation
 */
@interface NSMutableDictionary (VFoundation)

- (BOOL)removeObject:(id)aObject;
- (void)mergeDictionary:(NSDictionary*)aMergedDict;

@end
