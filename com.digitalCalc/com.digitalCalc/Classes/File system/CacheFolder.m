//
//  CacheFolder.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "CacheFolder.h"

@implementation CacheFolder

- (NSString *)get {
	NSString *cache = @"/cache";
	
	return [super getWithPath:cache];
}

- (NSString *)getWithPath:(NSString *)path {
	return [NSString stringWithFormat:@"%@/%@", [self get], path];
}

@end