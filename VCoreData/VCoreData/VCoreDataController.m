//
//  VCoreDataController.m
//  VCoreData
//
//  Created by shadow on 14-4-2.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "VCoreDataController.h"
#import "VCoreData.h"
@interface VCoreDataController () {
	id <VCoreDataPersisterProtocol> _persister;
	VCoreDataCache *_cache;
}

@end
@implementation VCoreDataController
- (id)init {
	self = [super init];
	if (self) {
		_cache = [[VCoreDataCache alloc] init];
		_persister = [VCoreDataSQLPersister sharedInstance];
	}
	return self;
}

- (NSArray *)queryData:(VCoreDataQueryRequest *)request {
	NSArray *result = [_cache queryData:request];
	if (![result isMeaningful]) {
		result = [_persister queryData:request];
		VCoreDataAddRequest *addRequest = [request transformCopy:[VCoreDataAddRequest class]];
		addRequest.classModels = [result arrayWithBlock: ^id (id obj) {
		    return [obj classModel];
		}];
		[_cache addData:addRequest];
	}
	return result;
}

- (BOOL)updateData:(VCoreDataUpdateRequest *)request {
	[_cache updateData:request];
	return [_persister updateData:request];
}

- (BOOL)addData:(VCoreDataAddRequest *)request; {
//	[_cache addData:request];
	return [_persister addData:request];
}

- (BOOL)deleteData:(VCoreDataDelRequest *)request {
	[_cache deleteData:request];
	return [_persister deleteData:request];
}

- (id)executeData:(VCoreDataExecuteRequest *)request {
	return [_persister executeData:request];
}

@end
