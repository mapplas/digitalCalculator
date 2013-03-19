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

@synthesize firstClasifName, secondClasifName, thirdClasifName, fourthClasifName, fifthClasifName;
@synthesize firstClasifPoints, secondClasifPoints, thirdClasifPoints, fourthClasifPoints, fifthClasifPoints;

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
    
    [self initRankingLabels];
    
    RankingRowTable *table = [[RankingRowTable alloc] init];
    NSMutableDictionary *ranking = [table getFirstBestPuntuations:RANKING_ELEMENTS];
    [table removeRankingElements:RANKING_ELEMENTS];
    
    for (int i = 1; i <= ranking.count; i++) {
        NSArray *elements = [ranking objectForKey:[NSNumber numberWithInt:i]];
        switch (i) {
            case 1:
                self.firstClasifName.text = [elements objectAtIndex:0];
                self.firstClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 2:
                self.secondClasifName.text = [elements objectAtIndex:0];
                self.secondClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 3:
                self.thirdClasifName.text = [elements objectAtIndex:0];
                self.thirdClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 4:
                self.fourthClasifName.text = [elements objectAtIndex:0];
                self.fourthClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 5:
                self.fifthClasifName.text = [elements objectAtIndex:0];
                self.fifthClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            default:
                break;
        }
    }
}
     
- (void)pop {
    [self.layoutPresenter rankingControllerPopped];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)initRankingLabels {
    NSString *userString = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    self.firstClasifName.text = userString;
    self.secondClasifName.text = userString;
    self.thirdClasifName.text = userString;
    self.fourthClasifName.text = userString;
    self.fifthClasifName.text = userString;
    
    NSString *pointsString = NSLocalizedString(@"ranking_screen_no_points_text", @"Ranking screen no points text");
    self.firstClasifPoints.text = pointsString;
    self.secondClasifPoints.text = pointsString;
    self.thirdClasifPoints.text = pointsString;
    self.fourthClasifPoints.text = pointsString;
    self.fifthClasifPoints.text = pointsString;
}

@end
