//
//  HelpManager.m
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "HelpManager.h"
#import "ViewController.h"

@implementation HelpManager

- (id)initWithHelpLabel:(UILabel *)help_label button:(UIButton *)help_button firstArgument:(UILabel *)first_arg_label secondArgument:(UILabel *)second_arg_label helpView:(UIView *)help_view andCheckButton:(UIButton *)check_button mainViewController:(ViewController *)view_controller segmentedControl:(UISegmentedControl *)segmented_control {
    self = [super init];
    if (self) {
        helpLabel = help_label;
        helpButton = help_button;
        firstArgLabel = first_arg_label;
        secondArgLabel = second_arg_label;
        helpView = help_view;
        checkButton = check_button;
        viewController = view_controller;
        segmentedControl = segmented_control;
        
        [helpButton addTarget:self action:@selector(nextCluePressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)start {
    DeviceChooser *chooser = [[DeviceChooser alloc] init];
    switch (viewController.helpEnabled) {
        case NO:
            checkButton.hidden = NO;
            helpButton.hidden = YES;
            helpView.hidden = YES;
            
            [checkButton setImage:[UIImage imageNamed:@"btn_check_up_white.png"] forState:UIControlStateNormal];
            [checkButton setImage:[UIImage imageNamed:@"btn_check_down_white.png"] forState:UIControlStateHighlighted];
            if ([chooser isSpanish]) {
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up_white.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down_white.png"] forState:UIControlStateHighlighted];
            }
            
            break;
            
        case YES:
            currentAction = HELP_FIRST_ARG_ACTION_FINISHED;
            
            checkButton.hidden = YES;
            helpButton.hidden = NO;
            helpView.hidden = NO;
            
            [checkButton setImage:[UIImage imageNamed:@"btn_check_up.png"] forState:UIControlStateNormal];
            [checkButton setImage:[UIImage imageNamed:@"btn_check_down.png"] forState:UIControlStateHighlighted];
            
            if ([chooser isSpanish]) {
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down.png"] forState:UIControlStateHighlighted];
            }
            
            [self setHelpText];
            break;
            
        default:
            break;
    }
}

- (void)nextCluePressed {
    switch (currentAction) {
        case HELP_FIRST_ARG_ACTION_FINISHED:
            currentAction = HELP_SECOND_ARG_ACTION_FINISHED;
            [self setHelpText];
            break;
            
        case HELP_SECOND_ARG_ACTION_FINISHED:
            currentAction = HELP_DOTS_ACTION;
            [self chooseDotsSegment];
            [self setHelpText];
            break;
            
        case HELP_DOTS_ACTION:
            currentAction = HELP_RESULT_ACTION_DONE;
            [self setHelpText];
            break;
            
        case HELP_RESULT_ACTION_DONE:
            currentAction = HELP_RESULT_ACTION_CHECK_PRESSED;
            checkButton.hidden = NO;
            helpButton.hidden = YES;
            [self setHelpText];
            break;
    }
}

//- (void)animateLabel:(UILabel *)_label {
//    [labelAnimator animateLabel:_label];    
//}

- (void)chooseDotsSegment {
    segmentedControl.selectedSegmentIndex = DOT_SEGMENT;
    [viewController segmentedControlIndexChanged];
}

- (void)setHelpText {
    helpView.hidden = NO;
    
    switch (currentAction) {
        case HELP_FIRST_ARG_ACTION_FINISHED:
            [self helpForFirstLabel:firstArgLabel secondLabel:secondArgLabel andAction:currentAction];
            break;
            
        case HELP_SECOND_ARG_ACTION_FINISHED:
            [self helpForFirstLabel:firstArgLabel secondLabel:secondArgLabel andAction:currentAction];
            break;
            
        case HELP_DOTS_ACTION:
            helpLabel.text = NSLocalizedString(@"help_text_dots_text", @"Help label draw dots text");
            break;
            
        case HELP_RESULT_ACTION_DONE:
            helpLabel.text = NSLocalizedString(@"help_text_dots_count_text", @"Help label count dots text");
            break;
        
        case HELP_RESULT_ACTION_CHECK_PRESSED:
            helpLabel.text = NSLocalizedString(@"help_text_press_check_button_text", @"Help label press check text");
            break;
    }
}

- (void)helpForFirstLabel:(UILabel *)_label1 secondLabel:(UILabel *)_label2 andAction:(NSInteger)_action {
    NSString *firstArgumentData = _label1.text;
    NSString *secondArgumentData = _label2.text;

//    /* Help label second arg sing-sing suffix */
//    "help_text_sing_sing_suffix" = "que se cruce con la anterior";
//    
//    /* Help label second arg plural-sing suffix */
//    "help_text_plural_sing_suffix" = "que se cruce con las anteriores";
//    
//    /* Help label second arg sing-plur suffix */
//    "help_text_sing_plural_suffix" = "que se crucen con la anterior";
//    
//    /* Help label second arg plural-plural suffix */
//    "help_text_plural_plural_suffix" = "que se crucen con las anteriores";
    
    switch (_action) {
        case HELP_FIRST_ARG_ACTION_FINISHED:
            if ([firstArgumentData isEqualToString:@"1"]) {
                helpLabel.text = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"help_text_prefix", @"Help label text prefix"), firstArgumentData, NSLocalizedString(@"help_text_singular_suffix", @"Help label singular line suffix")];
            }
            else {
                helpLabel.text = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"help_text_prefix", @"Help label text prefix"), firstArgumentData, NSLocalizedString(@"help_text_plural_suffix", @"Help label plural line suffix")];
            }
            break;
            
        case HELP_SECOND_ARG_ACTION_FINISHED:
            if ([secondArgumentData isEqualToString:@"1"]) {
                
                NSString *endString = NSLocalizedString(@"help_text_plural_sing_suffix", @"Help label second arg plural-sing suffix");
                if ([firstArgumentData isEqualToString:@"1"]) {
                    endString = NSLocalizedString(@"help_text_sing_sing_suffix", @"Help label second arg sing-sing suffix");
                }
                
                helpLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", NSLocalizedString(@"help_text_prefix", @"Help label text prefix"), secondArgumentData, NSLocalizedString(@"help_text_singular_suffix", @"Help label singular line suffix"), endString];
            }
            else {
                
                NSString *endString = NSLocalizedString(@"help_text_plural_plural_suffix", @"Help label second arg plural-plural suffix");
                if ([firstArgumentData isEqualToString:@"1"]) {
                    endString = NSLocalizedString(@"help_text_sing_plural_suffix", @"Help label second arg sing-plur suffix");
                }
                
                helpLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@", NSLocalizedString(@"help_text_prefix", @"Help label text prefix"), secondArgumentData, NSLocalizedString(@"help_text_plural_suffix", @"Help label plural line suffix"), endString];
            }

            break;
            
        default:
            break;
    }
}

- (void)emptyLabelText {
    helpLabel.text = @"";
}

@end
