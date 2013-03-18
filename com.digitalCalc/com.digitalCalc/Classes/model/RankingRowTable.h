//
//  RankingRowTable.h
//  com.digitalCalc
//
//  Created by Belén  on 18/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteTableBaseObject.h"

@interface RankingRowTable : SQLiteTableBaseObject {
    sqlite3_stmt *firstBestPuntuations;
}

- (NSMutableDictionary *)getFirstBestPuntuations:(NSInteger)number;

@end
