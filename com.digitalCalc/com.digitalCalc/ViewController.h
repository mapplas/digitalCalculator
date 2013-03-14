//
//  ViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "HelpManager.h"
#import "LeftMenuViewController.h"
#import "DeviceChooser.h"
#import "LowMultLevel.h"
#import "SCAppUtils.h"
#import "LayoutPresenter.h"

@interface ViewController : UIViewController {
    CGPoint lastPoint;
    BOOL mouseSwiped;
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brushWidth;
    NSMutableArray *numbers;
    
    HelpManager *helpManager;
    LayoutPresenter *layoutPresenter;
    
    @private
    NSInteger _level;
    NSInteger _mode;
}

@property (nonatomic, strong) IBOutlet UIImageView *board;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) IBOutlet UILabel *firstArgument;
@property (nonatomic, strong) IBOutlet UILabel *secondArgument;
@property (nonatomic, strong) IBOutlet UILabel *result;

@property (nonatomic, strong) IBOutlet UISlider *resultSlider;

@property (nonatomic, strong) IBOutlet UIButton *ckeckButton;
@property (nonatomic, strong) IBOutlet UILabel *checkedLabel;

@property (nonatomic, strong) IBOutlet UIView *helpView;
@property (nonatomic, strong) IBOutlet UILabel *helpLabel;
@property (nonatomic, strong) IBOutlet UIButton *helpButton;

@property (nonatomic, strong) IBOutlet UIView *splashView;

@property (nonatomic, assign) BOOL helpEnabled;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger mode;

- (IBAction)learnModePressed:(id)sender;
- (IBAction)gameModePressed:(id)sender;

- (IBAction)segmentedControlIndexChanged;
- (IBAction)checkButtonPressed:(id)sender;
- (IBAction)sliderValueChanged:(UISlider *)sender;

- (void)checkHelpEnabledAfterMenuHidden;
- (void)mainMenuCellPressed;

@end
