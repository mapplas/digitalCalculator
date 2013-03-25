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
    
    deviceChooser = [[DeviceChooser alloc] init];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"gallery_nav_left_button_title", @"Gallery - Nav controller left button title") style:UIBarButtonItemStyleBordered target:self action:@selector(pop)];
    
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_up.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem.leftBarButtonItem setBackgroundImage:[UIImage imageNamed:@"btn_menu_hover.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    [self initArray];
    [self configure];
}

- (void)initArray {
    if ([deviceChooser isSpanish]) {
        imagesArray = [[NSMutableArray alloc] initWithObjects:
                       [UIImage imageNamed:@"tutorial_img1_es.png"],
                       [UIImage imageNamed:@"tutorial_img2_es.png"],
                       [UIImage imageNamed:@"tutorial_img3_es.png"],
                       [UIImage imageNamed:@"tutorial_img4_es.png"],
                       [UIImage imageNamed:@"tutorial_img5_es.png"],
                       [UIImage imageNamed:@"tutorial_img6_es.png"],
                       [UIImage imageNamed:@"tutorial_img7_es.png"],
                       [UIImage imageNamed:@"tutorial_img8_es.png"],
                       [UIImage imageNamed:@"tutorial_img9_es.png"],
                       [UIImage imageNamed:@"tutorial_img10_es.png"],
                       [UIImage imageNamed:@"tutorial_img11_es.png"],
                       nil];
    } else {
        imagesArray = [[NSMutableArray alloc] initWithObjects:
                       [UIImage imageNamed:@"tutorial_img1_en.png"],
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
            UIImage *resizedImage = nil;
            if ([deviceChooser isPad]) {
                resizedImage = [currentImage resizedImage:CGSizeMake(currentImage.size.width / 1.6, currentImage.size.height / 1.6) interpolationQuality:kCGInterpolationHigh];
            } else {
                resizedImage = nil;
            }

            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(contentOffset, 0, scroll.frame.size.width, scroll.frame.size.height)];
            imageView.image = resizedImage;
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
