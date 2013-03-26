//
//  HelpManager.h
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ArgumentLabelAnimator.h"

#define HELP_FIRST_ARG_ACTION_FINISHED 0
#define HELP_SECOND_ARG_ACTION_FINISHED 1
#define HELP_DOTS_ACTION 2
#define HELP_RESULT_ACTION_DONE 3
#define HELP_RESULT_ACTION_CHECK_PRESSED 4

@class ViewController;

@interface HelpManager : NSObject {
    UILabel *helpLabel;
    UIButton *helpButton;
    UILabel *firstArgLabel;
    UILabel *secondArgLabel;
    UIView *helpView;
    UIButton *checkButton;
    ViewController *viewController;
    UISegmentedControl *segmentedControl;
    
    ArgumentLabelAnimator *labelAnimator;
    
    NSInteger currentAction;
}

- (id)initWithHelpLabel:(UILabel *)help_label button:(UIButton *)help_button firstArgument:(UILabel *)first_arg_label secondArgument:(UILabel *)second_arg_label helpView:(UIView *)help_view andCheckButton:(UIButton *)check_button mainViewController:(ViewController *)view_controller segmentedControl:(UISegmentedControl *)segmented_control;

- (void)start;
- (void)emptyLabelText;

@end
