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
    int lowerBound = LOWER_LEVEL_MIN_ARGUMENT;
    int upperBound = LOWER_LEVEL_MAX_ARGUMENT;
    return [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
}

- (NSInteger)giveSecondArgument:(NSInteger)first_arg {
    int lowerBound = LOWER_LEVEL_MIN_ARGUMENT;
    int upperBound = LOWER_LEVEL_MAX_ARGUMENT;
    int random = [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
    
    while (random + first_arg > LOWER_LEVEL_MIN_ARGUMENT + LOWER_LEVEL_MAX_ARGUMENT) {
        random = [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
    }
    
    return random;
}

- (NSInteger)randomBetweenLowerBound:(NSInteger)lower_bound andUpperOne:(NSInteger)upper_bound {
    return lower_bound + arc4random() % (upper_bound - lower_bound);
}

@end
