//
//  NSMutableArray+VFoundation.h
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  NSMutableArray的扩展，主要是添加常用函数，方便开放
 */
@interface NSMutableArray (VFoundation)

@end



/**
 *  NSMutableArray的子类，用于扩展其功能，也防止object为nil的crash
 */
@interface VNSMutableArray : NSMutableArray

@end
