//
//  ViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ViewController.h"
#import "PKRevealController.h"

#import <StoreKit/StoreKit.h>
#import "GeniusLevelIAPHelper.h"

@interface ViewController ()
- (void)initNavBar;
- (void)clearAll;
- (void)ckeckLevel;
- (BOOL)alphaViewVisible;
- (void)reset;
- (void)initInAppPurchaseConfig;
@end

@implementation ViewController

@synthesize board;
@synthesize segmentedControl;
@synthesize firstArgument, secondArgument, multSymbol;
@synthesize resultSlider;
@synthesize ckeckButton, afterCheckedView, afterCheckedAlphaView, checkedLabel, tapToNextMultLabel;
@synthesize helpView, helpAlphaView, helpLabel, helpButton, tapToContinueLabel;
@synthesize timerLabel;

@synthesize splashView;

@synthesize helpEnabled;
@synthesize points = _points;
@synthesize red = _red, green = _green, blue = _blue, brushWidth = _brushWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initInAppPurchaseConfig];
    [self launchTutorialOnlyFirstTime];
    
    self.helpEnabled = YES;
    level = LEVEL_LOW;
    slider = (CustomSlider *)self.resultSlider;
    
    layoutPresenter = [[LayoutPresenter alloc] initWithNavItem:self.navigationItem segmentedControl:self.segmentedControl helpButton:self.helpButton timerLabel:self.timerLabel navController:self.navigationController multFirstArg:self.firstArgument multSecondArg:self.secondArgument multSymbol:self.multSymbol helpAlphaView:self.helpAlphaView helpLabel:self.helpLabel tapToContinue:self.tapToContinueLabel afterCheckAlphaView:self.afterCheckedAlphaView afterCheckLabel:self.checkedLabel nextMultLabel:self.tapToNextMultLabel viewController:self resultSlider:self.resultSlider];
    
    helpManager = [[HelpManager alloc] initWithHelpLabel:self.helpLabel button:self.helpButton firstArgument:self.firstArgument secondArgument:self.secondArgument helpView:self.helpView andCheckButton:self.ckeckButton mainViewController:self segmentedControl:self.segmentedControl];
    
    [self setSplashLayoutDetails];
    
    [layoutPresenter configureInitialLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initInAppPurchaseConfig {    
    // In-app purchase products request
    _products = nil;
    [[GeniusLevelIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
        if (success) {
            _products = products;
        }
    }];
}

- (void)launchTutorialOnlyFirstTime {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULTS_GALLERY_FIRST_TIME_KEY]) {
        DeviceChooser *chooser = [[DeviceChooser alloc] init];
        HowToGalleryViewController *gallery = nil;
        if ([chooser isPad]) {
            gallery = [[HowToGalleryViewController alloc] initWithNibName:@"HowToGalleryViewController_iPad" bundle:nil];
        } else {
            gallery = [[HowToGalleryViewController alloc] initWithNibName:@"HowToGalleryViewController_iPhone" bundle:nil];
        }
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:gallery];
        gallery.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self.navigationController presentModalViewController:controller animated:YES];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_DEFAULTS_GALLERY_FIRST_TIME_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)setSplashLayoutDetails {
    [self.view addSubview:self.splashView];
        
    [layoutPresenter setTitleToNavItem];
}

// Learn mode pressed
- (IBAction)learnModePressed:(id)sender {
    // Hide menu view controller
    [self hideMenuView];
    
    [layoutPresenter stopTimer];
    
    // Analytics
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker sendView:@"Learn Mode Screen"];
    
    _mode = CALCULATOR_MODE_LEARN;
    [self initNavBar];
    
    [UIView animateWithDuration:0.5f
                     animations:^{self.splashView.alpha = 0.0;}
                     completion:^(BOOL finished){ [self.view sendSubviewToBack:self.splashView]; }];
    
    [self reset];
}

// Game mode pressed
- (IBAction)gameModePressed:(id)sender {
    // Hide menu view controller
    [self hideMenuView];
    
    if ([[GeniusLevelIAPHelper sharedInstance] productPurchased:NSLocalizedString(@"in_app_purchase_genius_level_identifier", @"In app purchase - Genius level product identifier")]) {
        
        // Analytics
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        [tracker sendView:@"Game Mode Screen"];
        
        _mode = CALCULATOR_MODE_GAME;
		self.level = LEVEL_MEDIUM;
        
        [self initNavBar];
        
        //    Help is always disabled in learn mode
        self.helpEnabled = NO;
        self.points = 0;
        
        [UIView animateWithDuration:0.5f
                         animations:^{self.splashView.alpha = 0.0;}
                         completion:^(BOOL finished){ [self.view sendSubviewToBack:self.splashView]; }];
        
        [self reset];
        
        [layoutPresenter initTimer];
        
    } else {
        // Present purchase viewcontroller
        InAppPurchaseViewController *inAppPurchaseViewController = nil;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            inAppPurchaseViewController = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPhone" bundle:nil];
        } else {
            inAppPurchaseViewController = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
        }
        
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:inAppPurchaseViewController];
        inAppPurchaseViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        inAppPurchaseViewController.products = _products;
        [self.navigationController presentModalViewController:controller animated:YES];
    }
}

