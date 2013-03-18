//
//  FileManagement.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegexKitLite.h"

@interface FileManagement : NSObject {
	@private
	NSFileManager *fileManager;
}

- (BOOL)createFolder:(NSString *)pathToFolder;
- (NSString *)getFileExtension:(NSString *)filename;
- (BOOL)removeFile:(NSString *)path;
- (void)removeFolder:(NSString *)folder recursive:(BOOL)recursive;
- (BOOL)moveFile:(NSString *)from to:(NSString *)to;
- (BOOL)copyFile:(NSString *)from to:(NSString *)to;
- (BOOL)fileExists:(NSString *)path;

@end
