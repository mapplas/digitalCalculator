//
//  ImageFileManager.m
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ImageFileManager.h"


@implementation ImageFileManager

- (id)initWithFileManagement:(FileManagement *)file_management {
	self = [super init];
	
	if(self) {
		fileManagement = file_management;
	}
	
	return self;
}

- (NSString *)getFolderFromImagePath:(NSString *)path {
	return [[NSString stringWithString:path] stringByReplacingOccurrencesOfRegex:@"/[a-zA-Z0-9_\\-]+\\.(png|jpe?g)$" withString:@""];
}

- (NSError *)saveImage:(UIImage *)image path:(NSString *)path folder:(IFolder *)folder {
	NSError *error = nil;
	
	NSString *fullPath = [folder getWithPath:@""];
    [fileManagement createFolder:fullPath];
    NSString *filePath = [NSString stringWithFormat:@"%@%@", fullPath, path];
	
//	NSString *folderPath = [self getFolderFromImagePath:fullPath];
//	[fileManagement createFolder:folderPath];
	
	[self writeImage:image toFile:filePath error:error];
    
	return error;
}

- (BOOL)writeImage:(UIImage *)image toFile:(NSString *)fullPath error:(NSError *)error {
    if ([self writePng:image toFile:[NSString stringWithFormat:@"%@.png", fullPath] error:error]) {
        return YES;
    }
    else if ([self writeJpg:image toFile:[NSString stringWithFormat:@"%@.jpg", fullPath] error:error]) {
        return YES;
    }
    else {
        return NO;
    }   
}

- (BOOL)writePng:(UIImage *)image toFile:(NSString *)file_path error:(NSError *)error {
    BOOL a =[UIImagePNGRepresentation(image) writeToFile:file_path options:NSDataWritingAtomic error:&error];
	return a;
}

- (BOOL)writeJpg:(UIImage *)image toFile:(NSString *)file_path error:(NSError *)error {
    BOOL a = [UIImageJPEGRepresentation(image, 100) writeToFile:file_path options:NSDataWritingAtomic error:&error];
	return a;
}

- (UIImage *)loadImage:(NSString *)path folder:(IFolder *)folder {
	
	NSString *fullPath = [folder getWithPath:@""];
	
	if([fileManagement fileExists:fullPath]) {
        
        UIImage *image = nil;
        if ([UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.png", fullPath, path]] != nil) {
            image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.png", fullPath, path]];
        }
        else if([UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", fullPath, path]] != nil) {
            image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@%@.jpg", fullPath, path]];
        }
            
		return image;
	}
	
	return nil;
}

- (BOOL)removeImage:(NSString *)path folder:(IFolder *)folder {
	NSString *fullPath = [folder getWithPath:path];
	
	BOOL result = [fileManagement removeFile:fullPath];
	
	return result;
}

- (BOOL)copyImageFromPath:(NSString *)path sourceFolder:(IFolder *)source_folder toPath:(NSString *)to_path targetFolder:(IFolder *)target_folder {
	NSString *from = [source_folder getWithPath:path];
	NSString *to = [target_folder getWithPath:to_path];
	
	NSString *folderPath = [self getFolderFromImagePath:to];
	[fileManagement createFolder:folderPath];
	
	BOOL result = [fileManagement copyFile:from to:to];
	
	return result;
}

@end