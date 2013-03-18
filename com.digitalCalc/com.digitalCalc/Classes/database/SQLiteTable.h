//
//  SQLiteTable.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "unistd.h"
#import "sqlite3.h"
#import "SQLiteDatabaseConnector.h"
#import "SQLiteStatmentExecutor.h"
#import "SQLitePrepareStatment.h"

@interface SQLiteTable : NSObject {
    NSString *database;
	NSString *table;
	NSArray *columns;

	sqlite3 *db;
	
	SQLiteStatmentExecutor *_executor;
}

@property (nonatomic, retain) SQLiteStatmentExecutor *executor;

- (id)initWithDatabase:(NSString *)database_name table:(NSString *)table_name columns:(NSArray *)table_columns;
- (BOOL)connect;
- (void)disconnect;
- (BOOL)empty;

// Protected methods
- (BOOL)executeStatment:(sqlite3_stmt *)statment andReset:(BOOL)reset;

@end
