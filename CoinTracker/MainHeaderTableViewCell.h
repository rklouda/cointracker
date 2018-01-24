//
//  MainHeaderTableViewCell.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainHeaderTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel* title;
@property (nonatomic, weak) IBOutlet UILabel* subtitle, *percent;
@property (nonatomic, weak) IBOutlet UIImageView* image;
@end
