//
//  LeftMenuViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchedMenuCell.h"
#import "LevelMenuCell.h"
#import "deviceChooser.h"
#import "SharingHelper.h"

#import "GeniusLevelIAPHelper.h"

#define MENU_TABLE_ROW_HEIGHT 50
#define MENU_TABLE_HEADER_HEIGHT 26

#define MENU_TABLE_SECTIONS_COUNT 2
#define MENU_TABLE_LEVELS_SECTION_COUNT 3
#define MENU_TABLE_CONFIG_SECTION_COUNT 5

@class ViewController;

@interface LeftMenuViewController : UITableViewController {
    ViewController *mainViewController;
    BOOL changedHelpSwitchValue;
    
    SwitchedMenuCell *helpCell;
    LevelMenuCell *plainTextMenuCell;
}

- (id)initWithMainViewController:(UINavigationController *)main_view_controller;

@property (nonatomic, strong) UILabel *helpLabel;
@property (nonatomic, strong) UIButton *helpButton;
@property (nonatomic, strong) UIView *helpView;
@property (nonatomic, strong) UIButton *checkButton;
@property (nonatomic, strong) NSArray *products;

@end
