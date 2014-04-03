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
	VCoreDataAddRequest *addRequest = [[VCoreDataAddRequest alloc] init];
	addRequest.classModels = @[[self classModel]];
	return [[VCoreDataController sharedInstance] addData:addRequest];
}

+ (BOOL)puts:(NSArray *)array {
	VCoreDataAddRequest *addRequest = [[VCoreDataAddRequest alloc] init];
	addRequest.classModels = [array arrayWithBlock: ^id (id obj) {
	    return [obj classModel];
	}];
	return [[VCoreDataController sharedInstance] addData:addRequest];
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
	return [[VCoreDataController sharedInstance] queryData:queryRequest];
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
	return [[VCoreDataController sharedInstance] queryData:queryRequest];
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
	return [[VCoreDataController sharedInstance] queryData:queryRequest];
}

- (BOOL)update {
	return [self update:nil];
}

- (BOOL)update:(NSString *)filter {
	VCoreDataUpdateRequest *updateRequest = [[VCoreDataUpdateRequest alloc] init];
	updateRequest.filter = filter;
	updateRequest.propertyModels = [[self classModel] allPropertyModels];
	updateRequest.classModels = @[[self classModel]];
	return [[VCoreDataController sharedInstance] updateData:updateRequest];
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

	return [[VCoreDataController sharedInstance] updateData:updateRequest];
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
	return [[VCoreDataController sharedInstance] updateData:updateRequest];
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
	return [[VCoreDataController sharedInstance] deleteData:delRequest];
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
	return [[VCoreDataController sharedInstance] deleteData:delRequest];
}

- (id)execute:(NSString *)command params:(id)param, ...{
	NSMutableArray *paramArray = [[NSMutableArray alloc] init];
	VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
	propertyModel.name = nil;
	propertyModel.propertyType = [param objectType];
	propertyModel.type = [param dataType];
	propertyModel.value = param;
	[paramArray addObject:propertyModel];

	va_list argList = nil;
	va_start(argList, param);
	id arg = nil;
	while ((arg = va_arg(argList, id))) {
		VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
		propertyModel.name = nil;
		propertyModel.propertyType = [arg objectType];
		propertyModel.type = [arg dataType];
		propertyModel.value = arg;
		[paramArray addObject:propertyModel];
	}
	va_end(argList);
	VCoreDataExecuteRequest *exexuteRequest = [[VCoreDataExecuteRequest alloc] init];
	exexuteRequest.command = command;
	exexuteRequest.paramArray = paramArray;
	return [[VCoreDataController sharedInstance] executeData:exexuteRequest];
}

+ (id)execute:(NSString *)command params:(id)param, ...{
	NSMutableArray *paramArray = [[NSMutableArray alloc] init];
	VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
	propertyModel.name = nil;
	propertyModel.propertyType = [param objectType];
	propertyModel.type = [param dataType];
	propertyModel.value = param;
	[paramArray addObject:propertyModel];

	va_list argList = nil;
	va_start(argList, param);
	id arg = nil;
	while ((arg = va_arg(argList, id))) {
		VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
		propertyModel.name = nil;
		propertyModel.propertyType = [arg objectType];
		propertyModel.type = [arg dataType];
		propertyModel.value = arg;
		[paramArray addObject:propertyModel];
	}
	va_end(argList);
	VCoreDataExecuteRequest *exexuteRequest = [[VCoreDataExecuteRequest alloc] init];
	exexuteRequest.command = command;
	exexuteRequest.paramArray = paramArray;
	return [[VCoreDataController sharedInstance] executeData:exexuteRequest];
}

- (id)executeWithPersisterType:(VCoreDataPersisterType)type command:(NSString *)command params:(id)param, ...{
	NSMutableArray *paramArray = [[NSMutableArray alloc] init];
	VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
	propertyModel.name = nil;
	propertyModel.propertyType = [param objectType];
	propertyModel.type = [param dataType];
	propertyModel.value = param;
	[paramArray addObject:propertyModel];

	va_list argList = nil;
	va_start(argList, param);
	id arg = nil;
	while ((arg = va_arg(argList, id))) {
		VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
		propertyModel.name = nil;
		propertyModel.propertyType = [arg objectType];
		propertyModel.type = [arg dataType];
		propertyModel.value = arg;
		[paramArray addObject:propertyModel];
	}
	va_end(argList);
	VCoreDataExecuteRequest *exexuteRequest = [[VCoreDataExecuteRequest alloc] init];
	exexuteRequest.command = command;
	exexuteRequest.paramArray = paramArray;
	return [[VCoreDataController sharedInstance] executeData:exexuteRequest];
}

