//
//  DocumentsFolder.h
//  Mapplas
//
//  Created by Belén  on 24/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "IFolder.h"

@interface DocumentsFolder : IFolder {
	@private
	NSFileManager *fileManager;
	NSString *documentsPath;
}

@end
