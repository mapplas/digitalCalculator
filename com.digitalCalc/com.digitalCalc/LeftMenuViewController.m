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
    } else {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = NSLocalizedString(@"menu_section_settings_help_enabled", @"Menu section settings help enabled");
                break;
        }
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
