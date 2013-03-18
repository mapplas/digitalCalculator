//
//  SQLiteColumn.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface SQLiteColumn : NSObject {
	// Name within object
	NSString *name;
	
	// Data type
	NSString *type;
	
	// Column name (optional, default: name)
	NSString *column;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *type;

- (id)initWithName:(NSString *)input_name type:(NSString *)input_type;
- (id)initWithName:(NSString *)input_name type:(NSString *)input_type column:(NSString *)input_column;

- (void)setColumn:(NSString *)column_name;
- (NSString *)column;

@end
