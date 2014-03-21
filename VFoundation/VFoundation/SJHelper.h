//
//  SJHelper.h
//  VFoundation
//
//  Created by JessieYong on 14-3-20.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface SJHelper : NSObject
+ (SJHelper *)sharedHelper;
- (void)swizzlingMethod:(Method)aMethod withAnotherMethod:(Method)anotherMethod;
@end
