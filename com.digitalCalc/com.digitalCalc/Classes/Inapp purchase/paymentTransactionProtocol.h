//
//  PaymentTransactionProtocol.h
//  com.digitalCalc
//
//  Created by Belén  on 22/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <StoreKit/StoreKit.h>

@protocol PaymentTransactionProtocol <NSObject>

- (void)transactionCorrectlyEnded:(SKPaymentTransaction *)_transaction;
- (void)transactionFailed;

@end
