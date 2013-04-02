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
#import "GAITransaction.h"
#import "GAI.h"

@interface InAppPurchaseViewController : UIViewController <PaymentTransactionProtocol, UIAlertViewDelegate> {
    NSArray *_products;
    
    UIAlertView *transactionOkAlert;
    UIAlertView *transactionFailedAlert;
}

@property (nonatomic, strong) IBOutlet UIButton *buyButton;
@property (nonatomic, strong) IBOutlet UILabel *buyLabel;

@property (nonatomic, strong) NSArray *products;

- (IBAction)buyButtonPressed:(id)sender;

@end
