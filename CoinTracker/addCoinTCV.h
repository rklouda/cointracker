//
//  addCoinTCV.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/14/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface addCoinTCV : UITableViewController <UISearchBarDelegate, UISearchResultsUpdating>
{
     NSInteger coinPrice;
    NSDictionary *coins;
    NSMutableArray *coinArray, *coinSymbolArray, *coinNameArray;
    NSManagedObjectContext *context;
    NSManagedObject *newDevice;
}
@property (weak, nonatomic) IBOutlet NSString *coin;
@property (weak, nonatomic) IBOutlet NSString *coinImageString;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *update;
@property (strong) NSManagedObject *coindb;
@property (weak, nonatomic) IBOutlet UIImageView *coinImage;
@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, readonly) NSArray *searchResults;

@end
