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
                                      NSLocalizedString(@"in_app_purchase_genius_level_identifier", @"In app purchase - Genius level product identifier"),
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
