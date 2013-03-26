//
//  LevelHelper.m
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LevelHelper.h"

@implementation LevelHelper

- (id)initWithSelectedLevel:(NSInteger)_level {
    self = [super init];
    if (self) {
        level = _level;
    }
    return self;
}

- (id<Level>)getLevelClass {
    switch (level) {
        case LEVEL_LOW:
            return [[LowMultLevel alloc] init];
            break;
            
        case LEVEL_MEDIUM:
            return [[MediumMultLevel alloc] init];
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSInteger)getFirstArgForLevel {
    LowMultLevel *lowMultLevel = [[LowMultLevel alloc] init];
    MediumMultLevel *mediumMultLevel = [[MediumMultLevel alloc] init];

    switch (level) {
        case LEVEL_LOW:
            return [lowMultLevel giveFirstArgument];
            break;
            
            case LEVEL_MEDIUM:
            return [mediumMultLevel giveFirstArgument];
            
        default:
            return -1;
            break;
    }
}

@end
