//
//  RankingViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 14/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RankingViewController.h"
#import "LayoutPresenter.h"

@interface RankingViewController ()
- (void)pop;
@end

@implementation RankingViewController

@synthesize layoutPresenter = _layoutPresenter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_ranking_left_button_title", @"Ranking controller left button title") style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
}
     
- (void)pop {
    [self.layoutPresenter rankingControllerPopped];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


@end
