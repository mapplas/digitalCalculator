//
//  SwitchedMenuCell.h
//  com.digitalCalc
//
//  Created by Belén  on 07/03/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchedMenuCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *textLabel;
@property (nonatomic, strong) IBOutlet UISwitch *cellSwitch;
@property (nonatomic, strong) IBOutlet UIImageView *image;

@end
