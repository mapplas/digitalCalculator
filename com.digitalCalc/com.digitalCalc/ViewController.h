//
//  ViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LINE_SEGMENT 0
#define LINE_COLOR_RED 0.0/255.0
#define LINE_COLOR_GREEN 0.0/255.0
#define LINE_COLOR_BLUE 0.0/255.0
#define LINE_BRUSH_WIDE 5.0

#define DOT_SEGMENT 1
#define DOT_COLOR_RED 255.0/255.0
#define DOT_COLOR_GREEN 0.0/255.0
#define DOT_COLOR_BLUE 0.0/255.0
#define DOT_BRUSH_WIDE 35.0

@interface ViewController : UIViewController {
    CGPoint lastPoint;
    BOOL mouseSwiped;
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brushWidth;
}

@property (nonatomic, strong) IBOutlet UIImageView *board;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentedControlIndexChanged;

@end
