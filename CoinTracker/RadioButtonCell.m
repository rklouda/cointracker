//
//  RadioButtonCell.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/19/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "RadioButtonCell.h"

@implementation RadioButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // enable multiple selection for water, beer and wine buttons.
}

@end
