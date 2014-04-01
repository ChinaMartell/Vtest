//
//  VCoreDataSQLPersister.m
//  VCoreData
//
//  Created by shadow on 14-3-28.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "VCoreDataSQLPersister.h"
#import <sqlite3.h>
#import "VCoreData.h"
#define ENABLE_TRANSACTION_THRESHOLD_MAX 3
@interface VCoreDataSQLPersister () {
	sqlite3 *_database;
}
@end
@implementation VCoreDataSQLPersister
- (id)init {
	self = [super init];
	if (self) {
		[self initDataBase];
	}
	return self;
}

- (BOOL)initDataBase {
	NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
	                                                              , NSUserDomainMask
	                                                              , YES);
	NSString *databaseFilePath = [[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"VCoreData.db"];
	int success = sqlite3_open([databaseFilePath UTF8String], &_database);
	return success == SQLITE_OK;
}

- (BOOL)createTable:(VCoreDataClassModel*)obj {
	NSMutableArray *paramArray = [[NSMutableArray alloc] init];
	int i = 0;
	for (VCoreDataPropertyModel*propertyModel in[obj allPropertyModels]) {
		NSString *type = propertyModel.type;
		NSString *name = propertyModel.name;
		NSString *param = [NSString stringWithFormat:@"%@ %@ ", name, type];
		if (i == 0) {
			param = [param addString:@"PRIMARY KEY"];
		}
		[paramArray addObject:param];
		i++;
	}
	NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[obj modelName], [paramArray componentsJoinedByString:@","]];

	int success = [self execute:sql];
	return success == SQLITE_OK;
}

- (BOOL)isTableExist:(VCoreDataClassModel*)obj {
	sqlite3_stmt *statement;
	NSString *sql = [NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE type='table' AND name='%@'", [obj modelName]];
	sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, nil);
	BOOL isExist = NO;
	if (sqlite3_step(statement) == SQLITE_ROW) {
		isExist = YES;
	}
	sqlite3_finalize(statement);
	return isExist;
}

- (int)execute:(NSString *)sql {
	char *err = nil;
	return sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &err);
}

#pragma mark - VCoreDataSQLPersister action method
- (NSArray *)executeSQL:(NSString *)str {
	return nil;
}

#pragma mark - VCoreDataPersisterProtocol

- (NSArray *)queryData:(VCoreDataQueryRequest *)request {
    Class resultClass=NSClassFromString([request.resultClassModel modelName]);
	NSArray *objArray = request.classModels;
	NSMutableArray *tableArray = [[NSMutableArray alloc] init];
	for (id obj in objArray) {
		[tableArray addObject:[obj modelName]];
	}
	NSString *tableNames = [tableArray componentsJoinedByString:@","];

	NSArray *propertyArray = request.propertyModels;
    NSMutableArray *columnArray = [[NSMutableArray alloc] init];
    for (VCoreDataPropertyModel *propertyModel in propertyArray) {
        [columnArray addObject:propertyModel.name];
    }
	NSString *columnNames = [columnArray componentsJoinedByString:@","];

    NSString *filter=request.filter;
	NSString *query = [filter isMeaningful] ? [@" WHERE " addString:filter]:@"";


	NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ %@", columnNames, tableNames,query];
	sqlite3_stmt *statement = nil;
	int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL);
	if (success != SQLITE_OK) {
		return nil;
	}
	NSMutableArray *result = [[NSMutableArray alloc] init];
	while ((sqlite3_step(statement) == SQLITE_ROW)) {
		id resultObj = resultClass?[[resultClass alloc] init]:[[NSMutableDictionary alloc] init];
		int column = 0;
		for (VCoreDataPropertyModel *propertyModel in propertyArray) {
			NSString *type = propertyModel.type;
			id value = [self bindOrGetValue:nil withStatement:statement withType:type withIndex:column++ isBind:NO];
			[resultObj setValue:value forKey:propertyModel.name];
		}
		[result addObject:resultObj];
	}
	sqlite3_finalize(statement);
	return result;
}

- (BOOL)updateData:(VCoreDataUpdateRequest *)request {
    NSArray *objArray = request.classModels;
	NSMutableArray *tableArray = [[NSMutableArray alloc] init];
	for (id obj in objArray) {
		[tableArray addObject:[obj modelName]];
	}
	NSString *tableNames = [tableArray componentsJoinedByString:@","];
    
	NSArray *propertyArray = request.propertyModels;

    NSString *filter=request.filter;
	NSString *query = [filter isMeaningful] ? [@" WHERE " addString:filter]:@"";
    
    NSMutableArray *paramArray = [[NSMutableArray alloc] init];
    sqlite3_stmt *statement = nil;
    for (VCoreDataPropertyModel *propertyModel in propertyArray) {
        NSString *name = propertyModel.name;
        [paramArray addObject:[name addString:@"=?"]];
    }
    NSString *paramNames=[paramArray componentsJoinedByString:@","];
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ %@", tableNames,  paramNames ,query] ;
    int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL);
    if (success != SQLITE_OK) {
        return NO;
    }
    int i = 1;
    for (VCoreDataPropertyModel *propertyModel  in propertyArray) {
        NSString *type = propertyModel.type;
        id value =propertyModel.value;
        [self bindOrGetValue:value withStatement:statement withType:type withIndex:i++ isBind:YES];
    }
    success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    return success == SQLITE_OK;

}

