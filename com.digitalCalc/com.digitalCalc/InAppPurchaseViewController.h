//
//  InAppPurchaseViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InAppPurchaseViewController : UIViewController {
    NSArray *_products;
}

@property (nonatomic, strong) IBOutlet UIButton *buyButton;

@property (nonatomic, strong) NSArray *products;

- (IBAction)buyButtonPressed:(id)sender;

@end
