//
//  LevelMenuCell.m
//  com.digitalCalc
//
//  Created by Belén  on 12/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LevelMenuCell.h"

@implementation LevelMenuCell

@synthesize textLabel;
@synthesize image;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
