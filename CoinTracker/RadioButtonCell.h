//
//  RadioButtonCell.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/19/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLRadioButton.h"

@interface RadioButtonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet DLRadioButton *waterButton;
@property (weak, nonatomic) IBOutlet UIView *view;

;
@end
