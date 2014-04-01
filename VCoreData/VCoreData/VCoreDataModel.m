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
		const char *rawPropertyType = [[[[attribute componentsSeparatedByString:@","] firstObject] substringFromIndex:1] UTF8String];
		NSString *propertyType = NSStringFromClass([NSObject class]);
		NSString *type = NSStringFromClass([NSObject class]);
		if (strcmp(rawPropertyType, @encode(int)) == 0) {
			propertyType = @"int";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(unsigned int)) == 0) {
			propertyType = @"unsigned int";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(short)) == 0) {
			propertyType = @"short";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(unsigned short)) == 0) {
			propertyType = @"unsigned short";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(long)) == 0) {
			propertyType = @"long";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(unsigned long)) == 0) {
			propertyType = @"unsigned long";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(long long)) == 0) {
			propertyType = @"long long";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(unsigned long long)) == 0) {
			propertyType = @"unsigned long long";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(bool)) == 0) {
			propertyType = @"bool";
			type = @"INTEGER";
		}
		else if (strcmp(rawPropertyType, @encode(float)) == 0) {
			propertyType = @"float";
			type = @"REAL";
		}
		else if (strcmp(rawPropertyType, @encode(double)) == 0) {
			propertyType = @"double";
			type = @"REAL";
		}
		else {
			NSString *rawPropertyTypeStr = [[NSString alloc] initWithUTF8String:rawPropertyType];
			propertyType = [rawPropertyTypeStr deleteStrings:@"@", @"\"", nil];
			if ([propertyType isEqualToString:NSStringFromClass([NSString class])] || [propertyType isEqualToString:NSStringFromClass([NSMutableString class])]) {
				type = @"TEXT";
			}
			else {
				type = @"BLOB";
			}
		}

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
