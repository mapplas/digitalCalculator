//
//  HelpManager.m
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "HelpManager.h"

@implementation HelpManager

- (id)initWithHelpLabel:(UILabel *)help_label button:(UIButton *)help_button firstArgument:(UILabel *)first_arg_label secondArgument:(UILabel *)second_arg_label helpView:(UIView *)help_view andCheckButton:(UIButton *)check_button {
    self = [super init];
    if (self) {
        helpLabel = help_label;
        helpButton = help_button;
        firstArgLabel = first_arg_label;
        secondArgLabel = second_arg_label;
        helpView = help_view;
        checkButton = check_button;
        
        [helpButton addTarget:self action:@selector(nextCluePressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)start {
    currentAction = HELP_FIRST_ARG_ACTION_FINISHED;
    
    checkButton.hidden = YES;
    helpButton.hidden = NO;
    
    [self setHelpText];
}

- (void)nextCluePressed {
    switch (currentAction) {
        case HELP_FIRST_ARG_ACTION_FINISHED:
            currentAction = HELP_SECOND_ARG_ACTION_FINISHED;
            [self setHelpText];
            break;
            
        case HELP_SECOND_ARG_ACTION_FINISHED:
            currentAction = HELP_DOTS_ACTION;
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

- (void)setHelpText {
    helpView.hidden = NO;
    
    switch (currentAction) {
        case HELP_FIRST_ARG_ACTION_FINISHED:
            [self helpForLabel:firstArgLabel];
            break;
            
        case HELP_SECOND_ARG_ACTION_FINISHED:
            [self helpForLabel:secondArgLabel];
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

- (void)helpForLabel:(UILabel *)_label {
    NSString *firstArgumentData = _label.text;
    if ([firstArgumentData isEqualToString:@"1"]) {
        helpLabel.text = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"help_text_prefix", @"Help label text prefix"), firstArgumentData, NSLocalizedString(@"help_text_singular_suffix", @"Help label singular line suffix")];
    }
    else {
        helpLabel.text = [NSString stringWithFormat:@"%@ %@ %@", NSLocalizedString(@"help_text_prefix", @"Help label text prefix"), firstArgumentData, NSLocalizedString(@"help_text_plural_suffix", @"Help label plural line suffix")];
    }
}

- (void)emptyLabelText {
    helpLabel.text = @"";
}

@end
