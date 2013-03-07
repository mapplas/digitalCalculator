//
//  ArgumentLabelAnimator.m
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ArgumentLabelAnimator.h"

@implementation ArgumentLabelAnimator

- (id)initWithViewController:(ViewController *)main_controller {
    self = [super init];
    if (self) {
        mainViewController = main_controller;
    }
    return self;
}

- (void)animateLabel:(UILabel *)to_animate withResponse:(BOOL)response {
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCAAnimationDiscrete];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setFillMode:kCAFillModeBoth];
    [animation setDuration:1];
    [animation setRepeatCount:4];
    
    if (response) {
        [animation setDelegate:mainViewController];
    }

    [to_animate.layer addAnimation:animation forKey:@"UILabelAnimationKey"];
}

@end
