//
//  LeftMenuViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ViewController.h"
#import "RankingViewController.h"

@interface LeftMenuViewController ()
@end

@implementation LeftMenuViewController

@synthesize helpButton, helpLabel, helpView, checkButton;
@synthesize products;

- (id)initWithMainViewController:(UINavigationController *)main_view_controller {
    self = [super init];
    if (self) {
        mainViewController = [main_view_controller.viewControllers objectAtIndex:0];
        changedHelpSwitchValue = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg_menu_cell_up.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
    NSInteger gameMode = [mainViewController mode];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:LEVEL_GAME inSection:0]; // Game mode
    
    if (gameMode == CALCULATOR_MODE_LEARN) {
        indexPath = [NSIndexPath indexPathForRow:[mainViewController level] inSection:0];
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDataSource and Delate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MENU_TABLE_SECTIONS_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *helpCellId = @"HelpOnOffText";
    NSString *levelCellId = @"LevelMenuText";
    
    if (indexPath.section == 0) {
        plainTextMenuCell = [tableView dequeueReusableCellWithIdentifier:levelCellId];
        if (plainTextMenuCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LevelMenuCell" owner:self options:nil];
            plainTextMenuCell = [nib objectAtIndex:0];
        }
        
        switch (indexPath.row) {
            case 0:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_low", @"Menu section levels low level");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_beginner.png"];
                break;
                
            case 1:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_medium", @"Menu section levels medium level");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_genius.png"];
                break;
                
            case 2:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_high", @"Menu section levels high level");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_prodigy.png"];
                break;
                
            case 3:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_settings_game_mode_change", @"Menu section settings game mode change");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_game.png"];
                break;
                
        }
        return plainTextMenuCell;
        
    } else {
        
        if (indexPath.row == 0) {
            helpCell = [tableView dequeueReusableCellWithIdentifier:helpCellId];
            if (helpCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchedMenuCell" owner:self options:nil];
                helpCell = [nib objectAtIndex:0];
            }
        } else {
            plainTextMenuCell = [tableView dequeueReusableCellWithIdentifier:levelCellId];
            if (plainTextMenuCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LevelMenuCell" owner:self options:nil];
                plainTextMenuCell = [nib objectAtIndex:0];
            }
        }
        
        switch (indexPath.row) {
            case 0:
                [helpCell.cellSwitch setOn:mainViewController.helpEnabled];
            
                helpCell.textLabel.text = NSLocalizedString(@"menu_section_settings_help_enabled", @"Menu section settings help enabled");
                helpCell.image.image = [UIImage imageNamed:@"ic_menu_help.png"];
                break;

            case 1:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_settings_how_to", @"Menu section settings tutorial");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_tutorial.png"];
                break;
                
            case 2:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_settings_ranking", @"Menu section settings ranking");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_clasification.png"];
                break;
            
            case 3:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_settings_share", @"Menu section settings share");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_share.png"];
                break;
                
            case 4:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_settings_rate", @"Menu section settings rate");
                plainTextMenuCell.image.image = [UIImage imageNamed:@"ic_menu_rating.png"];
                break;
        }
        
        if (indexPath.row == 0) {
            return helpCell;
        } else {
            return plainTextMenuCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [mainViewController learnModePressed:nil];
                [mainViewController setLevel:LEVEL_LOW];
                
                break;
                
            case 1:
                if ([[GeniusLevelIAPHelper sharedInstance] productPurchased:NSLocalizedString(@"in_app_purchase_genius_level_identifier", @"In app purchase - Genius level product identifier")]) {
                    [mainViewController learnModePressed:nil];
                    [mainViewController setLevel:LEVEL_MEDIUM];
                } else {
                    [mainViewController hideMenuView];
                    
                    InAppPurchaseViewController *inAppPurchaseViewController = nil;
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                        inAppPurchaseViewController = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPhone" bundle:nil];
                    } else {
                        inAppPurchaseViewController = [[InAppPurchaseViewController alloc] initWithNibName:@"InAppPurchaseViewController_iPad" bundle:nil];
                    }
                    
                    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:inAppPurchaseViewController];
                    inAppPurchaseViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    inAppPurchaseViewController.products = products;
                    [mainViewController presentModalViewController:controller animated:YES];
                }

                break;
                
            case 2:
                [self deselectRowandSelectCorrectOne:indexPath];
                break;
                
            case 3:
                [mainViewController gameModePressed:nil];
                
                break;
                
            default:
                break;
        }
    }
    else {
        switch (indexPath.row) {
            case 0:
//              If calculator mode is game mode, do nothing
                if (!mainViewController.mode == CALCULATOR_MODE_GAME) {
                    [helpCell.cellSwitch setOn:!helpCell.cellSwitch.on animated:YES];
                    [self checkHelpSwitch:helpCell.cellSwitch];
                }
                
                [self deselectRowandSelectCorrectOne:indexPath];

                break;
                
            case 1:
                [self pushHowToController];
                [self deselectRowandSelectCorrectOne:indexPath];

                break;
                
            case 2:
                [self pushRankingController];
                [self deselectRowandSelectCorrectOne:indexPath];
                
                break;
                
            case 3:
                [self pushShareController];
                [self deselectRowandSelectCorrectOne:indexPath];
                
                break;
                
            case 4:
                [self pushAppRate];
                [self deselectRowandSelectCorrectOne:indexPath];
                
            default:
                break;
        }
    }
}

