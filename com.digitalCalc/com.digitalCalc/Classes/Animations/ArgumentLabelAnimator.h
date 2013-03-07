//
//  ArgumentLabelAnimator.h
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class ViewController;

@interface ArgumentLabelAnimator : NSObject {
    ViewController *mainViewController;
}

- (id)initWithViewController:(ViewController *)main_controller;
- (void)animateLabel:(UILabel *)to_animate withResponse:(BOOL)response;

@end
