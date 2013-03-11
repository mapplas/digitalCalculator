//
//  LeftMenuViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LeftMenuViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

@synthesize helpButton, helpLabel, firstArgument, secondArgument;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor orangeColor];
    self.tableView.separatorColor = [UIColor brownColor];
    
    self.tableView.scrollEnabled = NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

-(BOOL)shouldAutorotate {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return MENU_TABLE_SECTIONS_COUNT;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return NSLocalizedString(@"menu_section_levels_title", @"Menu section levels title");
            break;
            
        case 1:
            return NSLocalizedString(@"menu_section_configuration_title", @"Menu section configuration title");            
            break;
        default:
            return @"";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *helpCellId = @"HelpOnOffText";
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = NSLocalizedString(@"menu_section_levels_low", @"Menu section levels low level");
                break;
                
            case 1:
                cell.textLabel.text = NSLocalizedString(@"menu_section_levels_medium", @"Menu section levels medium level");
                break;
                
            case 2:
                cell.textLabel.text = NSLocalizedString(@"menu_section_levels_high", @"Menu section levels high level");
                break;
        }
        return cell;
        
    } else {
        
        helpCell = [tableView dequeueReusableCellWithIdentifier:helpCellId];
        if (helpCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchedMenuCell" owner:self options:nil];
            helpCell = [nib objectAtIndex:0];
        }
        
        switch (indexPath.row) {
            case 0:
                helpCell.textLabel.text = NSLocalizedString(@"menu_section_settings_help_enabled", @"Menu section settings help enabled");
                break;
        }
        return helpCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    }
    else {
        switch (indexPath.row) {
            case 0:
                [helpCell.cellSwitch setOn:!helpCell.cellSwitch.on animated:YES];
                [self checkHelpSwitch:helpCell.cellSwitch];
                break;
                
            default:
                break;
        }
    }
}

- (void)checkHelpSwitch:(UISwitch *)help_switch {
    if (help_switch.isOn) {
        self.helpLabel.hidden = NO;
        self.helpButton.hidden = NO;
        [self initHelpActions];
    }
    else {
        self.helpLabel.hidden = YES;
        self.helpButton.hidden = YES;
    }
}

- (void)initHelpActions {
    helpManager = [[HelpManager alloc] initWithHelpLabel:self.helpLabel button:self.helpButton firstArgument:self.firstArgument secondArgument:self.secondArgument];
    [helpManager start];
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

@end
