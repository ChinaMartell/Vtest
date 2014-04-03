//
//  VCoreDataModel.m
//  VCoreData
//
//  Created by shadow on 14-4-1.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "VCoreDataModel.h"
#import "VCoreData.h"
#import <objc/runtime.h>
@implementation VCoreDataModel

@end
@implementation VCoreDataPropertyModel


@end
@implementation VCoreDataClassModel
- (NSArray *)allPropertyModels {
	NSMutableArray *result = [[NSMutableArray alloc] init];
	unsigned int numberOfProperties = 0;
	objc_property_t *propertyArray = class_copyPropertyList([self.modelInstance class], &numberOfProperties);
	for (NSUInteger i = 0; i < numberOfProperties; i++) {
		VCoreDataPropertyModel *propertyModel = [[VCoreDataPropertyModel alloc] init];
		objc_property_t property = propertyArray[i];
		NSString *attribute = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
		const char *rawPropertyType = [[[[[attribute componentsSeparatedByString:@","] firstObject] substringFromIndex:1] deleteStrings:@"@", @"\"", nil] UTF8String];
		NSValue *rawPropertyTypeValue = [NSValue valueWithBytes:&rawPropertyType objCType:rawPropertyType];
		//get type
		VCoreDataType type = [rawPropertyTypeValue dataType];
		id propertyType = [rawPropertyTypeValue objectType];
		NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
		id value = [self.modelInstance valueForKey:name];
		propertyModel.propertyType = propertyType;
		propertyModel.type = type;
		propertyModel.name = name;
		propertyModel.value = value;
		[result addObject:propertyModel];
	}
	free(propertyArray);
	return result;
}

- (VCoreDataPropertyModel *)primaryPropertyModel {
	return [[self allPropertyModels] firstObject];
}

- (NSString *)modelName {
	return NSStringFromClass([self.modelInstance class]);
}

- (VCoreDataPropertyModel *)propertyModel:(NSString *)str {
	for (VCoreDataPropertyModel *propertyModel in[self allPropertyModels]) {
		NSString *name = propertyModel.name;
		if ([str isEqualToString:name]) {
			return propertyModel;
		}
	}
	return nil;
}

@end
