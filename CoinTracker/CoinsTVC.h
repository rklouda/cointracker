//
//  CoinsTVC.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/14/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoinsTVC : UITableViewController
{
    NSDictionary *coins;
    NSString *BTC, *ETH;
    NSMutableArray *coinArray;
    float totalPercentGain;
    NSInteger AmountTV;
    NSInteger AmountTG;
    float totalMarket, totalGainRK, totalCostRK, totalHoldingsRK;
  //  UIBarButtonItem *addButton;
}
@property (weak, nonatomic) IBOutlet NSString *coin, *coinImageString, *type;
@property (weak, nonatomic) IBOutlet UILabel *ETHLabel;
@property (weak, nonatomic) IBOutlet UILabel *BTCLabel;
@property (strong) NSMutableArray *companyarray, *companyarrayfull;
@property (strong) NSManagedObject *coindb;


@end
