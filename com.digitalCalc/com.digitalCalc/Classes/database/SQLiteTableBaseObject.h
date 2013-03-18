//
//  SQLiteTableBaseObject.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "sqlite3.h"
#import "SQLiteTable.h"
#import "Unit.h"
#import "SQLitePrepareStatment.h"
#import "SQLiteQueryMapper.h"
#import "SQLiteQueryPreprocessor.h"
#import "BatchSaver.h"

@interface SQLiteTableBaseObject : SQLiteTable <InsertionWithTransactions> {
	BatchSaver *batchSaver;
    sqlite3_stmt *selectSth;
    sqlite3_stmt *removeSth;
	sqlite3_stmt *insertSth;
	sqlite3_stmt *insertOrReplaceSth;
	sqlite3_stmt *objectExistsSth;
	sqlite3_stmt *updateSth;
	sqlite3_stmt *clearCoupons;
	sqlite3_stmt *cardsArray;
}

- (BOOL)remove:(Unit *)object;
- (BOOL)loadWithNumber:(NSNumber *)key target:(NSObject *)target;
- (BOOL)loadWithString:(NSString *)key target:(NSObject *)target;

- (BOOL)insertOrReplace:(Unit *)object;
- (BOOL)save:(Unit *)object;
- (BOOL)saveBatch:(Unit *)object;
- (void)flush;


@end