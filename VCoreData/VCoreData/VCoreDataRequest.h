//
//  VCoreDataRequest.h
//  VCoreData
//
//  Created by shadow on 14-3-28.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "VRequest.h"
@class VCoreDataClassModel;
@interface VCoreDataRequest : VRequest
@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSArray *propertyModels;
@property (nonatomic, strong) NSArray *classModels;

@end

@interface VCoreDataQueryRequest : VCoreDataRequest
@property (nonatomic, strong) VCoreDataClassModel *resultClassModel;



@end

@interface VCoreDataAddRequest : VCoreDataRequest

@end


@interface VCoreDataUpdateRequest : VCoreDataRequest



@end


@interface VCoreDataDelRequest : VCoreDataRequest


@end
