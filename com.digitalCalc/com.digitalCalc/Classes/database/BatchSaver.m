//
//  BatchSaver.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "BatchSaver.h"

@implementation BatchSaver

@synthesize table;
@synthesize capacity;

-(id)initWithTable:(id<InsertionWithTransactions>)base_table andCapacity:(NSNumber *)batch_capacity{
	self = [super init];
	
	if(self){
		self.capacity = batch_capacity;
		self.table = base_table;
		transactionList = [[NSMutableArray alloc] init];
	}
	
	return self;
}

-(void)batchSave:(Unit *)object{
	[transactionList addObject:object];

	if([self.capacity intValue] == [transactionList count]){
		[self flushTransaction];
	}
}

-(void) flushTransaction{
	[self.table startTransaction];
	
	Unit *object;
	for(object in transactionList){
		[self.table insertOrReplace:object];
	}
	
	[self.table finishTransaction];
	
	[transactionList removeAllObjects];
	
}
  
@end
