//
//  ViewController.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/13/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

{
    NSDictionary *coins;
    NSString *BTC, *ETH;
    
}
@property (weak, nonatomic) IBOutlet UILabel *ETHLabel;
@property (weak, nonatomic) IBOutlet UILabel *BTCLabel;
@end

