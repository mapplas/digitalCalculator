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
    
    NSEnumerator *rankingEnum = [ranking objectEnumerator];
    int i = 1;
    for (NSArray *elements in rankingEnum) {
        switch (i) {
            case 1:
                self.firstClasifName.text = [NSString stringWithFormat:@"%@ %@", firstClasifName.text, [elements objectAtIndex:0]];
                self.firstClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 2:
                self.secondClasifName.text = [NSString stringWithFormat:@"%@ %@", self.secondClasifName.text, [elements objectAtIndex:0]];
                self.secondClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 3:
                self.thirdClasifName.text = [NSString stringWithFormat:@"%@ %@", self.thirdClasifName.text, [elements objectAtIndex:0]];
                self.thirdClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 4:
                self.fourthClasifName.text = [NSString stringWithFormat:@"%@ %@", self.fourthClasifName.text, [elements objectAtIndex:0]];
                self.fourthClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            case 5:
                self.fifthClasifName.text = [NSString stringWithFormat:@"%@ %@", self.fifthClasifName.text, [elements objectAtIndex:0]];
                self.fifthClasifPoints.text = [elements objectAtIndex:1];
                break;
                
            default:
                break;
        }
        i++;
    }

}
     
- (void)pop {
    [self.layoutPresenter rankingControllerPopped];
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)initRankingLabels {
    NSString *user = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    self.firstClasifName.text = NSLocalizedString(@"ranking_screen_first_position_prefix", @"Ranking screen 1st position prefix");
    self.secondClasifName.text = NSLocalizedString(@"ranking_screen_second_position_prefix", @"Ranking screen 2nd position prefix");
    self.thirdClasifName.text = NSLocalizedString(@"ranking_screen_third_position_prefix", @"Ranking screen 3rh position prefix");
    self.fourthClasifName.text = NSLocalizedString(@"ranking_screen_fourth_position_prefix", @"Ranking screen 4th position prefix");
    self.fifthClasifName.text = NSLocalizedString(@"ranking_screen_fifth_position_prefix", @"Ranking screen 5th position prefix");
    
    self.firstClasifPoints.text = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    self.secondClasifPoints.text = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    self.thirdClasifPoints.text = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    self.fourthClasifPoints.text = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    self.fifthClasifPoints.text = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
}

@end
