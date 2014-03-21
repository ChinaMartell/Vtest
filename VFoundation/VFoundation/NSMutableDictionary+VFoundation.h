//
//  NSMutableDictionary+VFoundation.h
//  VFoundation
//
//  Created by JessieYong on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  NSMutableDictionary' category in VFoundation
 */
@interface NSMutableDictionary (NSMutableDictionaryVFoundation)

/**
 *  Merge the dictionary with another dictionary
 *
 *  @param aMergedDict : the dictionary needs to be merged in
 */
- (void)mergeDictionary:(NSDictionary *)aMergedDict;

- (void)removeFirstObject;
- (void)removeLastObject;
@end
