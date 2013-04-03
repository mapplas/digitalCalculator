//
//  SharingHelper.h
//  Mapplas
//
//  Created by Belén  on 06/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Twitter/Twitter.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface SharingHelper : NSObject <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, UIActionSheetDelegate> {
    UINavigationController *navController;
}

- (id)initWithNavigationController:(UINavigationController *)nav_controller;
- (NSString *)getShareMessage;

@end
