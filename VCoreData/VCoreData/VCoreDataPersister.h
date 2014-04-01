//
//  VCoreDataPersister.h
//  VCoreData
//
//  Created by shadow on 14-3-28.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VCoreDataRequest;
@class VCoreDataQueryRequest;
@class VCoreDataUpdateRequest;
@class VCoreDataDelRequest;
/**
 *  VCoreDataPersisterProtocol
 */
@protocol VCoreDataPersisterProtocol <NSObject>
- (NSArray *)queryData:(VCoreDataQueryRequest *)request;
- (BOOL)updateData:(VCoreDataUpdateRequest *)request;
- (BOOL)addData:(NSArray *)objs;
- (BOOL)deleteData:(VCoreDataDelRequest *)request;
@end
