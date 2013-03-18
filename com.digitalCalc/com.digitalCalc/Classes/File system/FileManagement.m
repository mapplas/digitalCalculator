//
//  FileManagement.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "FileManagement.h"


@implementation FileManagement

- (id)init {
	self = [super init];
	
	if(self) {
		fileManager = [NSFileManager defaultManager];
	}
	
	return self;
}

- (BOOL)createFolder:(NSString *)pathToFolder {
	if (![self fileExists:pathToFolder]) {
		return [fileManager createDirectoryAtPath:pathToFolder withIntermediateDirectories:YES attributes:nil error:NULL];
	}

	return YES;
}

- (NSString *)getFileExtension:(NSString *)filename {
	NSArray *matches = [filename componentsMatchedByRegex:@"\\.([^\\.]*)$"];
	if([matches count] > 0) {
		return [matches objectAtIndex:0];
	}
	
	return @"";
}

- (BOOL)removeFile:(NSString *)path {
	NSError *error = nil;

	[fileManager removeItemAtPath:path error:&error];
	if(error) {
		//NSLog(@"Error removing %@ [%@]", path, [error localizedDescription]);
		return NO;
	}
	else {
		//NSLog(@"Removed %@", path);
		return YES;
	}
}

- (void)removeFolder:(NSString *)folder recursive:(BOOL)recursive {
	if([fileManager isReadableFileAtPath:folder]) {
		NSError *error = nil;
		for (NSString *file in [fileManager contentsOfDirectoryAtPath:folder error:&error]) {
			NSString *currentFile = [NSString stringWithFormat:@"%@/%@", folder, file];
			
			BOOL isFolder = NO;
			BOOL result = [fileManager fileExistsAtPath:currentFile isDirectory:&isFolder];
			
			if(result && isFolder) {
				if(recursive) {
					[self removeFolder:currentFile recursive:recursive];
					[self removeFile:currentFile];
				}
			}
			else if(result) {
				[self removeFile:currentFile];
			}
		}
		
		[self removeFile:folder];
	}
}

- (BOOL)moveFile:(NSString *)from to:(NSString *)to {
	NSError *error;
	
	return [fileManager moveItemAtPath:from toPath:to error:&error];
}

- (BOOL)copyFile:(NSString *)from to:(NSString *)to {
	NSError *error;
	
	[self removeFile:to];
	
	return [fileManager copyItemAtPath:from toPath:to error:&error];
}

- (BOOL)fileExists:(NSString *)path {
	return [fileManager fileExistsAtPath:path];
}

@end