- (BOOL)addData:(NSArray *)objs {
	BOOL isSuc = YES;
    if (objs.count>ENABLE_TRANSACTION_THRESHOLD_MAX) {
        sqlite3_exec(_database,"BEGIN",0,0,0);
    }
	for (VCoreDataClassModel *obj in objs) {
		if (![self isTableExist:obj]) {
			[self createTable:obj];
		}
		NSArray *propertyArray = [obj allPropertyModels];
		NSMutableArray *paramArray = [[NSMutableArray alloc] init];
		NSMutableArray *markArray = [[NSMutableArray alloc] init];
		sqlite3_stmt *statement = nil;
		for (VCoreDataPropertyModel*propertyModel in propertyArray) {
			NSString *name = propertyModel.name;
			[paramArray addObject:name];
			[markArray addObject:@"?"];
		}
		NSString *sql = [NSString stringWithFormat:@"REPLACE INTO %@ (%@) VALUES (%@)", [obj modelName], [paramArray componentsJoinedByString:@","], [markArray componentsJoinedByString:@","]];
		int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL);
		if (success != SQLITE_OK) {
			return NO;
		}
		int i = 1;
		for (VCoreDataPropertyModel*propertyModel in propertyArray) {
			NSString *type = propertyModel.type;
			id value = propertyModel.value;
			[self bindOrGetValue:value withStatement:statement withType:type withIndex:i++ isBind:YES];
		}
		success = sqlite3_step(statement);
		sqlite3_finalize(statement);
		isSuc = (success == SQLITE_OK) == YES ? isSuc : NO;
	}
    if (objs.count>ENABLE_TRANSACTION_THRESHOLD_MAX) {
        sqlite3_exec(_database,"BEGIN",0,0,0);
    }
	return isSuc;
}

- (BOOL)deleteData:(VCoreDataDelRequest *)request {
    NSArray *objArray = request.classModels;
	NSMutableArray *tableArray = [[NSMutableArray alloc] init];
	for (id obj in objArray) {
		[tableArray addObject:[obj modelName]];
	}
	NSString *tableNames = [tableArray componentsJoinedByString:@","];
    NSString *filter=request.filter;
	NSString *query = [filter isMeaningful] ? [@" WHERE " addString:filter]:@"";
    sqlite3_stmt *statement = nil;
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ %@", tableNames ,query] ;
    int success = sqlite3_prepare_v2(_database, [sql UTF8String], -1, &statement, NULL);
    if (success != SQLITE_OK) {
        return NO;
    }
    success = sqlite3_step(statement);
    sqlite3_finalize(statement);
    return success == SQLITE_OK;
	return YES;
}

- (id)bindOrGetValue:(id)value withStatement:(sqlite3_stmt *)statement withType:(NSString *)type withIndex:(NSInteger)index isBind:(BOOL)isBind {
	if ([type isEqualToString:@"INTEGER"]) {
		if (isBind) {
			sqlite3_bind_int(statement, index, [value intValue]);
		}
		else {
			value = @(sqlite3_column_int(statement, index));
		}
	}
	else if ([type isEqualToString:@"REAL"]) {
		if (isBind) {
			sqlite3_bind_double(statement, index, [value doubleValue]);
		}
		else {
			value = @(sqlite3_column_double(statement, index));
		}
	}
	else if ([type isEqualToString:@"TEXT"]) {
		if (isBind) {
			sqlite3_bind_text(statement, index, [value UTF8String], -1, SQLITE_TRANSIENT);
		}
		else {
			value = [[NSString alloc] initWithUTF8String:(char *)sqlite3_column_text(statement, index)];
		}
	}
	else if ([type isEqualToString:@"BLOB"]) {
		if (isBind) {
			NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
			sqlite3_bind_blob(statement, index, [data bytes], data.length, SQLITE_TRANSIENT);
		}
		else {
			int i = index;
			NSUInteger blobLen = sqlite3_column_bytes(statement, i);
			NSMutableData *data = [NSMutableData dataWithBytes:sqlite3_column_blob(statement, index) length:blobLen];
			value = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		}
	}
	return value;
}

@end
