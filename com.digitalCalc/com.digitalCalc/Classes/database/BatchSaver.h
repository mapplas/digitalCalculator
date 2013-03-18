//
//  BatchSaver.h
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Unit.h"

@protocol InsertionWithTransactions <NSObject>

@required
- (void)startTransaction;
- (void)finishTransaction;
- (BOOL)insertOrReplace:(Unit *)object;

@end

@interface BatchSaver : NSObject {
	NSNumber *capacity;
	NSMutableArray *transactionList;
	id<InsertionWithTransactions> table;
}

@property (nonatomic, retain) NSNumber *capacity;
@property (nonatomic, retain) id<InsertionWithTransactions> table;

-(id)initWithTable:(id<InsertionWithTransactions>)base_table andCapacity:(NSNumber *)capacity;
-(void)batchSave:(Unit *)object;
-(void) flushTransaction;

@end
