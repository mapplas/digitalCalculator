//
//  SQLitePrepareStatment.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "sqlite3.h"

@interface SQLitePrepareStatment : NSObject

+ (sqlite3_stmt *)prepare:(NSString *)query database:(sqlite3 *)db;

@end
