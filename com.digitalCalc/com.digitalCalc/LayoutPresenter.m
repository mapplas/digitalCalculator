//
//  LayoutPresenter.m
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LayoutPresenter.h"

@implementation LayoutPresenter

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button timerLabel:(UILabel *)timer_label navController:(UINavigationController *)main_controller multFirstArg:(UILabel *)mult_first_arg multSecondArg:(UILabel *)mult_sec_arg result:(UILabel *)_result resultSymbol:(UILabel *)result_symbol multSymbol:(UILabel *)mult_symbol helpAlphaView:(UIView *)help_alpha_view helpLabel:(UILabel *)help_label tapToContinue:(UILabel *)tap_to_cont afterCheckAlphaView:(UIView *)after_check_alpha_view afterCheckLabel:(UILabel *)after_check_label nextMultLabel:(UILabel *)tap_to_next_mult {
    
    self = [super init];
    if (self) {
        navItem = nav_item;
        segmControl = segm_control;
        helpButton = help_button;
        timerLabel = timer_label;
        mainScreenController = main_controller;
        
        firstArgument = mult_first_arg;
        secondArgument = mult_sec_arg;
        result = _result;
        resutSymbol = result_symbol;
        multSymbol = mult_symbol;
        
        helpAlphaView = help_alpha_view;
        helpLabel = help_label;
        tapToContinueLabel = tap_to_cont;
        
        afterCheckAlphaView = after_check_alpha_view;
        afterCheckLabel = after_check_label;
        nextMultLabel = tap_to_next_mult;
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
    
    [self initLabelFontTypes];
    
    // Help view
    helpAlphaView.layer.cornerRadius = 20;
    helpAlphaView.layer.masksToBounds = YES;
    
    tapToContinueLabel.text = NSLocalizedString(@"help_text_tap_to_continue", @"Help tap to continue label text");
    
    [helpLabel setFont:[UIFont fontWithName:@"Blokletters Potlood" size:helpLabel.font.pointSize]];
    [tapToContinueLabel setFont:[UIFont fontWithName:@"Blokletters Potlood" size:tapToContinueLabel.font.pointSize]];
    
    // After check view
    afterCheckAlphaView.layer.cornerRadius = 20;
    afterCheckAlphaView.layer.masksToBounds = YES;
    
    nextMultLabel.text = NSLocalizedString(@"help_text_tap_to_continue", @"Help tap to continue label text");
    
    [afterCheckLabel setFont:[UIFont fontWithName:@"Blokletters Potlood" size:afterCheckLabel.font.pointSize]];
    [nextMultLabel setFont:[UIFont fontWithName:@"Blokletters Potlood" size:nextMultLabel.font.pointSize]];
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

- (void)initLabelFontTypes {
    [firstArgument setFont:[UIFont fontWithName:@"Blokletters Potlood" size:firstArgument.font.pointSize]];
    [secondArgument setFont:[UIFont fontWithName:@"Blokletters Potlood" size:secondArgument.font.pointSize]];
    [result setFont:[UIFont fontWithName:@"The Girl Next Door" size:result.font.pointSize]];
    [resutSymbol setFont:[UIFont fontWithName:@"The Girl Next Door" size:resutSymbol.font.pointSize]];
    [multSymbol setFont:[UIFont fontWithName:@"Blokletters Potlood" size:multSymbol.font.pointSize]];
}

@end