+ (id)executeWithPersisterType:(VCoreDataPersisterType)type command:(NSString *)command params:(id)param, ...{
	NSMutableArray *paramArray = [[NSMutableArray alloc] init];
	VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
	propertyModel.name = nil;
	propertyModel.propertyType = [param objectType];
	propertyModel.type = [param dataType];
	propertyModel.value = param;
	[paramArray addObject:propertyModel];

	va_list argList = nil;
	va_start(argList, param);
	id arg = nil;
	while ((arg = va_arg(argList, id))) {
		VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
		propertyModel.name = nil;
		propertyModel.propertyType = [arg objectType];
		propertyModel.type = [arg dataType];
		propertyModel.value = arg;
		[paramArray addObject:propertyModel];
	}
	va_end(argList);
	VCoreDataExecuteRequest *exexuteRequest = [[VCoreDataExecuteRequest alloc] init];
	exexuteRequest.command = command;
	exexuteRequest.paramArray = paramArray;
	return [[VCoreDataController sharedInstance] executeData:exexuteRequest];
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

#pragma mark - NSObect nsdeepcopying
- (id)deepCopy {
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
	return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

#pragma mark - NSObect nstransformcopying
- (id)transformCopy:(Class)class {
	id result = [[class alloc] init];
	for (VCoreDataPropertyModel *propertyModel in[[result classModel] allPropertyModels]) {
		NSString *name = propertyModel.name;
		[result setValue:[self valueForKey:name] forKey:name];
	}
	return result;
}

@end

@implementation NSObject (NSObjectVCoreDataType)

- (id)objectType {
	if ([self isKindOfClass:[NSValue class]]) {
		NSValueType type = [(NSValue *)self valueType];
		if (type == NSValueTypeUnKnown) {
			return [[NSString alloc] initWithUTF8String:[(NSValue *)self objCType]];
		}
		else {
			return @(type);
		}
	}
	return NSStringFromClass([self class]);
}

- (VCoreDataType)dataType {
	VCoreDataType type = VCoreDataTypeBlob;
	if ([self isKindOfClass:[NSValue class]]) {
		NSValue *obj = (NSValue *)self;
		NSValueType valueType = [obj valueType];
		if (valueType == NSValueTypeInt
		    || valueType == NSValueTypeUInt
		    || valueType == NSValueTypeShort
		    || valueType == NSValueTypeUShort
		    || valueType == NSValueTypeLong
		    || valueType == NSValueTypeULong
		    || valueType == NSValueTypeLongLong
		    || valueType == NSValueTypeULongLong
		    || valueType == NSValueTypeBool
		    ) {
			type = VCoreDataTypeInteger;
		}
		else if (valueType == NSValueTypeFloat
		         || valueType == NSValueTypeDouble) {
			type = VCoreDataTypeReal;
		}
		else {
			NSString *str = [[NSString alloc] initWithUTF8String:[obj objCType]];
			Class class = NSClassFromString(str);
			if ([class isSubclassOfClass:[NSString class]]) {
				type = VCoreDataTypeText;
			}
		}
	}
	else if ([self isKindOfClass:[NSString class]]) {
		type = VCoreDataTypeText;
	}
	return type;
}

- (NSString *)dataTypeToString:(VCoreDataType)type {
	switch (type) {
		case VCoreDataTypeInteger:
			return @"INTEGER";
			break;

		case VCoreDataTypeReal:
			return @"REAL";
			break;

		case VCoreDataTypeText:
			return @"TEXT";
			break;

		case VCoreDataTypeBlob:
			return @"BLOB";
			break;

		case VCoreDataTypeNull:
			return @"INTEGER";
			break;


		default:
			break;
	}
}

@end
