//
//  CoinDetailViewController.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "CoinDetailViewController.h"

@interface CoinDetailViewController ()

@end

@implementation CoinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:_coin];
  //  _coinLabel.text = _coin;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
