//
//  RankingRowTable.h
//  com.digitalCalc
//
//  Created by Belén  on 18/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteTableBaseObject.h"
#import "Constants.h"
#import "RankingRow.h"

@interface RankingRowTable : SQLiteTableBaseObject {
    sqlite3_stmt *firstBestPuntuations;
    sqlite3_stmt *selectOldPuntuations;
    sqlite3_stmt *removeOldPuntuations;
}

- (NSMutableDictionary *)getFirstBestPuntuations:(NSInteger)number;
- (BOOL)removeRankingElements:(NSInteger)number;

@end
