//
//  SQLiteQueryMapper.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "sqlite3.h"
#import "SQLiteColumn.h"
#import "Unit.h"
#import "NSStringCamelcase.h"

@interface SQLiteQueryMapper : NSObject

- (void)mapToObject:(sqlite3_stmt *)statment object:(NSObject *)object columns:(NSArray *)columns;
- (void)mapFromObject:(sqlite3_stmt *)statment object:(Unit *)object columns:(NSArray *)columns;

@end
