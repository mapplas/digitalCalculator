//
//  CustomSlider.h
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MNESliderValuePopupView;

@interface CustomSlider : UISlider {
    MNESliderValuePopupView *valuePopupView;
}

@property (nonatomic, readonly) CGRect thumbRect;

- (void)initSliderWithValue:(NSInteger)slider_value;

@end
