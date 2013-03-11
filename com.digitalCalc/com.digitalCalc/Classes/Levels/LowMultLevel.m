//
//  LowMultLevel.m
//  com.digitalCalc
//
//  Created by Belén  on 11/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LowMultLevel.h"

@implementation LowMultLevel

- (NSInteger)giveFirstArgument {
    int lowerBound = 1;
    int upperBound = 9;
    return [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
}

- (NSInteger)giveSecondArgument:(NSInteger)first_arg {
    int lowerBound = 1;
    int upperBound = 9;
    int random = [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
    
    while (random + first_arg > 10) {
        random = [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
    }
    
    return random;
}

- (NSInteger)randomBetweenLowerBound:(NSInteger)lower_bound andUpperOne:(NSInteger)upper_bound {
    return lower_bound + arc4random() % (upper_bound - lower_bound);
}

@end
