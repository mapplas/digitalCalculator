//
//  RestoreTransactionProtocol.h
//  com.digitalCalc
//
//  Created by Belén  on 03/04/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <StoreKit/StoreKit.h>

@protocol RestoreTransactionProtocol <NSObject>

- (void)restoreCorrectlyEnded;
- (void)restoreFailed;

@end
