//
//  ViewController.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/13/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL URLWithString:@"https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,LTC,BCH,ETH&tsyms=USD&e=Coinbase&extraParams=robsapp"];
    
 
 
    
    
    NSError* error = nil;
    NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *json = [NSJSONSerialization JSONObjectWithData:myData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    if( text )
    {
        NSLog(@"Text=%@", [json valueForKey:@"ETH"][@"USD"]);
     
        
     //   NSString *temp = [NSString stringWithFormat:@"%@",json[@"BTC"]];
        _BTCLabel.text = [NSString stringWithFormat:@"BTC = $%@",[json valueForKey:@"BTC"][@"USD"]];
    
        
     //  temp = [coins objectForKey:@"BTC"];
     //   _BTCLabel.text = [temp stringByReplacingOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [temp length])];

     //   _BTCLabel.text = [json valueForKey:@"BTC"];
        
        
    }
    else
    {
        NSLog(@"Error = %@", error);
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
