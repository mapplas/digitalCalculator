//
//  InAppPurchaseViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "InAppPurchaseViewController.h"

#import <StoreKit/StoreKit.h>
#import "GeniusLevelIAPHelper.h"

@interface InAppPurchaseViewController ()

@end

@implementation InAppPurchaseViewController

@synthesize buyButton;
@synthesize products = _products;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Play again nav button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"in_app_purchase_nav_left_button_title", @"In app purchase - Nav controller left button title") style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_up.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_hover.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

- (void)buyButtonPressed:(id)sender {
    NSLog(@"Buying... %@", NSLocalizedString(@"in_app_purchase_genius_level_identifier", @"In app purchase - Genius level product identifier"));
    SKProduct *product = [self.products objectAtIndex:0];
    [[GeniusLevelIAPHelper sharedInstance] buyProduct:product];
}

- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
