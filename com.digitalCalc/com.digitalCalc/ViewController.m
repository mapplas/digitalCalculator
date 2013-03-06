//
//  ViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (void)initNavBar;
- (void)pushMenu;
- (void)initLayout;
- (void)clearAll;
@end

@implementation ViewController

@synthesize board;
@synthesize segmentedControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    [self initLayout];
}

- (IBAction)segmentedControlIndexChanged {
    // If selected segment is erase...
    UIColor *backcroundColor = self.board.backgroundColor;
    CGColorRef color = [backcroundColor CGColor];
    const CGFloat *components = CGColorGetComponents(color);

    switch (self.segmentedControl.selectedSegmentIndex) {
        case LINE_SEGMENT:
            red = LINE_COLOR_RED;
            green = LINE_COLOR_GREEN;
            blue = LINE_COLOR_BLUE;
            brushWidth = LINE_BRUSH_WIDE;
            break;
            
        case DOT_SEGMENT:
            red = DOT_COLOR_RED;
            green = DOT_COLOR_GREEN;
            blue = DOT_COLOR_BLUE;
            brushWidth = DOT_BRUSH_WIDE;
            break;
            
        case ERASE_SEGMENT:
            red = components[0];
            green = components[1];
            blue = components[2];
            brushWidth = ERASE_BRUSH_WIDE;
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
        
        UIGraphicsBeginImageContext(self.board.frame.size);
        [self.board.image drawInRect:CGRectMake(0, 0, self.board.frame.size.width, self.board.frame.size.height)];
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushWidth);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
        
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.board.image = UIGraphicsGetImageFromCurrentImageContext();
        [self.board setAlpha:1.0];
        UIGraphicsEndImageContext();
    }
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.board.frame.size);
        [self.board.image drawInRect:CGRectMake(0, 0, self.board.frame.size.width, self.board.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brushWidth);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.board.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

# pragma mark - Private methods
- (void)initNavBar {
    self.title = NSLocalizedString(@"nav_bar_title", @"Nav bar title");
//    [self.navigationController.navigationBar setTitleTextAttributes:];
    
    UIImage *menuImage = [UIImage imageNamed:@"ic_menu_menu.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menuImage style:UIBarButtonItemStyleBordered target:self action:@selector(pushMenu)];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_right_button_title", @"Nav. bar right button title") style:UIBarButtonItemStyleBordered target:self action:@selector(erase)];
}

- (void)pushMenu {
    // TODO
}

- (IBAction)clearAll {
    self.board.image = nil;
}

- (void)initLayout {
    // Segmented control button names
    NSString *segmentedControlLineText = NSLocalizedString(@"segm_control_line", @"Segmented control line text");
    [self.segmentedControl setTitle:segmentedControlLineText forSegmentAtIndex:0];
    
    NSString *segmentedControlDotText = NSLocalizedString(@"segm_control_dot", @"Segmented control dots text");
    [self.segmentedControl setTitle:segmentedControlDotText forSegmentAtIndex:1];
    
    NSString *segmentedControlEraseText = NSLocalizedString(@"nav_bar_right_button_title", @"Nav. bar right button title");
    [self.segmentedControl setTitle:segmentedControlEraseText forSegmentAtIndex:2];
    
    // Color and brush wide
    red = LINE_COLOR_RED;
    green = LINE_COLOR_GREEN;
    blue = LINE_COLOR_BLUE;
    brushWidth = LINE_BRUSH_WIDE;
}

@end
