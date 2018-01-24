//
//  CoinDetailTVC.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoinDetailTVC : UITableViewController
{
    NSArray *temp3;
}
@property (strong) NSMutableArray *companyarray;
@property (weak, nonatomic) IBOutlet NSString *coin, *coinImageString;
@property (weak, nonatomic) IBOutlet UILabel *coinLabel, *currentPrice, *totalCost;
@property (strong) NSManagedObject *coindb;

@end
