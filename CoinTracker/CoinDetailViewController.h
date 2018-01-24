//
//  CoinDetailViewController.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinDetailViewController : UIViewController
{

}
@property (weak, nonatomic) IBOutlet NSString *coin;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel, *qty, *tradePrice, *totalValue;
@end
