//
//  NSStringCamelcase.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NSStringCamelcase.h"


@implementation NSString (Camelcase)

- (NSString *)uppercaseFirst {
	unichar firstLetter = (unichar)[[self uppercaseString] characterAtIndex:0];
	return [NSString stringWithFormat:@"%c%@", firstLetter, [self substringWithRange:NSMakeRange(1, [self length] - 1)]];
}

@end
