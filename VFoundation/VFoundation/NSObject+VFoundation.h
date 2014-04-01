//
//  NSObject+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  NSObject' category in VFoundation
 */
@interface NSObject (NSObjectVFoundation)
+ (id)sharedInstance;
/**
 *  Return isEmpty
 *
 *  @return bool
 */
- (BOOL)isEmpty;
/**
 *  Return object all properties like @{ @"propertyType":propertyType, @"name":name, @"vaule":value };
 *
 *  @return
 */
@end
