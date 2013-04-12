//
//  InAppPurchaseViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutPresenter.h"
#import "PaymentTransactionProtocol.h"
#import "RestoreTransactionProtocol.h"
#import "GAITransaction.h"
#import "GAI.h"
#import "MBProgressHUD.h"

@interface InAppPurchaseViewController : UIViewController <PaymentTransactionProtocol, RestoreTransactionProtocol, UIAlertViewDelegate> {
    NSArray *_products;
    
    UIAlertView *transactionOkAlert;
    UIAlertView *transactionFailedAlert;
    
    MBProgressHUD *buyProgressHud;
    MBProgressHUD *restoreProgressHud;
}

@property (nonatomic, strong) IBOutlet UIButton *buyButton;
@property (nonatomic, strong) IBOutlet UILabel *buyLabel;

@property (nonatomic, strong) NSArray *products;

- (IBAction)buyButtonPressed:(id)sender;
- (IBAction)restoreButtonPressed:(id)sender;

@end
