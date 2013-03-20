//
//  MediumMultLevel.m
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "MediumMultLevel.h"

@implementation MediumMultLevel

- (NSInteger)giveFirstArgument {
    int lowerBound = MEDIUM_LEVEL_MIN_ARGUMENT;
    int upperBound = MEDIUM_LEVEL_MAX_ARGUMENT;
    return [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
}

- (NSInteger)giveSecondArgument:(NSInteger)first_arg {
    int lowerBound = MEDIUM_LEVEL_MIN_ARGUMENT;
    int upperBound = MEDIUM_LEVEL_MAX_ARGUMENT;
    int random = [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
    
    while (random + first_arg > MEDIUM_LEVEL_MIN_ARGUMENT + MEDIUM_LEVEL_MAX_ARGUMENT) {
        random = [self randomBetweenLowerBound:lowerBound andUpperOne:upperBound];
    }
    
    return random;
}

- (NSInteger)randomBetweenLowerBound:(NSInteger)lower_bound andUpperOne:(NSInteger)upper_bound {
    return lower_bound + arc4random() % (upper_bound - lower_bound);
}

@end