- (void)deselectRowandSelectCorrectOne:(NSIndexPath *)index_path {
    [self.tableView deselectRowAtIndexPath:index_path animated:YES];
    
    NSInteger gameMode = [mainViewController mode];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:LEVEL_GAME inSection:0]; // Game mode
    
    if (gameMode == CALCULATOR_MODE_LEARN) {
        indexPath = [NSIndexPath indexPathForRow:[mainViewController level] inSection:0];
    }
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MENU_TABLE_ROW_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return MENU_TABLE_LEVELS_SECTION_COUNT;
            break;
            
        case 1:
            return MENU_TABLE_CONFIG_SECTION_COUNT;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSInteger height = MENU_TABLE_HEADER_HEIGHT;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, height)];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg_menu_header.png"]]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    NSInteger headerLabelHeight = 20;
    headerLabel.frame = CGRectMake(10, (height / 2) - (headerLabelHeight / 2), 200, headerLabelHeight);
    headerLabel.textColor = [UIColor colorWithRed:236/255.f green:236/255.f blue:236/255.f alpha:1.f];
    
    
    switch (section) {
        case 0:
            headerLabel.text = NSLocalizedString(@"menu_section_levels_title", @"Menu section levels title");
            break;
                
        case 1:
            headerLabel.text = NSLocalizedString(@"menu_section_configuration_title", @"Menu section configuration title");
            break;
    }
    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return MENU_TABLE_HEADER_HEIGHT;
}

- (void)pushRankingController {
    DeviceChooser *chooser = [[DeviceChooser alloc] init];
    RankingViewController *rankingViewController = nil;
    if (![chooser isPad]) {
        rankingViewController = [[RankingViewController alloc] initWithNibName:@"RankingViewController_iPhone" bundle:nil];
    } else {
        rankingViewController = [[RankingViewController alloc] initWithNibName:@"RankingViewController_iPad" bundle:nil];
    }
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:rankingViewController];
    rankingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    rankingViewController.layoutPresenter = nil;
    [mainViewController presentModalViewController:controller animated:YES];
}

- (void)pushHowToController {
    DeviceChooser *chooser = [[DeviceChooser alloc] init];
    HowToGalleryViewController *gallery = nil;
    if ([chooser isPad]) {
        gallery = [[HowToGalleryViewController alloc] initWithNibName:@"HowToGalleryViewController_iPad" bundle:nil];
    } else {
        gallery = [[HowToGalleryViewController alloc] initWithNibName:@"HowToGalleryViewController_iPhone" bundle:nil];
    }
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:gallery];
    gallery.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [mainViewController presentModalViewController:controller animated:YES];
}

