//
//  NSObject+NSObjectVCoreData.h
//  VCoreData
//
//  Created by shadow on 14-3-28.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCoreDataDefine.h"

@class VCoreDataClassModel;


@protocol NSDeepCopying <NSObject>
- (id)deepCopy;
@end
@protocol NSTransformCopying <NSObject>

- (id)transformCopy:(Class)class;

@end

/**
 *  NSObject' category in VCoreData
 */
@interface NSObject (NSObjectVCoreData) <NSCoding, NSCopying, NSMutableCopying, NSDeepCopying, NSTransformCopying>

- (VCoreDataClassModel *)classModel;
+ (VCoreDataClassModel *)classModel;

- (BOOL)put;
+ (BOOL)puts:(NSArray *)array;

- (NSArray *)all;
+ (NSArray *)all;
- (NSArray *)get:(NSString *)str;
+ (NSArray *)get:(NSString *)str;
- (NSArray *)get:(NSString *)str properties:(NSArray *)array;
+ (NSArray *)get:(NSString *)str properties:(NSArray *)array;
+ (NSArray *)gets:(NSArray *)objs filter:(NSString *)str properties:(NSArray *)array result:(Class)resultClass;


- (BOOL)update;
- (BOOL)update:(NSString *)str;
+ (BOOL)update:(NSString *)str;
- (BOOL)update:(NSString *)str properties:(NSArray *)array;
+ (BOOL)update:(NSString *)str properties:(NSArray *)array;
+ (BOOL)updates:(NSArray *)objs filter:(NSString *)str properties:(NSArray *)array;


- (BOOL)clear;
+ (BOOL)clear;
- (BOOL)del:(NSString *)str;
+ (BOOL)del:(NSString *)str;
+ (BOOL)del:(NSArray *)objs filter:(NSString *)str;

- (id)execute:(NSString *)command params:(id)param, ...NS_REQUIRES_NIL_TERMINATION;
+ (id)execute:(NSString *)command params:(id)param, ...NS_REQUIRES_NIL_TERMINATION;
- (id)executeWithPersisterType:(VCoreDataPersisterType)type command:(NSString *)command params:(id)param, ...NS_REQUIRES_NIL_TERMINATION;
+ (id)executeWithPersisterType:(VCoreDataPersisterType)type command:(NSString *)command params:(id)param, ...NS_REQUIRES_NIL_TERMINATION;


@end




@interface NSObject (NSObjectVCoreDataType)
- (id)objectType;
- (VCoreDataType)dataType;
+ (NSString *)dataTypeToString:(VCoreDataType)type;
@end
