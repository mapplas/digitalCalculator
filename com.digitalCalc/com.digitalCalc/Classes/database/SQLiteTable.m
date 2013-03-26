//
//  SQLiteTable.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteTable.h"

@implementation SQLiteTable
@synthesize executor = _executor;

- (id)initWithDatabase:(NSString *)database_name table:(NSString *)table_name columns:(NSArray *)table_columns {
	self = [super init];
	
	if(self) {
		database = database_name;
		table = table_name;
		columns = table_columns;
	}
	
	return self;
}

- (BOOL)connect {
	if(db == nil) {
		NSLog(@"connecting to %@:%@", database, table);
		SQLiteDatabaseConnector *connector = [[SQLiteDatabaseConnector alloc] init];
		db = [connector connect:database];
		
		SQLiteStatmentExecutor *executor = [[SQLiteStatmentExecutor alloc] init];
		self.executor = executor;
	}
	
	if(db == nil) {
		return NO;
	}
	
	return YES;
}

- (void)disconnect {
	NSLog(@"disconnecting %@:%@", database, table);
	sqlite3_close(db);
}

- (BOOL)executeStatment:(sqlite3_stmt *)statment andReset:(BOOL)reset {
	BOOL result = [self.executor execute:statment database:db];
	
	if(reset) {
		sqlite3_reset(statment);
	}
	
	return result;
}

- (BOOL)empty {
	if(![self connect]) {
		return NO;
	}
	
	sqlite3_stmt *deleteSth = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"DELETE FROM %@", table] database:db];
	
	BOOL result = [self executeStatment:deleteSth andReset:YES];
	
	sqlite3_finalize(deleteSth);
	
	return result;
}

@end
