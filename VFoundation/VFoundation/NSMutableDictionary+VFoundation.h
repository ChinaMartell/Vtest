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
/**
 *  Make safe when set nil object or nil key
 *
 *  @param mDict    receiver
 *  @param anObject Can be nil
 *  @param aKey     Can be nil
 *
 *  @return If set successfully it will be return YES,otherwise NO
 */
bool setObject(NSMutableDictionary *mDict, id object, id key);


@end
