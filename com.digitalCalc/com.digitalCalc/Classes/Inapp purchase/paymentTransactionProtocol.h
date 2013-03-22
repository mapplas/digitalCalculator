//
//  PaymentTransactionProtocol.h
//  com.digitalCalc
//
//  Created by Belén  on 22/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@protocol PaymentTransactionProtocol <NSObject>

- (void)transactionCorrectlyEnded;
- (void)transactionFailed;

@end
