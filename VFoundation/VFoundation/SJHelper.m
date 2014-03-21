//
//  SJHelper.m
//  VFoundation
//
//  Created by JessieYong on 14-3-20.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "SJHelper.h"

@implementation SJHelper

static SJHelper *sharedHelper = nil;
+ (SJHelper*)sharedHelper
{
    @synchronized(self) {
        if (sharedHelper == nil) {
            sharedHelper = [[self alloc] init]; // assignment not done here
        }
    }
    return sharedHelper;
}


-(void)swizzlingMethod:(Method)aMethod withAnotherMethod:(Method)anotherMethod{
    method_exchangeImplementations(aMethod, anotherMethod);

}
@end
