//
//  VCoreDataModel.h
//  VCoreData
//
//  Created by shadow on 14-4-1.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCoreDataDefine.h"
@interface VCoreDataModel : NSObject

@end
@interface VCoreDataPropertyModel : NSObject
@property (nonatomic, strong) id propertyType;
@property (nonatomic, assign) VCoreDataType type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id value;
@end


@interface VCoreDataClassModel : NSObject
@property (nonatomic, strong) id modelInstance;
- (NSArray *)allPropertyModels;
- (VCoreDataPropertyModel *)primaryPropertyModel;
- (NSString *)modelName;
- (VCoreDataPropertyModel *)propertyModel:(NSString *)str;


@end
