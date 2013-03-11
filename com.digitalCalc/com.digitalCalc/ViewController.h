//
//  ViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpManager.h"
#import "LeftMenuViewController.h"
#import "DeviceChooser.h"

#define digitalCalculatorNavBarColor [UIColor colorWithRed:0.66 green:0.33 blue:0.00 alpha:1.0]

#define LINE_SEGMENT 0
#define LINE_COLOR_RED 0.0/255.0
#define LINE_COLOR_GREEN 0.0/255.0
#define LINE_COLOR_BLUE 0.0/255.0
#define LINE_BRUSH_WIDE 5.0

#define DOT_SEGMENT 1
#define DOT_COLOR_RED 255.0/255.0
#define DOT_COLOR_GREEN 0.0/255.0
#define DOT_COLOR_BLUE 0.0/255.0
#define DOT_BRUSH_WIDE_IPAD 35.0
#define DOT_BRUSH_WIDE_IPHONE 25.0

#define ERASE_SEGMENT 2
#define ERASE_BRUSH_WIDE 35.0

#define COLOR_ALPHA_OPAQUE 1.0
#define COLOR_ALPHA_CLEAR 0.0

#define PICKER_VIEW_COMPONENTS 16380

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    CGPoint lastPoint;
    BOOL mouseSwiped;
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brushWidth;
    NSMutableArray *numbers;
    
    HelpManager *helpManager;
}

@property (nonatomic, strong) IBOutlet UIImageView *board;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, strong) IBOutlet UILabel *firstArgument;
@property (nonatomic, strong) IBOutlet UILabel *secondArgument;
@property (nonatomic, strong) IBOutlet UITextField *result;

@property (nonatomic, strong) IBOutlet UIPickerView *resultPicker;

@property (nonatomic, strong) IBOutlet UILabel *helpLabel;
@property (nonatomic, strong) IBOutlet UIButton *helpButton;


- (IBAction)segmentedControlIndexChanged;

@end
