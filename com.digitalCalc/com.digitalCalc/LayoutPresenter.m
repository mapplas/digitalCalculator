//
//  LayoutPresenter.m
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LayoutPresenter.h"

@implementation LayoutPresenter

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button timerLabel:(UILabel *)timer_label navController:(UINavigationController *)main_controller {
    self = [super init];
    if (self) {
        navItem = nav_item;
        segmControl = segm_control;
        helpButton = help_button;
        timerLabel = timer_label;
        mainScreenController = main_controller;
    }
    return self;
}

- (void)setTitleToNavItem {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"5th Grade Cursive" size:12];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = NSLocalizedString(@"nav_bar_title", @"Nav bar title");
    navItem.titleView = label;
}

- (void)configureInitialLayout {
    // Segmented control
    // Image between two unselected segments.
    UIImage *transparentSeparator = [UIImage imageNamed:@"transparente.png"];
    UIBarMetrics barMetrics = UIBarMetricsLandscapePhone;
    
    [segmControl setDividerImage:transparentSeparator forLeftSegmentState:UIControlStateNormal
                         rightSegmentState:UIControlStateNormal barMetrics:barMetrics];
    // Image between segment selected on the left and unselected on the right.
    [segmControl setDividerImage:transparentSeparator forLeftSegmentState:UIControlStateSelected
                         rightSegmentState:UIControlStateNormal barMetrics:barMetrics];
    // Image between segment selected on the right and unselected on the right.
    [segmControl setDividerImage:transparentSeparator forLeftSegmentState:UIControlStateNormal
                         rightSegmentState:UIControlStateSelected barMetrics:barMetrics];
    
    // Help button
    [helpButton setTitle:NSLocalizedString(@"help_next_clue_button", @"Help next clue button text") forState:UIControlStateNormal];
}

- (void)resetActionLoaded:(NSInteger)_mode {
    segmControl.selectedSegmentIndex = 0;
    
    if (_mode == CALCULATOR_MODE_LEARN) {
        [timerLabel setHidden:YES];
    } else {
        [timerLabel setHidden:NO];
    }
}

- (void)initTimer {
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(secondDown)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)secondDown {
    NSInteger currentValue = [timerLabel.text integerValue];
    if (currentValue > 0) {
        timerLabel.text = [NSString stringWithFormat:@"%d", currentValue - 1];
    } else {
        [countDownTimer invalidate];
        countDownTimer = nil;
        
        RankingViewController *rankingViewController = [[RankingViewController alloc] init];
        [mainScreenController presentModalViewController:rankingViewController animated:YES];
    }
}

@end
