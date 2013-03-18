//
//  RankingViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 14/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LayoutPresenter;

@interface RankingViewController : UIViewController {
    LayoutPresenter *_layoutPresenter;
}

@property (nonatomic, strong) LayoutPresenter *layoutPresenter;

@end
