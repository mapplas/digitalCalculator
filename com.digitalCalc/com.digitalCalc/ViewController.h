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

#import "Level.h"
#import "LowMultLevel.h"
#import "MediumMultLevel.h"
#import "LevelHelper.h"

#import "LayoutPresenter.h"
#import "CustomSlider.h"
#import "InAppPurchaseViewController.h"
#import "HowToGalleryViewController.h"

@interface ViewController : UIViewController {
    CGPoint lastPoint;
    BOOL mouseSwiped;
    
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    CGFloat _brushWidth;
    NSMutableArray *numbers;
    
    HelpManager *helpManager;
    LayoutPresenter *layoutPresenter;
    CustomSlider *slider;
    
    NSInteger _points;
    
    NSArray *_products;
    
    @private
    NSInteger level;
    NSInteger _mode;
}

@property (nonatomic, strong) IBOutlet UIImageView *board;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) IBOutlet UILabel *firstArgument;
@property (nonatomic, strong) IBOutlet UILabel *multSymbol;
@property (nonatomic, strong) IBOutlet UILabel *secondArgument;

@property (nonatomic, strong) IBOutlet UISlider *resultSlider;

@property (nonatomic, strong) IBOutlet UIButton *ckeckButton;
@property (nonatomic, strong) IBOutlet UIView *afterCheckedView;
@property (nonatomic, strong) IBOutlet UIView *afterCheckedAlphaView;
@property (nonatomic, strong) IBOutlet UILabel *checkedLabel;
@property (nonatomic, strong) IBOutlet UILabel *tapToNextMultLabel;

@property (nonatomic, strong) IBOutlet UIView *helpView;
@property (nonatomic, strong) IBOutlet UIView *helpAlphaView;
@property (nonatomic, strong) IBOutlet UILabel *helpLabel;
@property (nonatomic, strong) IBOutlet UIButton *helpButton;
@property (nonatomic, strong) IBOutlet UILabel *tapToContinueLabel;

@property (nonatomic, strong) IBOutlet UILabel *timerLabel;

@property (nonatomic, strong) IBOutlet UIView *splashView;

@property (nonatomic, assign) CGFloat red;
@property (nonatomic, assign) CGFloat green;
@property (nonatomic, assign) CGFloat blue;
@property (nonatomic, assign) CGFloat brushWidth;

@property (nonatomic, assign) BOOL helpEnabled;
//@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger mode;
@property (nonatomic, assign) NSInteger points;

- (IBAction)learnModePressed:(id)sender;
- (IBAction)gameModePressed:(id)sender;

- (IBAction)segmentedControlIndexChanged;
- (IBAction)checkButtonPressed:(id)sender;

- (void)checkHelpEnabledAfterMenuHidden;
- (void)mainMenuCellPressed;

- (void)setLevel:(NSInteger)_level;
- (NSInteger)level;

@end
