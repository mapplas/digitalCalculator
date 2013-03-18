//
//  ViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ViewController.h"
#import "PKRevealController.h"

@interface ViewController ()
- (void)initNavBar;
- (void)clearAll;
- (void)ckeckLevel;
- (BOOL)checkVisibleLabels;
- (void)reset;
@end

@implementation ViewController

@synthesize board;
@synthesize segmentedControl;
@synthesize firstArgument, secondArgument, result, multSymbol, resutSymbol;
@synthesize resultSlider;
@synthesize ckeckButton, afterCheckedView, afterCheckedAlphaView, checkedLabel, tapToNextMultLabel;
@synthesize helpView, helpAlphaView, helpLabel, helpButton, tapToContinueLabel;
@synthesize timerLabel;

@synthesize splashView;

@synthesize helpEnabled;
@synthesize mode = _mode, level = _level, points = _points;
@synthesize red = _red, green = _green, blue = _blue, brushWidth = _brushWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.helpEnabled = NO;
    
    layoutPresenter = [[LayoutPresenter alloc] initWithNavItem:self.navigationItem segmentedControl:self.segmentedControl helpButton:self.helpButton timerLabel:self.timerLabel navController:self.navigationController multFirstArg:self.firstArgument multSecondArg:self.secondArgument result:self.result resultSymbol:self.resutSymbol multSymbol:self.multSymbol helpAlphaView:self.helpAlphaView helpLabel:self.helpLabel tapToContinue:self.tapToContinueLabel afterCheckAlphaView:self.afterCheckedAlphaView afterCheckLabel:self.checkedLabel nextMultLabel:self.tapToNextMultLabel viewController:self resultSlider:self.resultSlider];
    
    helpManager = [[HelpManager alloc] initWithHelpLabel:self.helpLabel button:self.helpButton firstArgument:self.firstArgument secondArgument:self.secondArgument helpView:self.helpView andCheckButton:self.ckeckButton mainViewController:self];
    
    [self setSplashLayoutDetails];
    
    [layoutPresenter configureInitialLayout];
}

- (void)setSplashLayoutDetails {
    [self.view addSubview:self.splashView];
    
    [layoutPresenter setTitleToNavItem];
}

// Learn mode pressed
- (IBAction)learnModePressed:(id)sender {
    self.mode = CALCULATOR_MODE_LEARN;
    [self initNavBar];
    
//    Help is always enabled in learn mode
    self.helpEnabled = YES;
    
    [UIView animateWithDuration:0.5f
                     animations:^{self.splashView.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.view sendSubviewToBack:self.splashView]; }];
    
    [self reset];
}

// Game mode pressed
- (IBAction)gameModePressed:(id)sender {
    self.mode = CALCULATOR_MODE_GAME;
    self.timerLabel.text = [NSString stringWithFormat:@"%d", GAME_MODE_COUNTDOWN];
    [self initNavBar];
    
//    Help is always disabled in learn mode
    self.helpEnabled = NO;
    self.points = 0;
    
    [UIView animateWithDuration:0.5f
                     animations:^{self.splashView.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.view sendSubviewToBack:self.splashView]; }];
    
    [self reset];
    [layoutPresenter initTimer];
}

#pragma mark - Shake event
-(BOOL)canBecomeFirstResponder {
	return YES;
}

-(void)viewDidAppear:(BOOL)animated{ 
	[super viewDidAppear:animated];
	[self becomeFirstResponder];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake){
		[self reset];
	}
}

