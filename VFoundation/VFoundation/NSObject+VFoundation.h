//
//  NSObject+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (VFoundation)
/**
 *  Get the safeClass that prevent crash when setObject is nil and so on
 *
 *  @return safeClass
 */
+ (Class)safeClass;
@end
