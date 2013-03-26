//
//  SQLiteQueryMapper.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteQueryMapper.h"

@implementation SQLiteQueryMapper

- (void)mapToObject:(sqlite3_stmt *)statment object:(NSObject *)object columns:(NSArray *)columns {
	NSUInteger i, count = [columns count];
	for (i = 0; i < count; i++) {
		SQLiteColumn *column = (SQLiteColumn *)[columns objectAtIndex:i];
		
		SEL property = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [[column name] uppercaseFirst]]);
		NSString *type = [column type];
		if([type isEqualToString:@"int-as-string"]) {
			int value = sqlite3_column_int(statment, i);
			NSString *sValue = [[NSString alloc] initWithFormat:@"%d", value];
			[object performSelector:property withObject:sValue];
		}
		else if([type isEqualToString:@"int"]) {
			int value = sqlite3_column_int(statment, i);
			NSNumber *nValue = [[NSNumber alloc] initWithInt:value];
			[object performSelector:property withObject:nValue];
		}
		else if([type isEqualToString:@"text"]) {
			char *texto = (char *)sqlite3_column_text(statment, i);
			if(texto != nil) {
				NSString *value = [[NSString alloc] initWithUTF8String:texto];
				[object performSelector:property withObject:value];
			}
		}
		else if([type isEqualToString:@"date"]) {
			char *texto = (char *)sqlite3_column_text(statment, i);
			if(texto != nil) {
				NSString *value = [[NSString alloc] initWithUTF8String:texto];
				[object performSelector:property withObject:value];
			}
		}
		else if([type isEqualToString:@"boolean"]) {
			int value = sqlite3_column_int(statment, i);
			[object performSelector:property withObject:[NSNumber numberWithInt:value]];
		}
	}

}

- (void)mapFromObject:(sqlite3_stmt *)statment object:(Unit *)object columns:(NSArray *)columns {
	NSUInteger i, count = [columns count];
	for (i = 0; i < count; i++) {
		SQLiteColumn *column = (SQLiteColumn *)[columns objectAtIndex:i];
		
		SEL property = NSSelectorFromString([column name]);
		NSString *type = [column type];
		if([type isEqualToString:@"int-as-string"]) {
			sqlite3_bind_int(statment, i+1, [[object performSelector:property] intValue]);
		}
		else if([type isEqualToString:@"int"]) {
			sqlite3_bind_int(statment, i+1, [[object performSelector:property] intValue]);
		}
		else if([type isEqualToString:@"text"]) {
			sqlite3_bind_text(statment, i+1, [[object performSelector:property] cStringUsingEncoding:NSUTF8StringEncoding], -1, SQLITE_TRANSIENT);
		}
		else if([type isEqualToString:@"date"]) {
			sqlite3_bind_text(statment, i+1, [[object performSelector:property] cStringUsingEncoding:NSUTF8StringEncoding], -1, SQLITE_TRANSIENT);
		}
		else if([type isEqualToString:@"boolean"]) {
			NSNumber *value = (NSNumber *)[object performSelector:property];
			
			sqlite3_bind_int(statment, i+1, [value intValue]);
		}
		else {
			NSLog(@"Error: cannot bind value in %d", i);
		}
	}
}

@end