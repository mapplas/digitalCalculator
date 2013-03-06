//
//  ViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    CGPoint lastPoint;
    BOOL mouseSwiped;
}

@property (nonatomic, strong) IBOutlet UIImageView *board;
@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentedControlIndexChanged;

@end
