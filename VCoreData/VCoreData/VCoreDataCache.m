//
//  VCoreDataCache.m
//  VCoreData
//
//  Created by shadow on 14-3-28.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "VCoreDataCache.h"
#import "VCoreData.h"
typedef NS_ENUM (NSInteger, VCoreDataCacheLevel) {
	VCoreDataCacheLevelFirst,
	VCoreDataCacheLevelSecond,
};


@interface VCoreDataCache () {
	NSCache *_firstCache;
	NSCache *_secondCache;
}


@end
@implementation VCoreDataCache
- (id)init {
	self = [super init];
	if (self) {
		_firstCache = [[NSCache alloc] init];
		_secondCache = [[NSCache alloc] init];
	}
	return self;
}

- (NSArray *)queryData:(VCoreDataQueryRequest *)request {
	NSMutableArray *result = [[NSMutableArray alloc] init];
	BOOL isMeanful = [request.filter isMeaningful];
	NSArray *paramArray = [[request.filter trim] componentsSeparatedByString:@"="];
	BOOL isParsed = (paramArray.count == 2);
	if (!isMeanful || (isMeanful && isParsed)) {
		for (VCoreDataClassModel *model in request.classModels) {
			NSMutableDictionary *classDict = [_firstCache objectForKey:[model modelName]];
			if (isMeanful) {
				NSString *name = [paramArray firstObject];
				id value = [paramArray lastObject];
				NSMutableDictionary *propertyDict = [classDict objectForKey:name];
				NSMutableDictionary *propertyValueDict = [propertyDict objectForKey:value];
				NSArray *array = [[propertyValueDict allValues] arrayWithBlock: ^id (id obj, NSInteger index) {
				    return [obj allValues];
				}];
				[result addObjectsFromArray:array];
			}
			else {
				VCoreDataPropertyModel *primaryModel = [model primaryPropertyModel];
				NSString *name = primaryModel.name;
				NSMutableDictionary *propertyDict = [classDict objectForKey:name];
				[result addObjectsFromArray:[[propertyDict allValues] arrayWithBlock: ^id (id pValueArray, NSInteger index) { //property value dict
				    return [[pValueArray allValues] arrayWithBlock: ^id (id primaryArray, NSInteger index) { //p-v-k-v
				        return [[primaryArray allValues] arrayWithBlock: ^id (id ob3, NSInteger index) {
				            return [ob3 allValues];
						}];
					}];
				}]];
			}
		}
		return result;
	}
	if (![result isMeaningful]) { //to get second cache
		NSMutableDictionary *classDict = [_secondCache objectForKey:[[request.classModels arrayWithBlock: ^id (id obj, NSInteger index) {
		    return [obj modelName];
		}] componentsJoinedByString:@"__"]];
		[result addObjectsFromArray:[classDict objectForKey:request.filter]];
		return result;
	}
	return nil;
}

- (BOOL)updateData:(VCoreDataUpdateRequest *)request {
	return [self addData:[request transformCopy:[VCoreDataAddRequest class]]];
}

- (BOOL)addData:(VCoreDataAddRequest *)request {
	for (VCoreDataClassModel *model in request.classModels) {
		NSMutableDictionary *classDict = [_firstCache objectForKey:[model modelName]];
		if (!classDict) {
			classDict = [[NSMutableDictionary alloc] init];
		}
		VCoreDataPropertyModel *primaryModel = [model primaryPropertyModel];
		for (VCoreDataPropertyModel *propertyModel in[model allPropertyModels]) {
			if (propertyModel.type != VCoreDataTypeBlob && primaryModel.type != VCoreDataTypeBlob) {
				NSMutableDictionary *propertyDict = [classDict objectForKey:propertyModel.name];
				if (!propertyDict) {
					propertyDict = [[NSMutableDictionary alloc] init];
				}
				[propertyDict setObject:@{ primaryModel.value:model.modelInstance } forKey:propertyModel.value];
				[classDict setObject:propertyDict forKey:propertyModel.name];
			}
		}
		[_firstCache setObject:classDict forKey:[model modelName]];

		//second cache
		NSString *secondCacheClassKey = [[request.classModels arrayWithBlock: ^id (id obj, NSInteger index) {
		    return [obj modelName];
		}] componentsJoinedByString:@"__"];
		NSMutableDictionary *classDictSecond = [_secondCache objectForKey:secondCacheClassKey];
		if (!classDictSecond) {
			classDictSecond = [[NSMutableDictionary alloc] init];
		}
		[classDictSecond setObject:request.classModels forKey:request.filter];
		[_secondCache setObject:classDictSecond forKey:secondCacheClassKey];
	}
	return YES;
}

- (BOOL)deleteData:(VCoreDataDelRequest *)request {
	BOOL isMeanful = [request.filter isMeaningful];
	NSArray *paramArray = [[request.filter trim] componentsSeparatedByString:@"="];
	BOOL isParsed = (paramArray.count == 2);
	if (!isMeanful || (isMeanful && isParsed)) {
		for (VCoreDataClassModel *model in request.classModels) {
			if (isMeanful) {
				NSString *name = [paramArray firstObject];
				id value = [paramArray lastObject];
				NSMutableDictionary *classDict = [_firstCache objectForKey:[model modelName]];
				NSMutableDictionary *propertyDict = [classDict objectForKey:name];
				[propertyDict removeObjectForKey:value];
			}
			else {
				[_firstCache removeObjectForKey:[model modelName]];
			}
		}
	}
	else {
		return NO;
	}
	return YES;
}

@end
