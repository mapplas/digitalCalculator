//
//  LayoutPresenter.h
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface LayoutPresenter : NSObject {
    UINavigationItem *navItem;
    UISegmentedControl *segmControl;
    UIButton *helpButton;
    UILabel *timerLabel;
    
    NSTimer *countDownTimer;
}

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button timerLabel:(UILabel *)timer_label;

- (void)setTitleToNavItem;
- (void)configureInitialLayout;
- (void)resetActionLoaded:(NSInteger)_mode;
- (void)initTimer;

@end
