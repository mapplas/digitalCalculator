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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *viewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
    } else {
        viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
    }
    
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    
//    // Set navigationController
//    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
//    [SCAppUtils customizeNavigationController:self.navigationController];
//    self.window.rootViewController = self.navigationController;
//    
//    [self.window makeKeyAndVisible];
//    return YES;
    
    UIViewController *leftViewController = [[LeftMenuViewController alloc] init];
    self.revealController = [PKRevealController revealControllerWithFrontViewController:frontViewController
                                                                     leftViewController:leftViewController
                                                                                options:nil];
//    
//    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.revealController];
//    [SCAppUtils customizeNavigationController:self.navigationController];
    self.window.rootViewController = self.revealController;
    
    [self.window makeKeyAndVisible];
    return YES;
    
    
    
    
    
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    // Step 1: Create your controllers.
//    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:[[FrontViewController alloc] init]];
//    UIViewController *rightViewController = [[RightDemoViewController alloc] init];
//    UIViewController *leftViewController = [[LeftDemoViewController alloc] init];
//    
//    // Step 2: Configure an options dictionary for the PKRevealController if necessary - in most cases the default behaviour should suffice. See PKRevealController.h for more option keys.
//    /*
//     NSDictionary *options = @{
//     PKRevealControllerAllowsOverdrawKey : [NSNumber numberWithBool:YES],
//     PKRevealControllerDisablesFrontViewInteractionKey : [NSNumber numberWithBool:YES]
//     };
//     */
//    
//    // Step 3: Instantiate your PKRevealController.
//    self.revealController = [PKRevealController revealControllerWithFrontViewController:frontViewController
//                                                                     leftViewController:leftViewController
//                                                                    rightViewController:rightViewController
//                                                                                options:nil];
//    
//    // Step 4: Set it as your root view controller.
//    self.window.rootViewController = self.revealController;
//    
//    [self.window makeKeyAndVisible];
//    return YES;
//    
//    // Step 5: Take a look at the Left/RightDemoViewController files. They're self-sufficient as to the configuration of their reveal widths for instance.
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
