//
//  SQLiteQueryPreprocessor.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteQueryPreprocessor.h"

@implementation SQLiteQueryPreprocessor

+ (NSString *)columnNames:(NSArray *)columns {
	NSMutableArray *placeholders = [[NSMutableArray alloc] init];
	int els = [columns count];
	for(int i = 0; i < els; i++) {
		SQLiteColumn *column = [columns objectAtIndex:i];
		[placeholders addObject:[column column]];
	}
	
	NSString *output = [placeholders componentsJoinedByString:@","];
		
	return output;
}

+ (NSString *)placeholders:(NSArray *)columns {
	NSMutableArray *statments = [[NSMutableArray alloc] init];
	int els = [columns count];
	for(int i = 0; i < els; i++) {
		[statments addObject:@"?"];
	}
	
	NSString *output = [statments componentsJoinedByString:@","];
		
	return output;
}

+ (NSString *)pairsKeys:(NSArray *)columns {
	NSMutableArray *placeholders = [[NSMutableArray alloc] init];
	int els = [columns count];
	for(int i = 0; i < els; i++) {
		SQLiteColumn *column = [columns objectAtIndex:i];
		NSString *pair = [NSString stringWithFormat:@"%@=?", [column column]];
		[placeholders addObject:pair];
	}
	
	NSString *output = [placeholders componentsJoinedByString:@","];
		
	return output;
}

@end