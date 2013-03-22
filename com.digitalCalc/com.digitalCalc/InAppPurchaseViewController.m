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
@synthesize buyLabel;
@synthesize products = _products;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Play again nav button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"in_app_purchase_nav_left_button_title", @"In app purchase - Nav controller left button title") style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_up.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_hover.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [self.buyLabel setFont:[UIFont fontWithName:@"Blokletters Potlood" size:self.buyLabel.font.pointSize]];
    self.buyLabel.text = NSLocalizedString(@"in_app_purchase_buy_text_label_title", @"In app purchase - Buy text");
    [LayoutPresenter resizeFontForLabel:self.buyLabel maxSize:40 minSize:25];
}

- (void)buyButtonPressed:(id)sender {
    NSLog(@"Buying... %@", NSLocalizedString(@"in_app_purchase_genius_level_identifier", @"In app purchase - Genius level product identifier"));
    SKProduct *product = [self.products objectAtIndex:0];
    [[GeniusLevelIAPHelper sharedInstance] buyProduct:product andSetDelegate:self];
}

- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - PaymentTransactionProtocol methods
- (void)transactionCorrectlyEnded {
    transactionOkAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"in_app_purchase_ok_alert_title", @"In app purchase - Purchase OK alert title") message:NSLocalizedString(@"in_app_purchase_ok_alert_message", @"In app purchase - Purchase OK alert message") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"in_app_purchase_ok_nok_button", @"In app purchase OK and NOK alert button title"), nil];
    [transactionOkAlert show];
    [self pop];
}

- (void)transactionFailed {
    transactionFailedAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"in_app_purchase_nok_alert_title", @"In app purchase - Purchase NOK alert title") message:NSLocalizedString(@"in_app_purchase_nok_alert_message", @"In app purchase - Purchase NOK alert message") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"in_app_purchase_ok_nok_button", @"In app purchase OK and NOK alert button title"), nil];
    [transactionFailedAlert show];
    [self pop];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

@end
