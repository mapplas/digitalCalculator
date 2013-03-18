//
//  SQLiteDatabaseConnector.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteDatabaseConnector.h"

static sqlite3 *notifications;

@implementation SQLiteDatabaseConnector

- (BOOL)createDatabase:(NSString *)database_name target:(NSString *)target {
	FileManagement *fileManagement = [[FileManagement alloc] init];

	NSString *databasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:database_name];
	BOOL result = [fileManagement copyFile:databasePath to:target];
	return result;
}

- (NSString *)getDatabasePath:(NSString *)database_name {
	FileManagement *fileManagement = [[FileManagement alloc] init];
	DocumentsFolder *folder = [[DocumentsFolder alloc] init];
	NSString *path = [folder getWithPath:database_name];
	
	if(![fileManagement fileExists:path]) {
		[self createDatabase:database_name target:path];
	}

	return path;
}

- (sqlite3 *)putDB:(NSString *)database_name into:(sqlite3 *)db {
	if (db == nil) {
		NSLog(@"Creating %@", database_name);
		NSString *path = [self getDatabasePath:database_name];
		sqlite3_open([path UTF8String], &db);
	}
	return db;
}

- (sqlite3 *)connect:(NSString *)database_name {
	if ([database_name isEqualToString:@"Notifications.db"]) {
		notifications = [self putDB:database_name into:notifications];
		return notifications;
	}
	else {
		NSLog(@"Database %@ is not supported.", database_name);
		return nil;
	}
}

- (void)clearAllDatabases {
	sqlite3_close(notifications);
	
	notifications = nil;
}

@end
