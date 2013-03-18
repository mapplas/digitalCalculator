//
//  RankingRow.m
//  com.digitalCalc
//
//  Created by Belén  on 18/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RankingRow.h"

@implementation RankingRow

@synthesize username = _username;
@synthesize points = _points;
@synthesize date = _date;

- (id)init {
    self = [super init];
    if (self) {
        self.username = @"";
        self.points = [NSNumber numberWithInt:0];
        self.date = @"";
    }
    return self;
}

@end
