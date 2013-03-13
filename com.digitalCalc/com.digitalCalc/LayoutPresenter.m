//
//  LayoutPresenter.m
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LayoutPresenter.h"

@implementation LayoutPresenter

- (void)setTitleToNavItem:(UINavigationItem *)navigation_item {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"5th Grade Cursive" size:12];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = NSLocalizedString(@"nav_bar_title", @"Nav bar title");
    navigation_item.titleView = label;
}

@end
