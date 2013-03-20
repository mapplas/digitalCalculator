//
//  GeniusLevelIAPHelper.m
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GeniusLevelIAPHelper.h"

@implementation GeniusLevelIAPHelper

+ (GeniusLevelIAPHelper *)sharedInstance {
    static dispatch_once_t once;
    static GeniusLevelIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.digitalCalc.inappgeniuslevel",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
