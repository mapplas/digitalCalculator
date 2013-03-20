//
//  IAPHelper.m
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "IAPHelper.h"
#import <StoreKit/StoreKit.h>

@interface IAPHelper () <SKProductsRequestDelegate>
@end

@implementation IAPHelper {
    // You create an instance variable to store the SKProductsRequest you will issue to retrieve a list of products, while it is active. You keep a reference to the request so
    // a) you can know if you have one active already, and
    // b) you’ll be guaranteed that it’s in memory while it’s active.
    SKProductsRequest * _productsRequest;
    
    // You also keep track of the completion handler for the outstanding products request, the list of product identifiers passed in, and the list of product identifers that have been previously purchased.
    RequestProductsCompletionHandler _completionHandler;
    NSSet * _productIdentifiers;
    NSMutableSet * _purchasedProductIdentifiers;
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
        // Check for previously purchased products
        _purchasedProductIdentifiers = [NSMutableSet set];
        for (NSString * productIdentifier in _productIdentifiers) {
            BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
            if (productPurchased) {
                [_purchasedProductIdentifiers addObject:productIdentifier];
                NSLog(@"Previously purchased: %@", productIdentifier);
            } else {
                NSLog(@"Not purchased: %@", productIdentifier);
            }
        }
        
    }
    return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    // Squirrels a copy of the completion handler block inside the instance variable so it can notify the caller when the product request asynchronously completes.
    _completionHandler = [completionHandler copy];
    
    // It then creates a new instance of SKProductsRequest, which is the Apple-written class that contains the code to pull the info from iTunes Connect. It’s very easy to use – you just give it a delegate (that conforms to the SKProductsRequestDelegate protocol) and then call start to get things running.
    // We set the IAPHelper class itself as the delegate, which means that it will receive a callback when the products list completes (productsRequest:didReceiveResponse) or fails (request:didFailWithErorr).
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
    for (SKProduct * skProduct in skProducts) {
        NSLog(@"Found product: %@ %@ %0.2f",
              skProduct.productIdentifier,
              skProduct.localizedTitle,
              skProduct.price.floatValue);
    }
    
    _completionHandler(YES, skProducts);
    _completionHandler = nil;
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Failed to load list of products.");
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
}

@end
