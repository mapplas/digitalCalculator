//
//  ImageFileManager.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RegexKitLite.h"
#import "IFolder.h"
#import "FileManagement.h"

@interface ImageFileManager : NSObject {
	FileManagement *fileManagement;
}

- (id)initWithFileManagement:(FileManagement *)file_management;
- (UIImage *)loadImage:(NSString *)path folder:(IFolder *)folder;
- (NSError *)saveImage:(UIImage *)image path:(NSString *)path folder:(IFolder *)folder;
- (BOOL)removeImage:(NSString *)path folder:(IFolder *)folder;
- (BOOL)copyImageFromPath:(NSString *)path sourceFolder:(IFolder *)source_folder toPath:(NSString *)to_path targetFolder:(IFolder *)target_folder;
- (BOOL)writePng:(UIImage *)image toFile:(NSString *)file_path error:(NSError *)error;
- (BOOL)writeJpg:(UIImage *)image toFile:(NSString *)file_path error:(NSError *)error;

@end
