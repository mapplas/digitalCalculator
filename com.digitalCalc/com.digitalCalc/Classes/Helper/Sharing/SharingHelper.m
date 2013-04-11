//
//  SharingHelper.m
//  Mapplas
//
//  Created by Belén  on 06/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SharingHelper.h"

@implementation SharingHelper

- (id)initWithNavigationController:(UINavigationController *)nav_controller {
    self = [super init];
    if (self) {
        navController = nav_controller;
    }
    return self;
}

- (NSString *)getShareMessage {
    return [NSString stringWithFormat:@"%@ Genius Multiplication %@", NSLocalizedString(@"share_message_part_1", @"share_message_part_1"), NSLocalizedString(@"share_message_part_2", @"Share message part 2")];
}

- (void)shareWithTwitter {
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
        [tweetSheet setInitialText:[self getShareMessage]];
        [navController presentModalViewController:tweetSheet animated:YES];
    }
    else {
        // Alert View
        UIAlertView *errorAler = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_twitter_error", @"Twitter sharing not avaliable") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
        [errorAler show];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_sms_error", @"SMS sharing error") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_sms_ok_message", @"SMS sharing ok message") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    
	switch (result) {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
            [errorAlert show];
			break;
		case MessageComposeResultSent:
            [okAlert show];
			break;
		default:
			break;
	}
    
	[navController dismissModalViewControllerAnimated:YES];
}

- (void)shareViaInAppSMS {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]) {
        controller.body = [self getShareMessage];
        controller.messageComposeDelegate =  self;
        [navController presentModalViewController:controller animated:YES];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_error", @"Email sharing error") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    UIAlertView *okAlert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"share_email_ok_message", @"Email sharing ok message") delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"ok_message", @"OK message"), nil];
    
	switch (result) {
		case MessageComposeResultCancelled:
			break;
		case MessageComposeResultFailed:
            [errorAlert show];
			break;
		case MessageComposeResultSent:
            [okAlert show];
			break;
		default:
			break;
	}
    
	[navController dismissModalViewControllerAnimated:YES];
}

- (void)shareViaEmail {
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    [mailViewController setSubject:NSLocalizedString(@"share_email_subject", @"Email sharing mail subject")];
    [mailViewController setMessageBody:[self getShareMessage] isHTML:NO];
    
    [navController presentModalViewController:mailViewController animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self shareWithTwitter];
    }
    else if(buttonIndex == 1) {
		[self shareViaInAppSMS];
	}
    else if(buttonIndex == 2) {
        [self shareViaEmail];
    }
}

@end
