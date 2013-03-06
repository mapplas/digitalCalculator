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
    [navBar setTintColor:digitalCalculatorNavBarColor];
    
//    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        [navBar setBackgroundImage:[UIImage imageNamed:@"bgd_menu.png"] forBarMetrics:UIBarMetricsDefault];
//    }
//    else {
//        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:mapplasNavBarImageTag];
//        if (imageView == nil) {
//            imageView = [[UIImageView alloc] initWithImage:
//                         [UIImage imageNamed:@"bgd_menu.png"]];
//            [imageView setTag:mapplasNavBarImageTag];
//            [navBar insertSubview:imageView atIndex:0];
//        }
//    }
}

@end
