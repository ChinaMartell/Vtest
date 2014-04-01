//
//  VCoreDataModel.h
//  VCoreData
//
//  Created by shadow on 14-4-1.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCoreDataModel : NSObject

@end
@interface VCoreDataPropertyModel : NSObject
@property (nonatomic, strong) NSString *propertyType;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) id value;
@end


@interface VCoreDataClassModel : NSObject
@property (nonatomic, strong) id modelInstance;
- (NSArray *)allPropertyModels;
- (NSString *)modelName;
- (VCoreDataPropertyModel *)propertyModel:(NSString *)str;


@end
