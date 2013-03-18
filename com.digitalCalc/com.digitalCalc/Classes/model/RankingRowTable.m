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

@end