- (void)pushShareController {
    shareHelper = [[SharingHelper alloc] initWithNavigationController:mainViewController.navigationController];
    
    // If device has ios6 and up
	if ([UIActivityViewController class]) {
        NSString *messageToShare = [shareHelper getShareMessage];
        NSURL *urlToShare = [NSURL URLWithString:NSLocalizedString(@"share_message_url", @"Share message url")];
		NSMutableArray *itemsToShare = [[NSMutableArray alloc] initWithObjects:messageToShare, urlToShare, nil];
        
		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
		activityViewController.excludedActivityTypes = @[UIActivityTypePostToWeibo, UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
        
		[self presentViewController:activityViewController animated:YES completion:nil];
	}
	else {
        // iOS 5
		NSString *cancelButton = NSLocalizedString(@"ios5_sharing_action_sheet_cancel_button", @"iOS5 sharing action sheet cancel button - twitter sharing");
		NSString *twitterButton = NSLocalizedString(@"ios5_sharing_action_sheet_twitter_button", @"iOS5 sharing action sheet twitter button - twitter sharing");
        NSString *smsButton = NSLocalizedString(@"ios5_sharing_action_sheet_sms_button", @"iOS5 sharing action sheet sms button - sms sharing");
		NSString *emailButton = NSLocalizedString(@"ios5_sharing_action_sheet_email_button", @"iOS5 sharing action sheet email button - email sharing");
        
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:shareHelper cancelButtonTitle:cancelButton destructiveButtonTitle:nil otherButtonTitles:twitterButton, smsButton, emailButton, nil];
        
        [actionSheet dismissWithClickedButtonIndex:3 animated:YES];
		[actionSheet showInView:[UIApplication sharedApplication].keyWindow.rootViewController.view];
	}
}

- (void)pushAppRate {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"review_alert_title", @"Review alert title")
                                message:NSLocalizedString(@"review_alert_message", @"Review alert message")
                                delegate:self
                          cancelButtonTitle:NSLocalizedString(@"review_alert_ok_button", @"Review alert ok button title")
                          otherButtonTitles:NSLocalizedString(@"review_alert_cancel_button", @"Review alert cancel button title"), nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSString *url = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=624548749";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

#pragma mark - Help actions
- (void)checkHelpSwitch:(UISwitch *)help_switch {
    DeviceChooser *chooser = [[DeviceChooser alloc] init];

    changedHelpSwitchValue = YES;
    if (help_switch.isOn) {
        mainViewController.helpEnabled = YES;
        self.helpLabel.hidden = NO;
        self.helpButton.hidden = NO;
        self.helpView.hidden = NO;
        self.checkButton.hidden = YES;
        
        if ([chooser isPad]) {
            if ([chooser isSpanish]) {
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up_ipad.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down_ipad.png"] forState:UIControlStateHighlighted];
            } else {
                // English
                [checkButton setImage:[UIImage imageNamed:@"btn_check_up_ipad.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_check_down_ipad.png"] forState:UIControlStateHighlighted];
            }
        } else {
            // iPhone
            if ([chooser isSpanish]) {
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up_iphone.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down_iphone.png"] forState:UIControlStateHighlighted];
            } else {
                // English
                [checkButton setImage:[UIImage imageNamed:@"btn_check_up_iphone.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_check_down_iphone.png"] forState:UIControlStateHighlighted];
            }
        }
    }
    else {
        mainViewController.helpEnabled = NO;
        self.helpLabel.hidden = YES;
        self.helpButton.hidden = YES;
        self.helpView.hidden = YES;
        self.checkButton.hidden = NO;
        
        if ([chooser isPad]) {
            if ([chooser isSpanish]) {
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up_white_ipad.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down_white_ipad.png"] forState:UIControlStateHighlighted];
            } else {
                // English
                [checkButton setImage:[UIImage imageNamed:@"btn_check_up_white_ipad.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_check_down_white_ipad.png"] forState:UIControlStateHighlighted];
            }
        } else {
            // iPhone
            if ([chooser isSpanish]) {
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up_white_iphone.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down_white_iphone.png"] forState:UIControlStateHighlighted];
            } else {
                // English
                [checkButton setImage:[UIImage imageNamed:@"btn_check_up_white_iphone.png"] forState:UIControlStateNormal];
                [checkButton setImage:[UIImage imageNamed:@"btn_check_down_white_iphone.png"] forState:UIControlStateHighlighted];
            }
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (changedHelpSwitchValue) {
        changedHelpSwitchValue = NO;
        [mainViewController checkHelpEnabledAfterMenuHidden];
    }
}

@end
