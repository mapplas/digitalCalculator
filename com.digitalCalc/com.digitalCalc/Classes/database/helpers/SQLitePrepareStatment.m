//
//  SQLitePrepareStatment.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLitePrepareStatment.h"


@implementation SQLitePrepareStatment

+ (sqlite3_stmt *)prepare:(NSString *)query database:(sqlite3 *)db {
	sqlite3_stmt *statment = nil;

	const char *sql = [query cStringUsingEncoding:NSUTF8StringEncoding];

	if(sqlite3_prepare_v2(db, sql, -1, &statment, NULL) != SQLITE_OK) {
		NSLog(@"Error preparing statment: %@. SQLite says %s", query, sqlite3_errmsg(db));
		return nil;
	}
	
	return statment;
}

@end
