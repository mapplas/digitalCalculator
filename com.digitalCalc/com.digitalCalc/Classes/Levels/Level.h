//
//  Level.h
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@protocol Level <NSObject>

- (NSInteger)giveFirstArgument;
- (NSInteger)giveSecondArgument:(NSInteger)first_arg;

@end
