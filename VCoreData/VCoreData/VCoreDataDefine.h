//
//  VCoreDataDefine.h
//  VCoreData
//
//  Created by shadow on 14-3-28.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSInteger, VCoreDataType) {
	VCoreDataTypeInteger = 1,
	VCoreDataTypeReal,
	VCoreDataTypeText,
	VCoreDataTypeBlob,
	VCoreDataTypeNull,
};

typedef NS_ENUM (NSInteger, VCoreDataPersisterType) {
	VCoreDataPersisterTypeSQL,
	VCoreDataPersisterTypeData,
};

@interface VCoreDataDefine : NSObject

@end