#pragma mark - Segmented Control
- (IBAction)segmentedControlIndexChanged {
    DeviceChooser *deviceChooser = [[DeviceChooser alloc] init];
    BOOL isIpad = [deviceChooser isPad];
    
    switch (self.segmentedControl.selectedSegmentIndex) {
        case LINE_SEGMENT:
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_line_down.png"] forSegmentAtIndex:0];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_dot_up.png"] forSegmentAtIndex:1];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_erase_up.png"] forSegmentAtIndex:2];
            
            self.red = LINE_COLOR_RED;
            self.green = LINE_COLOR_GREEN;
            self.blue = LINE_COLOR_BLUE;
            self.brushWidth = LINE_BRUSH_WIDE;
            break;
            
        case DOT_SEGMENT:
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_line_up.png"] forSegmentAtIndex:0];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_dot_down.png"] forSegmentAtIndex:1];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_erase_up.png"] forSegmentAtIndex:2];
            
            self.red = DOT_COLOR_RED;
            self.green = DOT_COLOR_GREEN;
            self.blue = DOT_COLOR_BLUE;
            self.brushWidth = DOT_BRUSH_WIDE_IPHONE;
            
            if (isIpad) {
                self.brushWidth = DOT_BRUSH_WIDE_IPAD;
            }
            break;
            
        case ERASE_SEGMENT:
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_line_up.png"] forSegmentAtIndex:0];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_dot_up.png"] forSegmentAtIndex:1];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_erase_down.png"] forSegmentAtIndex:2];
            
            self.red = LINE_COLOR_BLUE;
            self.green = LINE_COLOR_BLUE;
            self.blue = LINE_COLOR_BLUE;
            self.brushWidth = ERASE_BRUSH_WIDE;
            break;
    }
}

#pragma mark - Touch methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = NO;
        
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.board];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self.board];
    
        if (self.segmentedControl.selectedSegmentIndex != DOT_SEGMENT) {
            mouseSwiped = YES;
            
            UIColor *brushPattern = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"bkg_chalk.png"]];
            CGColorRef fillColor = [brushPattern CGColor];
            CGColorRef strokeColor = [brushPattern CGColor];
            
        
            UIGraphicsBeginImageContext(self.board.frame.size);
            [self.board.image drawInRect:CGRectMake(0, 0, self.board.frame.size.width, self.board.frame.size.height)];
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapSquare);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushWidth);
//            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, COLOR_ALPHA_OPAQUE);
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
            
            CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), strokeColor);
            CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), fillColor);
        
            if (self.segmentedControl.selectedSegmentIndex == ERASE_SEGMENT) {
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, COLOR_ALPHA_CLEAR);
                CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
            }
        
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            self.board.image = UIGraphicsGetImageFromCurrentImageContext();
            [self.board setAlpha:1.0];
            UIGraphicsEndImageContext();
        }
    
        lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self checkVisibleLabels]) {
        if(!mouseSwiped) {
            UIGraphicsBeginImageContext(self.board.frame.size);
            [self.board.image drawInRect:CGRectMake(0, 0, self.board.frame.size.width, self.board.frame.size.height)];
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushWidth);
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, COLOR_ALPHA_OPAQUE);
        
            if (self.segmentedControl.selectedSegmentIndex == ERASE_SEGMENT) {
                CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0, 0, 0, COLOR_ALPHA_CLEAR);
                CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
            }
        
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
            CGContextStrokePath(UIGraphicsGetCurrentContext());
            CGContextFlush(UIGraphicsGetCurrentContext());
            self.board.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
}

#pragma mark - UISlider methods
- (void)sliderValueChanged:(UISlider *)sender {
    self.result.text = [NSString stringWithFormat:@"%.f", [sender value]];
}

