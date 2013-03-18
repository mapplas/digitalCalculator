//
//  SQLiteTableBaseObjec.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteTableBaseObject.h"

@implementation SQLiteTableBaseObject

#pragma mark -
#pragma mark Initialization

- (id)initWithDatabase:(NSString *)database_name table:(NSString *)table_name columns:(NSArray *)table_columns{

    self = [super initWithDatabase:database_name table:table_name columns:table_columns];
    if (self) {
        batchSaver = [[BatchSaver alloc] initWithTable:self andCapacity:[NSNumber numberWithInt:50]];
    }
    return self;
}

#pragma mark -
#pragma mark Remove

- (BOOL)remove:(Unit *)object {
	if(![self connect]) {
		return NO;
	}
	
	if(removeSth == nil) {
		removeSth = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"DELETE FROM %@ WHERE identifier=?", table] database:db];
	}
	
	sqlite3_bind_int(removeSth, 1, [[object identifier] intValue]);
	
	BOOL result = [self executeStatment:removeSth andReset:YES];
		
	return result;
}

#pragma mark -
#pragma mark Load

- (BOOL)loadWithInt:(int)key target:(NSObject *)target {
	if(![self connect]) {
		return NO;
	}
	
	if(selectSth == nil) {
		NSString *columnNames = [SQLiteQueryPreprocessor columnNames:columns];
		selectSth = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE autoIncrementIdentifier=?", columnNames, table] database:db];
	}
	
	sqlite3_bind_int(selectSth, 1, key);
	
	BOOL result = [self executeStatment:selectSth andReset:NO];
	
	if(result) {
		SQLiteQueryMapper *mapper = [[SQLiteQueryMapper alloc] init];
		[mapper mapToObject:selectSth object:target columns:columns];
	}
	
	sqlite3_reset(selectSth);
	
	return result;
}

- (BOOL)loadWithString:(NSString *)key target:(NSObject *)target {
	return [self loadWithInt:[key intValue] target:target];
}

- (BOOL)loadWithNumber:(NSNumber *)key target:(NSObject *)target {
	return [self loadWithInt:[key intValue] target:target];
}


#pragma mark -
#pragma mark Insert

- (NSMutableArray *)popIdColumn:(NSArray *)input {
	NSMutableArray *outColumns = [[NSMutableArray alloc] init];
	int els = [input count];
	for(int i = 0; i < els; i++) {
		SQLiteColumn *column = [input objectAtIndex:i];
		if([[column column] compare:@"id"] != NSOrderedSame) {
			[outColumns addObject:column];
		}
	}
	
	return outColumns;
}

#pragma mark -
#pragma mark InsertOrReplace
///
- (BOOL)insertOrReplace:(Unit *)object {
	NSArray *workingColumns;
		
	workingColumns = columns;
	if([object identifier] == nil) {
		workingColumns = [self popIdColumn:columns];		
	}
	
	if(insertOrReplaceSth == nil){
		NSString *columnNames = [SQLiteQueryPreprocessor columnNames:workingColumns];
		NSString *placeholders = [SQLiteQueryPreprocessor placeholders:workingColumns];
			
		insertOrReplaceSth = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ (%@) VALUES (%@)", table, columnNames, placeholders] database:db];
	}
	
	SQLiteQueryMapper *mapper = [[SQLiteQueryMapper alloc] init];
	[mapper mapFromObject:insertOrReplaceSth object:object columns:workingColumns];
		
	BOOL result = [self executeStatment:insertOrReplaceSth andReset:YES];
			
	return result;
}

#pragma mark -
#pragma mark Transaction operations
- (void) startTransaction {
	if(![self connect]) {
		return;
	}
	
	sqlite3_stmt *startTransaction = [SQLitePrepareStatment prepare:@"BEGIN IMMEDIATE TRANSACTION" database:db];
	
	[self executeStatment:startTransaction andReset:YES];
}

- (void) finishTransaction{
	sqlite3_stmt *endTransaction = [SQLitePrepareStatment prepare:@"COMMIT" database:db];
	
	[self executeStatment:endTransaction andReset:YES];	
}

#pragma mark -
#pragma mark Save

- (BOOL)save:(Unit *)object {
	if(![self connect]) {
		return NO;
	}
	
	[batchSaver batchSave:object];
	[self flush];

	return YES;
}

- (BOOL)saveBatch:(Unit *)object {
	if(![self connect]) {
		return NO;
	}
	
	[batchSaver batchSave:object];
	
	return YES;
}

- (void)flush{
	[batchSaver flushTransaction];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	sqlite3_finalize(removeSth);
	sqlite3_finalize(selectSth);
	sqlite3_finalize(insertSth);
	sqlite3_finalize(insertOrReplaceSth);
	sqlite3_finalize(clearCoupons);
	sqlite3_finalize(cardsArray);
	sqlite3_finalize(updateSth);
}

@end