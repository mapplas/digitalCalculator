//
//  SQLiteStatmentExecutor.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "sqlite3.h"

@interface SQLiteStatmentExecutor : NSObject

- (BOOL)execute:(sqlite3_stmt *)statment database:(sqlite3 *)db;
- (BOOL)executeMultiple:(sqlite3_stmt *)statment database:(sqlite3 *)db;

@end