# pragma mark - Private methods
- (void)initNavBar {
    self.navigationItem.titleView = self.segmentedControl;
    
    UIImage *navBarButtonUp = [UIImage imageNamed:@"btn_menu_up.png"];
    UIImage *navBarButtonHover = [UIImage imageNamed:@"btn_menu_hover.png"];
    
    UIImage *menuImage = [UIImage imageNamed:@"ic_menu_menu.png"];
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menuImage landscapeImagePhone:menuImage style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView)];
        [self.navigationItem.leftBarButtonItem setBackgroundImage:navBarButtonUp forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem.leftBarButtonItem setBackgroundImage:navBarButtonHover forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear all" style:UIBarButtonItemStylePlain target:self action:@selector(clearAll)];
    [self.navigationItem.rightBarButtonItem setBackgroundImage:navBarButtonUp forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem.rightBarButtonItem setBackgroundImage:navBarButtonHover forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (void)showLeftView {
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController) {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else {
        LeftMenuViewController *leftVC = (LeftMenuViewController *)self.navigationController.revealController.leftViewController;
        leftVC.helpLabel = self.helpLabel;
        leftVC.helpButton = self.helpButton;
        leftVC.helpView = self.helpView;
        
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

- (BOOL)checkVisibleLabels {
    // If helpView is visible set as hidden
    if (!self.helpView.hidden) {
        self.helpView.hidden = YES;
        return YES;
    }
    
    // If after checked label is visible set as hidden
    if (!self.afterCheckedView.hidden) {
        self.afterCheckedView.hidden = YES;
        
        if ([self.result.text isEqualToString:[NSString stringWithFormat:@"%d", [self.firstArgument.text integerValue] * [self.secondArgument.text integerValue]]]) {
            [self reset];
        }
        
        return YES;
    }
    return NO;
}

- (void)clearAll {
    self.board.image = nil;
}

- (void)reset {
    [self clearAll];
    
    // Level
    self.level = LEVEL_LOW;
    [self ckeckLevel];
    
    // Color and brush wide
    [layoutPresenter resetActionLoaded:self.mode];
    
    self.red = LINE_COLOR_RED;
    self.green = LINE_COLOR_GREEN;
    self.blue = LINE_COLOR_BLUE;
    self.brushWidth = LINE_BRUSH_WIDE;
    
    [helpManager start];
    
    afterCheckedView.hidden = YES;
}

- (void)ckeckLevel {
    LowMultLevel *lowMultLevel = [[LowMultLevel alloc] init];
    NSInteger firstArg = [lowMultLevel giveFirstArgument];

    switch (self.level) {
        case LEVEL_LOW:
            
            self.firstArgument.text = [NSString stringWithFormat:@"%d", firstArg];
            self.secondArgument.text = [NSString stringWithFormat:@"%d", [lowMultLevel giveSecondArgument:firstArg]];
            
            self.resultSlider.maximumValue = 30;
            self.resultSlider.minimumValue = 0;
            self.resultSlider.value = self.resultSlider.minimumValue;
            self.result.text = [NSString stringWithFormat:@"%.f", self.resultSlider.value];
            break;
            
        default:
            break;
    }
}

//- (NSInteger)numberOfComponents {
//    return [[NSString stringWithFormat: @"%i", [self.firstArgument.text intValue] * [self.secondArgument.text intValue]] length];
//}

- (IBAction)checkButtonPressed:(id)sender {
    NSInteger firstArgumentIntValue = [self.firstArgument.text integerValue];
    NSInteger secondArgumentIntValue = [self.secondArgument.text integerValue];
    NSInteger resultIntValue = firstArgumentIntValue * secondArgumentIntValue;
    
    [helpManager emptyLabelText];

    self.afterCheckedView.hidden = NO;
    if (self.mode == CALCULATOR_MODE_LEARN) {
        if ([self.result.text isEqualToString:[NSString stringWithFormat:@"%d", resultIntValue]]) {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_ok_learn_mode", @"Result ckecked OK text in learn mode");
        }
        else {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_nok_learn_mode", @"Result ckecked NOK text in learn mode");
        }
    } else { // GAME MODE
        if ([self.result.text isEqualToString:[NSString stringWithFormat:@"%d", resultIntValue]]) {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_ok_game_mode", @"Result ckecked OK text in game mode");
            
            self.points += GAME_MODE_CORRECT_ANSWER;
        }
        else {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_nok_lgame_mode", @"Result ckecked NOK text in game mode");
        }
    }
}

- (void)checkHelpEnabledAfterMenuHidden {
    if (self.helpEnabled) {
        [helpManager start];
    } else {
        [self.ckeckButton setHidden:NO];
    }
}

- (void)mainMenuCellPressed {
    [layoutPresenter stopTimer];

    [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    
    [UIView animateWithDuration:.05f
                     animations:^{self.splashView.alpha = 1.0;}
                     completion:^(BOOL finished){ [self.view bringSubviewToFront:self.splashView]; }];
    
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = nil;
    
    [layoutPresenter setTitleToNavItem];
}


@end
