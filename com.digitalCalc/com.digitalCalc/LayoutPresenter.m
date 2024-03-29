//
//  LayoutPresenter.m
//  com.digitalCalc
//
//  Created by Belén  on 13/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LayoutPresenter.h"
#import "ViewController.h"

@implementation LayoutPresenter

- (id)initWithNavItem:(UINavigationItem *)nav_item segmentedControl:(UISegmentedControl *)segm_control helpButton:(UIButton *)help_button timerLabel:(UILabel *)timer_label navController:(UINavigationController *)main_controller multFirstArg:(UILabel *)mult_first_arg multSecondArg:(UILabel *)mult_sec_arg multSymbol:(UILabel *)mult_symbol helpAlphaView:(UIView *)help_alpha_view helpLabel:(UILabel *)help_label tapToContinue:(UILabel *)tap_to_cont afterCheckAlphaView:(UIView *)after_check_alpha_view afterCheckLabel:(UILabel *)after_check_label nextMultLabel:(UILabel *)tap_to_next_mult viewController:(ViewController *)view_controller resultSlider:(CustomSlider *)result_slider {
    
    self = [super init];
    if (self) {
        navItem = nav_item;
        segmControl = segm_control;
        helpButton = help_button;
        timerLabel = timer_label;
        mainScreenController = main_controller;
        
        firstArgument = mult_first_arg;
        secondArgument = mult_sec_arg;
        multSymbol = mult_symbol;
        
        helpAlphaView = help_alpha_view;
        helpLabel = help_label;
        tapToContinueLabel = tap_to_cont;
        
        afterCheckAlphaView = after_check_alpha_view;
        afterCheckLabel = after_check_label;
        nextMultLabel = tap_to_next_mult;
        
        viewController = view_controller;
        resultSlider = result_slider;
    }
    
    return self;
}

- (void)setTitleToNavItem {
    DeviceChooser *deficeChooser = [[DeviceChooser alloc] init];
    if ([deficeChooser isPad]) {
        navItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg_logo_iPad.png"]];
    } else {
        navItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bkg_logo.png"]];
    }
}

- (void)configureInitialLayout {
    // Segmented control
    // Image between two unselected segments.
    UIImage *transparentSeparator = [UIImage imageNamed:@"bkg_segment_separator.png"];
    
    UIBarMetrics barMetrics = UIBarMetricsLandscapePhone;
    DeviceChooser *deficeChooser = [[DeviceChooser alloc] init];
    if ([deficeChooser isPad]) {
        barMetrics = UIBarMetricsDefault;
    }
    
    [segmControl setDividerImage:transparentSeparator forLeftSegmentState:UIControlStateNormal
                         rightSegmentState:UIControlStateNormal barMetrics:barMetrics];
    // Image between segment selected on the left and unselected on the right.
    [segmControl setDividerImage:transparentSeparator forLeftSegmentState:UIControlStateSelected
                         rightSegmentState:UIControlStateNormal barMetrics:barMetrics];
    // Image between segment selected on the right and unselected on the right.
    [segmControl setDividerImage:transparentSeparator forLeftSegmentState:UIControlStateNormal
                         rightSegmentState:UIControlStateSelected barMetrics:barMetrics];
    
    [segmControl setImage:[UIImage imageNamed:@"btn_line_down.png"] forSegmentAtIndex:LINE_SEGMENT];
    
    [self initLabelFontTypes];
    
    // Result slider
    UIImage *image = [UIImage imageNamed: @"bkg_slider_highlight.png"];
    UIImage *sliderRightTrackImage = nil;
    if ([UIImage instancesRespondToSelector:@selector(resizableImageWithCapInsets:resizingMode:)]) {
        sliderRightTrackImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 0) resizingMode:UIImageResizingModeTile];
    } else {
        sliderRightTrackImage = [image stretchableImageWithLeftCapWidth:8 topCapHeight:0];
    }
    [resultSlider setMinimumTrackImage:sliderRightTrackImage forState:UIControlStateNormal];
    [resultSlider setThumbImage:[UIImage imageNamed:@"bkg_slider_handle.png"] forState:UIControlStateNormal];
    
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
    [self stopTimer];
    timerLabel.text = [NSString stringWithFormat:@"%d", GAME_MODE_COUNTDOWN];

    
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(secondDown)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)stopTimer {
    [countDownTimer invalidate];
    countDownTimer = nil;
}

- (void)rankingControllerPopped {
    [viewController gameModePressed:nil];
}

- (void)secondDown {
    NSInteger currentValue = [timerLabel.text integerValue];
    if (currentValue > 0) {
        timerLabel.text = [NSString stringWithFormat:@"%d", currentValue - 1];
    } else {
        [self stopTimer];
        
        usernameAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"username_alert_view_title", @"Username alert view title") message:NSLocalizedString(@"username_alert_view_message", @"Username alert view message") delegate:self cancelButtonTitle:NSLocalizedString(@"username_alert_view_negative_message", @"Username alert view negative message") otherButtonTitles:NSLocalizedString(@"username_alert_view_ok_message", @"Username alert view ok message"), nil];
        usernameAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [[usernameAlert textFieldAtIndex:0] setDelegate:self];
        [usernameAlert show];
    }
}

- (void)initLabelFontTypes {
    UIFont *blocklettersPotloodFood = [UIFont fontWithName:@"Blokletters Potlood" size:firstArgument.font.pointSize];
    [firstArgument setFont:blocklettersPotloodFood];
    [secondArgument setFont:blocklettersPotloodFood];
    [multSymbol setFont:blocklettersPotloodFood];
}

- (void)goToRankingScreenWithName:(NSString *)str_username {
    NSString *username = str_username;
    if ([username isEqualToString:@""]) {
        username = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    }
    
    RankingRowTable *rankingTable = [[RankingRowTable alloc] init];
    
    RankingRow *ranking = [[RankingRow alloc] init];
    ranking.points = [NSNumber numberWithInt:viewController.points];
    ranking.username = username;
    [rankingTable saveBatch:ranking];
    [rankingTable flush];
    
    RankingViewController *rankingViewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        rankingViewController = [[RankingViewController alloc] initWithNibName:@"RankingViewController_iPhone" bundle:nil];
    } else {
        rankingViewController = [[RankingViewController alloc] initWithNibName:@"RankingViewController_iPad" bundle:nil];
    }
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:rankingViewController];
    rankingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    rankingViewController.layoutPresenter = self;
    [mainScreenController presentModalViewController:controller animated:YES];
}

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [viewController gameModePressed:nil];
            break;
            
        case 1:
            [self goToRankingScreenWithName:[alertView textFieldAtIndex:0].text];
            break;
        default:
            break;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goToRankingScreenWithName:textField.text];
    [usernameAlert dismissWithClickedButtonIndex:1 animated:NO];
    return YES;
}

+ (void)resizeFontForLabel:(UILabel*)aLabel maxSize:(int)maxSize minSize:(int)minSize {
    // use font from provided label so we don't lose color, style, etc
    UIFont *font = aLabel.font;
    
    // start with maxSize and keep reducing until it doesn't clip
    for(int i = maxSize; i >= minSize; i--) {
        font = [font fontWithSize:i];
        CGSize constraintSize = CGSizeMake(aLabel.frame.size.width, MAXFLOAT);
        
        // This step checks how tall the label would be with the desired font.
        CGSize labelSize = [aLabel.text sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
        if(labelSize.height <= aLabel.frame.size.height)
            break;
    }
    // Set the UILabel's font to the newly adjusted font.
    aLabel.font = font;
}

@end
