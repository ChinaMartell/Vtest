//
//  NSObject+NSObjectVCoreData.m
//  VCoreData
//
//  Created by shadow on 14-3-28.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSObject+NSObjectVCoreData.h"
#import "VCoreData.h"
@implementation NSObject (NSObjectVCoreData)

- (VCoreDataClassModel *)classModel {
	VCoreDataClassModel *model = [[VCoreDataClassModel alloc] init];
	model.modelInstance = self;
	return model;
}

+ (VCoreDataClassModel *)classModel {
	id obj = [[self alloc] init];
	return [obj classModel];
}

- (BOOL)put {
	return [[VCoreDataSQLPersister sharedInstance] addData:@[[self classModel]]];
}

+ (BOOL)puts:(NSArray *)array {
	return [[VCoreDataSQLPersister sharedInstance] addData:[array arrayWithBlock: ^id (id obj) {
	    return [obj classModel];
	}]];
}

- (NSArray *)all {
	return [self get:nil];
}

+ (NSArray *)all {
	return [self get:nil];
}

- (NSArray *)get:(NSString *)filter {
	VCoreDataQueryRequest *queryRequest = [[VCoreDataQueryRequest alloc] init];
	queryRequest.filter = filter;
	queryRequest.propertyModels = [[self classModel] allPropertyModels];
	queryRequest.resultClassModel = [self classModel];
	queryRequest.classModels = @[[self classModel]];
	return [[VCoreDataSQLPersister sharedInstance] queryData:queryRequest];
}

+ (NSArray *)get:(NSString *)filter {
	id obj = [[self alloc] init];
	return [obj get:filter];
}

- (NSArray *)get:(NSString *)filter properties:(NSArray *)array {
	NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
	for (NSString *str in array) {
		VCoreDataPropertyModel *propertyModel = [[self classModel] propertyModel:str];
		[propertyArray addObject:propertyModel];
	}
	VCoreDataQueryRequest *queryRequest = [[VCoreDataQueryRequest alloc] init];
	queryRequest.filter = filter;
	queryRequest.propertyModels = propertyArray;
	queryRequest.resultClassModel = [self classModel];
	queryRequest.classModels = @[[self classModel]];
	return [[VCoreDataSQLPersister sharedInstance] queryData:queryRequest];
}

+ (NSArray *)get:(NSString *)filter properties:(NSArray *)array {
	id obj = [[self alloc] init];
	return [obj get:filter properties:array];
}

+ (NSArray *)gets:(NSArray *)objs filter:(NSString *)filter properties:(NSArray *)array result:(Class)resultClass {
	NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
	for (NSString *str in array) {
		for (id obj in objs) {
			VCoreDataPropertyModel *propertyModel = [obj propertyModel:str];
			if (propertyModel) {
				[propertyArray addObject:propertyModel];
				break;
			}
		}
	}
	VCoreDataQueryRequest *queryRequest = [[VCoreDataQueryRequest alloc] init];
	queryRequest.filter = filter;
	queryRequest.propertyModels = propertyArray;
	queryRequest.resultClassModel = [resultClass classModel];
	queryRequest.classModels = [objs arrayWithBlock: ^id (id obj) {
	    return [obj classModel];
	}];
	return [[VCoreDataSQLPersister sharedInstance] queryData:queryRequest];
}

- (BOOL)update {
	return [self update:nil];
}

- (BOOL)update:(NSString *)filter {
	VCoreDataUpdateRequest *updateRequest = [[VCoreDataUpdateRequest alloc] init];
	updateRequest.filter = filter;
	updateRequest.propertyModels = [[self classModel] allPropertyModels];
	updateRequest.classModels = @[[self classModel]];
	return [[VCoreDataSQLPersister sharedInstance] updateData:updateRequest];
}

+ (BOOL)update:(NSString *)filter {
	id obj = [[self alloc] init];
	return [obj update:filter];
}

