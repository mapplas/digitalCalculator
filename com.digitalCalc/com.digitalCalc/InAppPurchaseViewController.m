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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)buyButtonPressed:(id)sender {
    NSLog(@"Buying... %@", NSLocalizedString(@"in_app_purchase_genius_level_identifier", @"In app purchase - Genius level product identifier"));
    SKProduct *product = [self.products objectAtIndex:0];
    [[GeniusLevelIAPHelper sharedInstance] buyProduct:product andSetDelegate:self];
    [buyButton setEnabled:NO];
}

- (IBAction)restoreButtonPressed:(id)sender {
    [[GeniusLevelIAPHelper sharedInstance] restoreCompletedTransactionsWithDelegate:self];
}

- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - PaymentTransactionProtocol methods
- (void)transactionCorrectlyEnded:(SKPaymentTransaction *)_transaction {
    // Analytics
    GAITransaction *transaction =
    [GAITransaction transactionWithId:_transaction.transactionIdentifier            // (NSString) Transaction ID, should be unique.
                      withAffiliation:@"IAP - AppStore"];       // (NSString) Affiliation
     transaction.taxMicros = (int64_t)(0.17 * 1000000);           // (int64_t) Total tax (in micros)
     transaction.shippingMicros = (int64_t)(0);                   // (int64_t) Total shipping (in micros)
     transaction.revenueMicros = (int64_t)(2.16 * 1000000);       // (int64_t) Total revenue (in micros)
    
    [transaction addItemWithCode:@"1001"
                            name:@"Genius Level"
                        category:@"Game expansions"
                     priceMicros:(int64_t)(1.99 * 1000000)
                        quantity:1];                         // (NSString) Product SKU
    [[GAI sharedInstance].defaultTracker sendTransaction:transaction]; // Send the transaction.
    
    
    transactionOkAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"in_app_purchase_ok_alert_title", @"In app purchase - Purchase OK alert title") message:NSLocalizedString(@"in_app_purchase_ok_alert_message", @"In app purchase - Purchase OK alert message") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"in_app_purchase_ok_nok_button", @"In app purchase OK and NOK alert button title"), nil];
    [transactionOkAlert show];
    
    [buyButton setEnabled:YES];
    
    [self pop];
}

- (void)transactionFailed {
    transactionFailedAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"in_app_purchase_nok_alert_title", @"In app purchase - Purchase NOK alert title") message:NSLocalizedString(@"in_app_purchase_nok_alert_message", @"In app purchase - Purchase NOK alert message") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"in_app_purchase_ok_nok_button", @"In app purchase OK and NOK alert button title"), nil];
    [transactionFailedAlert show];
    
    [buyButton setEnabled:YES];
    
    [self pop];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

#pragma mark - RestoreTransactionProcotol methods
- (void)restoreCorrectlyEnded {
    transactionOkAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"restore_in_app_purchase_ok_alert_title", @"Restore in app purchase - Restore OK alert title") message:NSLocalizedString(@"restore_in_app_purchase_ok_alert_message", @"Restore in app purchase - Restore OK alert message") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"in_app_purchase_ok_nok_button", @"In app purchase OK and NOK alert button title"), nil];
    [transactionOkAlert show];
    [self pop];
}

- (void)restoreFailed {
    transactionFailedAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"restore_in_app_purchase_nok_alert_title", @"Restore in app purchase - Restore NOK alert title") message:NSLocalizedString(@"in_app_purchase_nok_alert_message", @"In app purchase - Purchase NOK alert message") delegate:self cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"in_app_purchase_ok_nok_button", @"In app purchase OK and NOK alert button title"), nil];
    [transactionFailedAlert show];
    [self pop];
}

@end
