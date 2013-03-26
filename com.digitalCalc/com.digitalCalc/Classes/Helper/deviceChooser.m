//
//  DeviceChooser.m
//  com.digitalCalc
//
//  Created by Belén  on 11/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DeviceChooser.h"

@implementation DeviceChooser

- (BOOL)isPad {
#ifdef UI_USER_INTERFACE_IDIOM
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#endif
    return NO;
}

- (BOOL)isSpanish {
    NSArray *preferredLanguages = [NSLocale preferredLanguages];
    return [[preferredLanguages objectAtIndex:0] isEqualToString:@"es"];
}

@end
