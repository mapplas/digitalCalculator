//
//  LeftMenuViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ViewController.h"

@interface LeftMenuViewController ()
@end

@implementation LeftMenuViewController

@synthesize helpButton, helpLabel, helpView;

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

//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg_menu_cell.png"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.scrollEnabled = NO;
}

#pragma mark - UITableViewDataSource and Delate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MENU_TABLE_SECTIONS_COUNT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *helpCellId = @"HelpOnOffText";
    NSString *levelCellId = @"LevelMenuText";
    NSString *plainCellId = @"PlainMenuText";
    
    if (indexPath.section == 0) {
        levelMenuCell = [tableView dequeueReusableCellWithIdentifier:levelCellId];
        if (levelMenuCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LevelMenuCell" owner:self options:nil];
            levelMenuCell = [nib objectAtIndex:0];
        }
        
        switch (indexPath.row) {
            case 0:
                levelMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_low", @"Menu section levels low level");
                [levelMenuCell.textLabel setFont:[UIFont boldSystemFontOfSize:17]];
                break;
                
            case 1:
                levelMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_medium", @"Menu section levels medium level");
                break;
                
            case 2:
                levelMenuCell.textLabel.text = NSLocalizedString(@"menu_section_levels_high", @"Menu section levels high level");
                break;
        }
        return levelMenuCell;
        
    } else {
        
        if (indexPath.row == 0) {
            helpCell = [tableView dequeueReusableCellWithIdentifier:helpCellId];
            if (helpCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchedMenuCell" owner:self options:nil];
                helpCell = [nib objectAtIndex:0];
            }
        } else {
            plainMenuCell = [tableView dequeueReusableCellWithIdentifier:plainCellId];
            if (plainMenuCell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlainMenuCell" owner:self options:nil];
                plainMenuCell = [nib objectAtIndex:0];
            }
        }
        
        switch (indexPath.row) {
            case 0:
                
//              If calculator mode is game mode, disable help switch
                if (mainViewController.mode == CALCULATOR_MODE_GAME) {
                    [helpCell.cellSwitch setOn:NO];
                }
                
                helpCell.textLabel.text = NSLocalizedString(@"menu_section_settings_help_enabled", @"Menu section settings help enabled");
                break;
                
            case 1:
                plainMenuCell.textLabel.text = @"Change game mode";
                break;
        }
        
        if (indexPath.row == 0) {
            return helpCell;
        } else {
            return plainMenuCell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    }
    else {
        switch (indexPath.row) {
            case 0:
//              If calculator mode is game mode, do nothing
                if (!mainViewController.mode == CALCULATOR_MODE_GAME) {
                    [helpCell.cellSwitch setOn:!helpCell.cellSwitch.on animated:YES];
                    [self checkHelpSwitch:helpCell.cellSwitch];
                }
                break;
                
            case 1:
                [mainViewController mainMenuCellPressed];
                break;
                
            default:
                break;
        }
    }
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
    NSInteger height = MENU_TABLE_HEADER_HEIGHT_IPHONE;
    DeviceChooser *deviceChooser = [[DeviceChooser alloc] init];
    if ([deviceChooser isPad]) {
        height = MENU_TABLE_HEADER_HEIGHT_IPAD;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, height)];
    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg_menu_header.png"]]];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    NSInteger headerLabelHeight = 20;
    headerLabel.frame = CGRectMake(10, (height / 2) - (headerLabelHeight / 2), 200, headerLabelHeight);
    headerLabel.textColor = [UIColor blackColor];
    
    
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
    DeviceChooser *deviceChooser = [[DeviceChooser alloc] init];
    if ([deviceChooser isPad]) {
        return  MENU_TABLE_HEADER_HEIGHT_IPAD;
    } else {
        return MENU_TABLE_HEADER_HEIGHT_IPHONE;
    }
}

#pragma mark - Help actions
- (void)checkHelpSwitch:(UISwitch *)help_switch {
    changedHelpSwitchValue = YES;
    if (help_switch.isOn) {
        mainViewController.helpEnabled = YES;
        self.helpLabel.hidden = NO;
        self.helpButton.hidden = NO;
        self.helpView.hidden = NO;
    }
    else {
        mainViewController.helpEnabled = NO;
        self.helpLabel.hidden = YES;
        self.helpButton.hidden = YES;
        self.helpView.hidden = YES;
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
