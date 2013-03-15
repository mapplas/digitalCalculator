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

@interface LayoutPresenter : NSObject {
    UINavigationItem *navItem;
    UISegmentedControl *segmControl;
    
    UIButton *helpButton;
    
    UILabel *timerLabel;
    
    UINavigationController *mainScreenController;
    
    UILabel *firstArgument;
    UILabel *secondArgument;
    UILabel *result;
    UILabel *resutSymbol;
    UILabel *multSymbol;
    
    UIView *helpAlphaView;
    UILabel *helpLabel;
    
    NSTimer *countDownTimer;
}

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button timerLabel:(UILabel *)timer_label navController:(UINavigationController *)main_controller multFirstArg:(UILabel *)mult_first_arg multSecondArg:(UILabel *)mult_sec_arg result:(UILabel *)_result resultSymbol:(UILabel *)result_symbol multSymbol:(UILabel *)mult_symbol helpAlphaView:(UIView *)help_alpha_view helpLabel:(UILabel *)help_label;

- (void)setTitleToNavItem;
- (void)configureInitialLayout;
- (void)resetActionLoaded:(NSInteger)_mode;
- (void)initTimer;

@end
