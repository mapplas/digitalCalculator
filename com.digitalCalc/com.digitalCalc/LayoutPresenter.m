//
//  LayoutPresenter.m
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LayoutPresenter.h"

@implementation LayoutPresenter

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button red:(CGFloat)_red green:(CGFloat)_green blue:(CGFloat)_blue brushWide:(CGFloat)brush_wide timerLabel:(UILabel *)timer_label {
    self = [super init];
    if (self) {
        navItem = nav_item;
        segmControl = segm_control;
        helpButton = help_button;
        red = _red;
        green = _green;
        blue = _blue;
        brushWidth = brush_wide;
        timerLabel = timer_label;
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
    red = LINE_COLOR_RED;
    green = LINE_COLOR_GREEN;
    blue = LINE_COLOR_BLUE;
    brushWidth = LINE_BRUSH_WIDE;
    
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
    }
}

@end
