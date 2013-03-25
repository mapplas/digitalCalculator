//
//  HowToGalleryViewController.h
//  com.digitalCalc
//
//  Created by Belén  on 25/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface HowToGalleryViewController : UIViewController <UIScrollViewDelegate> {
    NSMutableArray *imagesArray;
}

@property (nonatomic, strong) IBOutlet UIView *background;
@property (nonatomic, strong) IBOutlet UIScrollView *scroll;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@end
