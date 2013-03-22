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
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[mainViewController level] inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
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
                break;
                
            case 1:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_medium", @"Menu section levels medium level");
                break;
                
            case 2:
                plainTextMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_high", @"Menu section levels high level");
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
        } else if(indexPath.row == 1) {
            plainTextMenuCell = [tableView dequeueReusableCellWithIdentifier:levelCellId];
            if (plainTextMenuCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LevelMenuCell" owner:self options:nil];
                plainTextMenuCell = [nib objectAtIndex:0];
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
                break;
                
            case 1:
                plainTextMenuCell.textLabel.text = @"Change game mode";
                break;
            
            case 2:
                plainTextMenuCell.textLabel.text = @"Ranking";
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
                [mainViewController setLevel:LEVEL_LOW];
                break;
                
            case 1:
                if ([[GeniusLevelIAPHelper sharedInstance] productPurchased:NSLocalizedString(@"in_app_purchase_genius_level_identifier", @"In app purchase - Genius level product identifier")]) {
                    [mainViewController setLevel:LEVEL_MEDIUM];
                } else {
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
                [mainViewController mainMenuCellPressed];
                [self deselectRowandSelectCorrectOne:indexPath];

                break;
                
            case 2:
                [self pushRankingController];
                [self deselectRowandSelectCorrectOne:indexPath];

                break;
                
            default:
                break;
        }
    }
}

- (void)deselectRowandSelectCorrectOne:(NSIndexPath *)index_path {
    [self.tableView deselectRowAtIndexPath:index_path animated:YES];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[mainViewController level] inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
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
    RankingViewController *rankingViewController = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        rankingViewController = [[RankingViewController alloc] initWithNibName:@"RankingViewController_iPhone" bundle:nil];
    } else {
        rankingViewController = [[RankingViewController alloc] initWithNibName:@"RankingViewController_iPad" bundle:nil];
    }
    
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:rankingViewController];
    rankingViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    rankingViewController.layoutPresenter = nil;
    [mainViewController presentModalViewController:controller animated:YES];
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
        
        [self.checkButton setImage:[UIImage imageNamed:@"btn_check_up.png"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"btn_check_down.png"] forState:UIControlStateHighlighted];
        
        if ([chooser isSpanish]) {
            [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up.png"] forState:UIControlStateNormal];
            [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down.png"] forState:UIControlStateHighlighted];
        }
    }
    else {
        mainViewController.helpEnabled = NO;
        self.helpLabel.hidden = YES;
        self.helpButton.hidden = YES;
        self.helpView.hidden = YES;
        self.checkButton.hidden = NO;
        
        [self.checkButton setImage:[UIImage imageNamed:@"btn_check_up_white.png"] forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"btn_check_down_white.png"] forState:UIControlStateHighlighted];
        
        if ([chooser isSpanish]) {
            [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_up_white.png"] forState:UIControlStateNormal];
            [checkButton setImage:[UIImage imageNamed:@"btn_comprobar_down_white.png"] forState:UIControlStateHighlighted];
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
