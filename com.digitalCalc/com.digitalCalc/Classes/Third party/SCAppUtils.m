//
//  SCAppUtils.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SCAppUtils.h"

@implementation SCAppUtils

+ (void)customizeNavigationController:(UINavigationController *)navController {
    UINavigationBar *navBar = [navController navigationBar];
//    [navBar setTintColor:mapplasNavBarColor];
    
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [navBar setBackgroundImage:[UIImage imageNamed:@"bkg_nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else {
        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:calculatorNavBarImageTag];
        if (imageView == nil) {
            imageView = [[UIImageView alloc] initWithImage:
                         [UIImage imageNamed:@"bkg_nav_bar.png"]];
            [imageView setTag:calculatorNavBarImageTag];
            [navBar insertSubview:imageView atIndex:0];
        }
    }
}

@end
