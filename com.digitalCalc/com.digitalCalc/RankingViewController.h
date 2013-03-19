//
//  RankingViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 14/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingRowTable.h"

@class LayoutPresenter;

@interface RankingViewController : UIViewController {
    LayoutPresenter *_layoutPresenter;
}

@property (nonatomic, strong) IBOutlet UILabel *rankingLabel;
@property (nonatomic, strong) IBOutlet UIView *rankingAlphaView;

@property (nonatomic, strong) IBOutlet UILabel *firstClasifName;
@property (nonatomic, strong) IBOutlet UILabel *firstClasifPoints;
@property (nonatomic, strong) IBOutlet UILabel *firstClasifNumber;
@property (nonatomic, strong) IBOutlet UILabel *secondClasifName;
@property (nonatomic, strong) IBOutlet UILabel *secondClasifPoints;
@property (nonatomic, strong) IBOutlet UILabel *secondClasifNumber;
@property (nonatomic, strong) IBOutlet UILabel *thirdClasifName;
@property (nonatomic, strong) IBOutlet UILabel *thirdClasifPoints;
@property (nonatomic, strong) IBOutlet UILabel *thirdClasifNumber;
@property (nonatomic, strong) IBOutlet UILabel *fourthClasifName;
@property (nonatomic, strong) IBOutlet UILabel *fourthClasifPoints;
@property (nonatomic, strong) IBOutlet UILabel *fourthClasifNumber;
@property (nonatomic, strong) IBOutlet UILabel *fifthClasifName;
@property (nonatomic, strong) IBOutlet UILabel *fifthClasifPoints;
@property (nonatomic, strong) IBOutlet UILabel *fifthClasifNumber;

@property (nonatomic, strong) LayoutPresenter *layoutPresenter;

@end
