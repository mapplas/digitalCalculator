//
//  SQLiteStatmentExecutor.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SQLiteStatmentExecutor.h"

@implementation SQLiteStatmentExecutor

const int retry_msec = 20;
const int retries = 50;

- (BOOL)execute:(sqlite3_stmt *)statment database:(sqlite3 *)db {
	int result;
	int current_retry = 0;
	
	if(statment == nil) {
		return NO;
	}
	
	BOOL finish = NO;
	while(!finish) {
		result = sqlite3_step(statment);
		if(result == SQLITE_BUSY) {
			NSLog(@"%s:%d Database busy. Retrying in %d msecs", __FUNCTION__, __LINE__, retry_msec);
			usleep(retry_msec);
		}
		else if(result == SQLITE_LOCKED) {
			NSLog(@"%s:%d Database locked. Reseting and retrying in %d msecs", __FUNCTION__, __LINE__, retry_msec);
			sqlite3_reset(statment);
			usleep(retry_msec);
		}
		else if (result == SQLITE_ERROR) {
			NSLog(@"%s:%d Error executing query %s", __FUNCTION__, __LINE__, sqlite3_errmsg(db));
			finish = YES;
		}
		else if (result == SQLITE_DONE || result == SQLITE_ROW) {
			return YES;
		}
		else {
			NSLog(@"%s:%d SQLite returned status %d (%s)", __FUNCTION__, __LINE__, result, sqlite3_errmsg(db));
		}
		
		if(current_retry > retries) {
			finish = YES;
		}
		
		current_retry++;
	}
	return NO;
}

- (BOOL)executeMultiple:(sqlite3_stmt *)statment database:(sqlite3 *)db {
	int result;
	int current_retry = 0;

	if(statment == nil) {
		return NO;
	}
	
	BOOL finish = NO;
	while(!finish) {
		result = sqlite3_step(statment);
		if(result == SQLITE_BUSY) {
			NSLog(@"%s:%d Database busy. Retrying in %d msecs", __FUNCTION__, __LINE__, retry_msec);
			usleep(retry_msec);
		}
		else if(result == SQLITE_LOCKED) {
			NSLog(@"%s:%d Database locked. Reseting and retrying in %d msecs", __FUNCTION__, __LINE__, retry_msec);
			sqlite3_reset(statment);
			usleep(retry_msec);
		}
		else if (result == SQLITE_ERROR) {
			NSLog(@"%s:%d Error executing query %s", __FUNCTION__, __LINE__, sqlite3_errmsg(db));
			finish = YES;
		}
		else if (result == SQLITE_DONE) {
			return NO;
		}
		else if(result == SQLITE_ROW) {
			return YES;
		}
		
		if(current_retry > retries) {
			finish = YES;
		}
		
		current_retry++;
	}
	
	return NO;
}

@end