//
//  VCoreDataController.h
//  VCoreData
//
//  Created by shadow on 14-4-2.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VCoreDataRequest;
@class VCoreDataQueryRequest;
@class VCoreDataUpdateRequest;
@class VCoreDataAddRequest;
@class VCoreDataDelRequest;
@class VCoreDataExecuteRequest;
@interface VCoreDataController : NSObject
- (NSArray *)queryData:(VCoreDataQueryRequest *)request;
- (BOOL)updateData:(VCoreDataUpdateRequest *)request;
- (BOOL)addData:(VCoreDataAddRequest *)request;
- (BOOL)deleteData:(VCoreDataDelRequest *)request;
- (id)executeData:(VCoreDataExecuteRequest *)request;

@end
