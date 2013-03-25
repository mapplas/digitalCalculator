//
//  HowToGalleryViewController.m
//  com.digitalCalc
//
//  Created by Belén  on 25/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "HowToGalleryViewController.h"

@interface HowToGalleryViewController ()

@end

@implementation HowToGalleryViewController

@synthesize background, pageControl, scroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)pop {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"in_app_purchase_nav_left_button_title", @"In app purchase - Nav controller left button title") style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_up.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_hover.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [self initArray];
    [self configure];
}

- (void)initArray {
    imagesArray = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"tutorial_img1_en.png"],
                   [UIImage imageNamed:@"tutorial_img2_en.png"],
                   [UIImage imageNamed:@"tutorial_img3_en.png"],
                   [UIImage imageNamed:@"tutorial_img4_en.png"],
                   [UIImage imageNamed:@"tutorial_img5_en.png"],
                   [UIImage imageNamed:@"tutorial_img6_en.png"],
                   [UIImage imageNamed:@"tutorial_img7_en.png"],
                   [UIImage imageNamed:@"tutorial_img8_en.png"],
                   [UIImage imageNamed:@"tutorial_img9_en.png"],
                   [UIImage imageNamed:@"tutorial_img10_en.png"],
                   [UIImage imageNamed:@"tutorial_img11_en.png"],
                   nil];
}

- (void)configure {
	CGFloat contentOffset = 0.0f;
    
    self.scroll.clipsToBounds = NO;
    self.scroll.pagingEnabled = YES;
    self.scroll.showsHorizontalScrollIndicator = NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    
    self.pageControl.numberOfPages = imagesArray.count;
    self.pageControl.currentPage = 0;
    
    for (UIImage *currentImage in imagesArray) {
        
        if (currentImage != nil) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:currentImage];
            
            //            imageView.image = [resizer resizeImageForFullscreenView:currentImage];
            
            imageView.contentMode = UIViewContentModeCenter;
            
            [self.scroll addSubview:imageView];
            
            contentOffset += imageView.frame.size.width;
            self.scroll.contentSize = CGSizeMake(contentOffset, 300);
        }
    }
}

#pragma mark - UIScrollViewDelegate methods - PageControl
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = self.scroll.frame.size.width;
    int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= GALLERY_TUTORIAL_IMAGES) return;
}

@end
