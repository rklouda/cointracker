//
//  CoinHeaderTableViewCell.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinHeaderTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *coinName;
@property (nonatomic, weak) IBOutlet UILabel *totalHoldings, *totalValue, *totalNetCost, *totalGain, *currentPrice, *percentGain;
@property (nonatomic, weak) IBOutlet UIImageView* image;

@end