- (void)hideMenuView {
    [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
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
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_line_down.png"] forSegmentAtIndex:LINE_SEGMENT];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_dot_up.png"] forSegmentAtIndex:DOT_SEGMENT];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_erase_up.png"] forSegmentAtIndex:ERASE_SEGMENT];
            
            self.red = LINE_COLOR_RED;
            self.green = LINE_COLOR_GREEN;
            self.blue = LINE_COLOR_BLUE;
            self.brushWidth = LINE_BRUSH_WIDE;
            break;
            
        case DOT_SEGMENT:
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_line_up.png"] forSegmentAtIndex:LINE_SEGMENT];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_dot_down.png"] forSegmentAtIndex:DOT_SEGMENT];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_erase_up.png"] forSegmentAtIndex:ERASE_SEGMENT];
            
            self.red = DOT_COLOR_RED;
            self.green = DOT_COLOR_GREEN;
            self.blue = DOT_COLOR_BLUE;
            self.brushWidth = DOT_BRUSH_WIDE_IPHONE;
            
            if (isIpad) {
                self.brushWidth = DOT_BRUSH_WIDE_IPAD;
            }
            break;
            
        case ERASE_SEGMENT:
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_line_up.png"] forSegmentAtIndex:LINE_SEGMENT];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_dot_up.png"] forSegmentAtIndex:DOT_SEGMENT];
            [self.segmentedControl setImage:[UIImage imageNamed:@"btn_erase_down.png"] forSegmentAtIndex:ERASE_SEGMENT];
            
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
    if (![self alphaViewVisible]) {
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

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_right_button_title", @"Nav. bar right button title") style:UIBarButtonItemStylePlain target:self action:@selector(clearAll)];
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
        leftVC.checkButton = self.ckeckButton;
        leftVC.products = _products;
        
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

- (BOOL)alphaViewVisible {
    BOOL toReturn = NO;
    
    // If helpView is visible set as hidden
    if (!self.helpView.hidden) {
        self.helpView.hidden = YES;
        toReturn = YES;
    }
    
    // If after checked label is visible set as hidden
    if (!self.afterCheckedView.hidden) {
        self.afterCheckedView.hidden = YES;
        toReturn = toReturn || YES;
        
        if ([slider getSliderValue] == ([self.firstArgument.text integerValue] * [self.secondArgument.text integerValue])) {
            [self reset];
        }
    }
    
    return toReturn;
}

- (void)clearAll {
    self.board.image = nil;
}

- (void)reset {
    [self clearAll];
    
    // Level
    [self ckeckLevel];
    
    // Color and brush wide
    [layoutPresenter resetActionLoaded:self.mode];
    
    self.red = LINE_COLOR_RED;
    self.green = LINE_COLOR_GREEN;
    self.blue = LINE_COLOR_BLUE;
    self.brushWidth = LINE_BRUSH_WIDE;
    
    [helpManager start];
    
    afterCheckedView.hidden = YES;
    
    // Segmented control reset
    self.segmentedControl.selectedSegmentIndex = LINE_SEGMENT;
    [self segmentedControlIndexChanged];
}

- (void)setLevel:(NSInteger)_level {
    level = _level;
    
    [self reset];
}

- (NSInteger)level {
    return level;
}

- (NSUInteger)mode {
    return _mode;
}

- (void)ckeckLevel {
    LevelHelper *levelHelper = [[LevelHelper alloc] initWithSelectedLevel:level];
    id<Level> selectedLevel = [levelHelper getLevelClass];
    NSInteger firstArg = [levelHelper getFirstArgForLevel];
    
    self.firstArgument.text = [NSString stringWithFormat:@"%d", firstArg];
    self.secondArgument.text = [NSString stringWithFormat:@"%d", [selectedLevel giveSecondArgument:firstArg]];

    switch (level) {
        case LEVEL_LOW:
            self.resultSlider.maximumValue = LOWER_LEVEL_SLIDER_MAX_NUMBER;
            self.resultSlider.minimumValue = LOWER_LEVEL_SLIDER_MIN_NUMBER;
            break;
            
        case LEVEL_MEDIUM:
            self.resultSlider.maximumValue = MEDIUM_LEVEL_SLIDER_MAX_NUMBER;
            self.resultSlider.minimumValue = MEDIUM_LEVEL_SLIDER_MIN_NUMBER;
            break;
            
        default:
            break;
    }
    
    [slider initSliderWithValue:self.resultSlider.minimumValue + arc4random() % ((int)self.resultSlider.maximumValue - (int)self.resultSlider.minimumValue)];
//    self.result.text = [NSString stringWithFormat:@"%.f", self.resultSlider.value];
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
    int sliderValue = [slider getSliderValue];
//    NSLog(@"slider %d, result AxB %d", sliderValue, resultIntValue);
    if (self.mode == CALCULATOR_MODE_LEARN) {
        if (sliderValue == resultIntValue) {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_ok_learn_mode", @"Result ckecked OK text in learn mode");
        }
        else {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_nok_learn_mode", @"Result ckecked NOK text in learn mode");
        }
    } else { // GAME MODE
        if (sliderValue == resultIntValue) {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_ok_game_mode", @"Result ckecked OK text in game mode");
            
            self.points += GAME_MODE_CORRECT_ANSWER_POINTS;
            self.timerLabel.text = [NSString stringWithFormat:@"%d", [self.timerLabel.text integerValue] + GAME_MODE_CORRECT_ANSWER_SECONDS];
        }
        else {
            self.checkedLabel.text = NSLocalizedString(@"result_checked_nok_lgame_mode", @"Result ckecked NOK text in game mode");
        }
    }
}

- (void)checkHelpEnabledAfterMenuHidden {
    if (self.helpEnabled) {
        [helpManager start];
    }
}

#pragma mark - in app purchase delegate
- (void)productPurchased:(NSNotification *)notification {
    NSString *productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            [self gameModePressed:nil];
        }
    }];
    
}

@end
