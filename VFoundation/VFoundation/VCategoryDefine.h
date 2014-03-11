//
//  VCategoryDefine.h
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionary+VFoundation.h"
#import "NSMutableArray+VFoundation.h"

@interface VCategoryDefine : NSObject
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

/**
 *  Make safe when add nil object or nil key
 *
 *  @param mArray receiver
 *  @param object Can be nil
 *
 *  @return If set successfully it will be return YES,otherwise NO
 */
bool addObject(NSMutableArray *mArray, id object);

@end
