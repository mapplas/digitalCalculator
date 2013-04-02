//
//  AppDelegate.m
//  com.digitalCalc
//
//  Created by Belén  on 06/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // The idea is that Apple will keep track of any purchase transactions that haven’t yet been fully processed by your app, and will notify the transaction observer about them. But for this to work well, you should register your class as a transaction observer as early as possible in your app initialization.
    
    // Now, as soon as your app launches it will create the singleton RageIAPHelper. This means the initWithProducts: method you just modified will be called, which registers itself as the transaction observer. So you will be notified about any transactions that were never quite finished
    [GeniusLevelIAPHelper sharedInstance];
    
    //first-time ever defaults check and set
    if([[NSUserDefaults standardUserDefaults] boolForKey:USER_DEFAULTS_GALLERY_FIRST_TIME_KEY] != YES) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_DEFAULTS_GALLERY_FIRST_TIME_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //Google Analytics
    // automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    // set debug to YES for extra debugging information.
    [GAI sharedInstance].debug = YES;
    // Create tracker instance.
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-39680645-2"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *viewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
//    [SCAppUtils customizeNavigationController:frontViewController];
    
    NSDictionary *options = @{
                              PKRevealControllerRecognizesPanningOnFrontViewKey : [NSNumber numberWithBool:NO]
                              };    
    
    UIViewController *leftViewController = [[LeftMenuViewController alloc] initWithMainViewController:frontViewController];
    self.revealController = [PKRevealController revealControllerWithFrontViewController:frontViewController
                                                                     leftViewController:leftViewController
                                                                                options:options];
    
    [self configureAppearance];
    
    self.window.rootViewController = self.revealController;
    
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSDate *endDate = [NSDate date];
    NSTimeInterval interval = [endDate timeIntervalSinceDate:startDate];
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker sendTimingWithCategory:@"resources"
                          withValue:interval
                           withName:@"Load time"
                          withLabel:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    startDate = [NSDate date];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)configureAppearance {
    DeviceChooser *deviceChooser = [[DeviceChooser alloc] init];
    if ([deviceChooser isPad]) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bkg_nav_bar_iPad.png"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bkg_nav_bar.png"] forBarMetrics:UIBarMetricsDefault];
    }
}

@end
