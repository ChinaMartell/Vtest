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
 *  It is the best replacement of isEmpty that string does not include @"",[NSNull null],and nil
 *
 *  @return bool
 */
- (BOOL)isMeaningful;

@end
