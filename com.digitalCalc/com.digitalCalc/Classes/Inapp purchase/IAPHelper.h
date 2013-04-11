//
//  IAPHelper.h
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "PaymentTransactionProtocol.h"
#import "RestoreTransactionProtocol.h"
#import "MBProgressHUD.h"

UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject <SKPaymentTransactionObserver> {
    id<PaymentTransactionProtocol> paymentTransactionProtocol;
    id<RestoreTransactionProtocol> restoreTransactionProtocol;
    
    NSArray *products;
    MBProgressHUD *hud;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

- (void)buyProduct:(SKProduct *)product andSetDelegate:(id<PaymentTransactionProtocol>)_delegate progressHud:(MBProgressHUD *)progress_hud;
- (BOOL)productPurchased:(NSString *)productIdentifier;

- (void)restoreCompletedTransactionsWithDelegate:(id<RestoreTransactionProtocol>)_restoreDelegate progressHud:(MBProgressHUD *)progress_hud;

@end
