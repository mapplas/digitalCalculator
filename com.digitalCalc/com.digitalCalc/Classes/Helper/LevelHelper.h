//
//  LevelHelper.h
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Level.h"
#import "LowMultLevel.h"
#import "MediumMultLevel.h"
#import "Constants.h"

@interface LevelHelper : NSObject {
    NSInteger level;
}

- (id)initWithSelectedLevel:(NSInteger)_level;
- (id<Level>)getLevelClass;
- (NSInteger)getFirstArgForLevel;

@end
