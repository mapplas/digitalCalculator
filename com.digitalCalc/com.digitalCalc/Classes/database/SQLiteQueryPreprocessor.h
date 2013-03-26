//
//  SQLiteQueryPreprocessor.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteColumn.h"
#import "Unit.h"

@interface SQLiteQueryPreprocessor : NSObject

+ (NSString *)columnNames:(NSArray *)columns;
+ (NSString *)placeholders:(NSArray *)columns;
+ (NSString *)pairsKeys:(NSArray *)columns;

@end
