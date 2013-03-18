//
//  RankingRow.h
//  com.digitalCalc
//
//  Created by Belén  on 18/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Unit.h"

@interface RankingRow : Unit {
    NSString *_username;
    NSNumber *_points;
    NSString *_date;
}

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSNumber *points;
@property (nonatomic, strong) NSString *date;

@end
