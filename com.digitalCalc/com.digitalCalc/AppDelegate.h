//
//  AppDelegate.h
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKRevealController.h"
#import "LeftMenuViewController.h"

#import "GeniusLevelIAPHelper.h"
#import "deviceChooser.h"
#import "GAI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *_navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (nonatomic, strong, readwrite) PKRevealController *revealController;

@end
