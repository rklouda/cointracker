//
//  MainCustomTVCell.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCustomTVCell : UITableViewCell
{
    NSDictionary *coins;
    NSString *BTC, *ETH;
    NSMutableArray *coinArray;
    float totalPercentGain;
    NSInteger AmountTV;
    NSInteger AmountTG;
}
@property (weak, nonatomic) IBOutlet NSString *coin, *coinImageString;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel, *priceLabel, *qty, *tradePrice, *currentPrice, *totalCost, *totalValue, *type, *tradeDate;
@property (weak, nonatomic) IBOutlet UILabel *gain, *gainpercent;
@property (nonatomic, weak) IBOutlet UIImageView* image;
@end
