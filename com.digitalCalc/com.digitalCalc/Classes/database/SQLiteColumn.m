//
//  SQLiteColumn.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteColumn.h"


@implementation SQLiteColumn

@synthesize name;
@synthesize type;

- (id)initWithName:(NSString *)input_name type:(NSString *)input_type {
	self = [super init];

	if(self) {
		self.name = input_name;
		self.type = input_type;
	}
	
	return self;
}

- (id)initWithName:(NSString *)input_name type:(NSString *)input_type column:(NSString *)input_column {
	self = [self initWithName:input_name type:input_type];

	if(self) {
		[self setColumn:input_column];
	}
	
	return self;
}

- (void)setColumn:(NSString *)column_name {
	column = column_name;
}

- (NSString *)column {
	if(column == nil || [column length] == 0) {
		return self.name;
	}
	
	return column;
}

@end
