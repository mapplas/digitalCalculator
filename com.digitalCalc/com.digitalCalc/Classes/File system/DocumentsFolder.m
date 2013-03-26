//
//  DocumentsFolder.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "DocumentsFolder.h"

@implementation DocumentsFolder

- (id)init {
	self = [super init];

	fileManager = [NSFileManager defaultManager];
	documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];

	return self;
}

- (NSString *)getWithPath:(NSString *)path {
	return [documentsPath stringByAppendingPathComponent:path];
}

- (NSString *)get {
	return documentsPath;
}

@end
