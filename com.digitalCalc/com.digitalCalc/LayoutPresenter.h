//
//  LayoutPresenter.h
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "RankingViewController.h"

@class ViewController;

@interface LayoutPresenter : NSObject {
    UINavigationItem *navItem;
    UISegmentedControl *segmControl;
    
    UIButton *helpButton;
    
    UILabel *timerLabel;
    
    UINavigationController *mainScreenController;
    ViewController *viewController;
    
    UILabel *firstArgument;
    UILabel *secondArgument;
    UILabel *result;
    UILabel *resutSymbol;
    UILabel *multSymbol;
    
    UIView *helpAlphaView;
    UILabel *helpLabel;
    UILabel *tapToContinueLabel;
    
    UIView *afterCheckAlphaView;
    UILabel *afterCheckLabel;
    UILabel *nextMultLabel;
        
    NSTimer *countDownTimer;
}

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button timerLabel:(UILabel *)timer_label navController:(UINavigationController *)main_controller multFirstArg:(UILabel *)mult_first_arg multSecondArg:(UILabel *)mult_sec_arg result:(UILabel *)_result resultSymbol:(UILabel *)result_symbol multSymbol:(UILabel *)mult_symbol helpAlphaView:(UIView *)help_alpha_view helpLabel:(UILabel *)help_label tapToContinue:(UILabel *)tap_to_cont afterCheckAlphaView:(UIView *)after_check_alpha_view afterCheckLabel:(UILabel *)after_check_label nextMultLabel:(UILabel *)tap_to_next_mult viewController:(ViewController *)view_controller;

- (void)setTitleToNavItem;
- (void)configureInitialLayout;
- (void)resetActionLoaded:(NSInteger)_mode;

- (void)initTimer;
- (void)stopTimer;

- (void)rankingControllerPopped;

@end
