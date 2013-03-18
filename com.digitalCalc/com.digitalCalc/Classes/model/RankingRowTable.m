//
//  RankingRowTable.m
//  com.digitalCalc
//
//  Created by Belén  on 18/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RankingRowTable.h"

@implementation RankingRowTable

- (id)init {
	NSArray *fields = [[NSArray alloc] initWithObjects:
					   [[SQLiteColumn alloc] initWithName:@"identifier" type:@"int-as-string"],
					   [[SQLiteColumn alloc] initWithName:@"username" type:@"text"],
					   [[SQLiteColumn alloc] initWithName:@"points" type:@"int-as-string"],
                       [[SQLiteColumn alloc] initWithName:@"date" type:@"text"],
					   nil];
	
	self = [super initWithDatabase:@"Ranking.db" table:@"ranking" columns:fields];
	
	return self;
}

- (NSMutableDictionary *)getFirstBestPuntuations:(NSInteger)number {
    if (![self connect]) {
        return NO;
    }

    if (firstBestPuntuations == nil) {
        firstBestPuntuations = [SQLitePrepareStatment prepare:[NSString stringWithFormat:@"SELECT username, points FROM %@ ORDER BY points DESC", table] database:db];
    }
    
    NSMutableDictionary *rankingDict = [[NSMutableDictionary alloc] init];
    
    int i = 1;
    while ([self.executor executeMultiple:firstBestPuntuations database:db]) {
        NSMutableArray *rankingRowData = [[NSMutableArray alloc] init];
        NSString *username = [[NSString alloc] initWithBytes:sqlite3_column_text(firstBestPuntuations, 0) length:sizeof(sqlite3_column_text(firstBestPuntuations, 0)) encoding:NSASCIIStringEncoding];
        NSString *points = [[NSString alloc] initWithBytes:sqlite3_column_text(firstBestPuntuations, 1) length:sizeof(sqlite3_column_int(firstBestPuntuations, 1)) encoding:NSASCIIStringEncoding];
        [rankingRowData addObject:username];
        [rankingRowData addObject:points];
        
        [rankingDict setObject:rankingRowData forKey:[NSNumber numberWithInt:i]];
        i++;
    }
    
    sqlite3_reset(firstBestPuntuations);
    sqlite3_finalize(firstBestPuntuations);
    
    return rankingDict;
}

@end
