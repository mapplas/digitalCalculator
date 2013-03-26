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

@synthesize rankingLabel;
@synthesize rankingAlphaView;
@synthesize firstClasifName, secondClasifName, thirdClasifName, fourthClasifName, fifthClasifName;
@synthesize firstClasifPoints, secondClasifPoints, thirdClasifPoints, fourthClasifPoints, fifthClasifPoints;
@synthesize firstClasifNumber, secondClasifNumber, thirdClasifNumber, fourthClasifNumber, fifthClasifNumber;

@synthesize layoutPresenter = _layoutPresenter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initRankingLabels];
    [self initLayout];
    
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

- (void)initLayout {
    // Play again nav button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"nav_bar_ranking_left_button_title", @"Ranking controller left button title") style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_up.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_hover.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];

    
    // Ranking header
    self.rankingLabel.text = NSLocalizedString(@"ranking_screen_title", @"Ranking screen title");
    self.rankingLabel.font = [UIFont fontWithName:@"Blokletters Potlood" size:self.rankingLabel.font.pointSize];
    
    // Alpha view
    self.rankingAlphaView.layer.cornerRadius = 20;
    self.rankingAlphaView.layer.masksToBounds = YES;
}

- (void)initRankingLabels {
    int nameLabelSize = 25;
    
    NSString *userString = NSLocalizedString(@"ranking_screen_no_user_text", @"Ranking screen no user text");
    self.firstClasifName.text = userString;
    self.firstClasifName.font = [UIFont fontWithName:@"The Girl Next Door" size:nameLabelSize];
    self.secondClasifName.text = userString;
    self.secondClasifName.font = [UIFont fontWithName:@"The Girl Next Door" size:nameLabelSize];
    self.thirdClasifName.text = userString;
    self.thirdClasifName.font = [UIFont fontWithName:@"The Girl Next Door" size:nameLabelSize];
    self.fourthClasifName.text = userString;
    self.fourthClasifName.font = [UIFont fontWithName:@"The Girl Next Door" size:nameLabelSize];
    self.fifthClasifName.text = userString;
    self.fifthClasifName.font = [UIFont fontWithName:@"The Girl Next Door" size:nameLabelSize];
    
    int pointLabelSize = 35;
    NSString *pointsString = NSLocalizedString(@"ranking_screen_no_points_text", @"Ranking screen no points text");
    self.firstClasifPoints.text = pointsString;
    self.firstClasifPoints.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.secondClasifPoints.text = pointsString;
    self.secondClasifPoints.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.thirdClasifPoints.text = pointsString;
    self.thirdClasifPoints.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.fourthClasifPoints.text = pointsString;
    self.fourthClasifPoints.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.fifthClasifPoints.text = pointsString;
    self.fifthClasifPoints.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    
    self.firstClasifNumber.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.secondClasifNumber.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.thirdClasifNumber.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.fourthClasifNumber.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
    self.fifthClasifNumber.font = [UIFont fontWithName:@"The Girl Next Door" size:pointLabelSize];
}

@end