- (BOOL)update:(NSString *)filter properties:(NSArray *)array {
	NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
	for (NSString *str in array) {
		VCoreDataPropertyModel *propertyModel = [[self classModel] propertyModel:str];
		[propertyArray addObject:propertyModel];
	}
	VCoreDataUpdateRequest *updateRequest = [[VCoreDataUpdateRequest alloc] init];
	updateRequest.filter = filter;
	updateRequest.propertyModels = propertyArray;
	updateRequest.classModels = @[[self classModel]];

	return [[VCoreDataSQLPersister sharedInstance] updateData:updateRequest];
}

+ (BOOL)update:(NSString *)filter properties:(NSArray *)array {
	id obj = [[self alloc] init];
	return [obj update:filter properties:array];
}

+ (BOOL)updates:(NSArray *)objs filter:(NSString *)filter properties:(NSArray *)array {
	NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
	for (NSString *str in array) {
		for (id obj in objs) {
			VCoreDataPropertyModel *propertyModel = [obj propertyModel:str];
			if (propertyModel) {
				[propertyArray addObject:propertyModel];
				break;
			}
		}
	}
	VCoreDataUpdateRequest *updateRequest = [[VCoreDataUpdateRequest alloc] init];
	updateRequest.filter = filter;
	updateRequest.propertyModels = propertyArray;
	updateRequest.classModels = [objs arrayWithBlock: ^id (id obj) {
	    return [obj classModel];
	}];
	return [[VCoreDataSQLPersister sharedInstance] updateData:updateRequest];
}

- (BOOL)clear {
	return [self del:nil];
}

+ (BOOL)clear {
	return [self del:nil];
}

- (BOOL)del:(NSString *)filter {
	VCoreDataDelRequest *delRequest = [[VCoreDataDelRequest alloc] init];
	delRequest.filter = filter;
	delRequest.propertyModels = [[self classModel] allPropertyModels];
	delRequest.classModels = @[[self classModel]];
	return [[VCoreDataSQLPersister sharedInstance] deleteData:delRequest];
}

+ (BOOL)del:(NSString *)filter {
	id obj = [[self alloc] init];
	return [obj del:filter];
}

+ (BOOL)del:(NSArray *)objs filter:(NSString *)filter {
	VCoreDataDelRequest *delRequest = [[VCoreDataDelRequest alloc] init];
	delRequest.filter = filter;
	delRequest.propertyModels = [[self classModel] allPropertyModels];
	delRequest.classModels = [objs arrayWithBlock: ^id (id obj) {
	    return [obj classModel];
	}];
	return [[VCoreDataSQLPersister sharedInstance] deleteData:delRequest];
}

#pragma mark - NSObect nscoding
- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [self init]) {
		for (VCoreDataPropertyModel *propertyModel in[[self classModel] allPropertyModels]) {
			NSString *name = propertyModel.name;
			[self setValue:[decoder decodeObjectForKey:name] forKey:name];
		}
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
	for (VCoreDataPropertyModel *propertyModel in[[self classModel] allPropertyModels]) {
		NSString *name = propertyModel.name;
		NSString *value = propertyModel.value;
		[encoder encodeObject:value forKey:name];
	}
}

#pragma mark - NSObect nscopying
- (id)copyWithZone:(NSZone *)zone {
	id result = [[[self class] allocWithZone:zone] init];
	for (VCoreDataPropertyModel *propertyModel in[[result classModel] allPropertyModels]) {
		NSString *name = propertyModel.name;
		[result setValue:[self valueForKey:name] forKey:name];
	}
	return result;
}

#pragma mark - NSObect nsmutablecopying
- (id)mutableCopyWithZone:(NSZone *)zone {
	id result = [[[self class] allocWithZone:zone] init];
	for (VCoreDataPropertyModel *propertyModel in[[result classModel] allPropertyModels]) {
		NSString *name = propertyModel.name;
		[result setValue:[self valueForKey:name] forKey:name];
	}
	return result;
}

@end
