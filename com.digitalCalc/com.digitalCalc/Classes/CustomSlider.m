//
//  CustomSlider.m
//  com.digitalCalc
//
//  Created by Belén  on 20/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "CustomSlider.h"

#pragma mark - Private UIView subclass rendering the popup showing slider value

@interface MNESliderValuePopupView : UIView
@property (nonatomic) float value;
@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) NSString *text;
@end

@implementation MNESliderValuePopupView

@synthesize value =_value;
@synthesize font =_font;
@synthesize text = _text;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        DeviceChooser *chooser = [[DeviceChooser alloc] init];
        if ([chooser isPad]) {
            self.font = [UIFont fontWithName:@"The Girl Next Door" size:80];
        } else {
            self.font = [UIFont fontWithName:@"The Girl Next Door" size:52];
        }
    }
    return self;
}

- (void)dealloc {
    self.text = nil;
    self.font = nil;
}

- (void)drawRect:(CGRect)rect {
        
    // Set the fill color
	[[UIColor colorWithWhite:0 alpha:0.8] setFill];
    
    // Create the path for the rounded rectangle
    CGRect roundedRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, floorf(self.bounds.size.height * 0.8));
    UIBezierPath *roundedRectPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect cornerRadius:6.0];
    
    // Create the arrow path
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    CGFloat midX = CGRectGetMidX(self.bounds);
    CGPoint p0 = CGPointMake(midX, CGRectGetMaxY(self.bounds));
    [arrowPath moveToPoint:p0];
    [arrowPath addLineToPoint:CGPointMake((midX - 10.0), CGRectGetMaxY(roundedRect))];
    [arrowPath addLineToPoint:CGPointMake((midX + 10.0), CGRectGetMaxY(roundedRect))];
    [arrowPath closePath];
    
    // Attach the arrow path to the rounded rect
    [roundedRectPath appendPath:arrowPath];
    
    [roundedRectPath fill];
    
    // Draw the text
    if (self.text) {
        [[UIColor colorWithWhite:1 alpha:0.8] set];
        CGSize s = [_text sizeWithFont:self.font];
        CGFloat yOffset = ((roundedRect.size.height - s.height) / 2) + 4;
        CGRect textRect = CGRectMake(roundedRect.origin.x, yOffset, roundedRect.size.width, s.height);
        
        [_text drawInRect:textRect
                 withFont:self.font
            lineBreakMode:UILineBreakModeWordWrap
                alignment:UITextAlignmentCenter];
    }
}

- (void)setValue:(float)aValue {
    _value = aValue;
    self.text = [NSString stringWithFormat:@"%d", (int)_value];
    [self setNeedsDisplay];
}

@end

#pragma mark - MNEValueTrackingSlider implementations

@implementation CustomSlider

@synthesize thumbRect;

#pragma mark - Private methods

- (void)_constructSlider {
    valuePopupView = [[MNESliderValuePopupView alloc] initWithFrame:CGRectZero];
    valuePopupView.backgroundColor = [UIColor clearColor];
    valuePopupView.alpha = 1.0;
    [self addSubview:valuePopupView];
}

- (void)initSliderWithValue:(NSInteger)slider_value {
    self.value = slider_value;
    [self _positionAndUpdatePopupView];
}

- (int)getSliderValue {
    float integer = valuePopupView.value;
//    CGFloat myfloat = integer;
//    NSLog(@"%f %d", integer, (int)integer);
    return (int)integer;
}

//- (void)_fadePopupViewInAndOut:(BOOL)aFadeIn {
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.5];
//    if (aFadeIn) {
//        valuePopupView.alpha = 1.0;
//    } else {
//        valuePopupView.alpha = 0.0;
//    }
//    [UIView commitAnimations];
//}

- (void)_positionAndUpdatePopupView {
    CGRect _thumbRect = self.thumbRect;
    CGRect rect = CGRectZero;
    CGRect popupRect = CGRectZero;
    
    DeviceChooser *deviceChooser = [[DeviceChooser alloc] init];
    if ([deviceChooser isPad]) {
        rect = CGRectMake(_thumbRect.origin.x - 20, _thumbRect.origin.y - 20, _thumbRect.size.width * 2, _thumbRect.size.height * 2.2);
        popupRect = CGRectOffset(rect, 0, floorf(-(_thumbRect.size.height * 1.8)));
    } else {
        rect = CGRectMake(_thumbRect.origin.x, _thumbRect.origin.y - 2, _thumbRect.size.width + 4, _thumbRect.size.height);
        popupRect = CGRectOffset(rect, 0, floorf(-(_thumbRect.size.height * 1.4)));
    }
    
    valuePopupView.frame = CGRectInset(popupRect, -20, -10);
        
    NSString *stringValue = [NSString stringWithFormat:@"%.f", self.value];
    self.value = [stringValue floatValue];
    valuePopupView.value = [stringValue floatValue];
}

#pragma mark - Memory management

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _constructSlider];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _constructSlider];
    }
    return self;
}

#pragma mark - UIControl touch event tracking

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    BOOL toReturn = [super beginTrackingWithTouch:touch withEvent:event];
    // Fade in and update the popup view
    CGPoint touchPoint = [touch locationInView:self];
    // Check if the knob is touched. Only in this case show the popup-view
    if(CGRectContainsPoint(CGRectInset(self.thumbRect, -12.0, -12.0), touchPoint)) {
        [self _positionAndUpdatePopupView];
//        [self _fadePopupViewInAndOut:YES];
    }
    return toReturn;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Update the popup view as slider knob is being moved
    BOOL ret = [super continueTrackingWithTouch:touch withEvent:event];
    [self _positionAndUpdatePopupView];
    return ret;
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    // Fade out the popoup view
//    [self _fadePopupViewInAndOut:NO];
    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Custom property accessors

- (CGRect)thumbRect {
    CGRect trackRect = [self trackRectForBounds:self.bounds];
    CGRect thumbR = [self thumbRectForBounds:self.bounds
                                   trackRect:trackRect
                                       value:self.value];
    return thumbR;
}

@end

