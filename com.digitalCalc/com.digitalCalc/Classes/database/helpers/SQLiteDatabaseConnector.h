//
//  SQLiteDatabaseConnector.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "sqlite3.h"
#import "FileManagement.h"
#import "DocumentsFolder.h"

@interface SQLiteDatabaseConnector : NSObject {
	NSMutableDictionary *databases;
}

- (sqlite3 *)connect:(NSString *)database_name;
- (void)clearAllDatabases;

@end
