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
@end

@interface VCoreDataQueryRequest : VCoreDataRequest
@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSArray *propertyModels;
@property (nonatomic, strong) NSArray *classModels;
@property (nonatomic, strong) VCoreDataClassModel *resultClassModel;



@end

@interface VCoreDataAddRequest : VCoreDataRequest
@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSArray *propertyModels;
@property (nonatomic, strong) NSArray *classModels;


@end


@interface VCoreDataUpdateRequest : VCoreDataRequest
@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSArray *propertyModels;
@property (nonatomic, strong) NSArray *classModels;




@end


@interface VCoreDataDelRequest : VCoreDataRequest

@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSArray *propertyModels;
@property (nonatomic, strong) NSArray *classModels;


@end

@interface VCoreDataExecuteRequest : VCoreDataRequest
@property (nonatomic, strong) NSString *command;
@property (nonatomic, strong) NSArray *paramArray;
@end
