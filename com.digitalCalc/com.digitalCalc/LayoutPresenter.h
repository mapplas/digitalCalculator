//
//  LayoutPresenter.h
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "RankingViewController.h"

@interface LayoutPresenter : NSObject {
    UINavigationItem *navItem;
    UISegmentedControl *segmControl;
    UIButton *helpButton;
    UILabel *timerLabel;
    UINavigationController *mainScreenController;
    
    NSTimer *countDownTimer;
}

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button timerLabel:(UILabel *)timer_label navController:(UINavigationController *)main_controller;

- (void)setTitleToNavItem;
- (void)configureInitialLayout;
- (void)resetActionLoaded:(NSInteger)_mode;
- (void)initTimer;

@end
