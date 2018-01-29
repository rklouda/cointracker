//
//  AddTransactionTVC.h
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "addCoinTCV.h"
#import "RadioButtonCell.h"
#import "SVProgressHUD.h"

@interface AddTransactionTVC : UITableViewController <UITextFieldDelegate>
{
    
    RadioButtonCell *cell;
    DLRadioButton *radioButton;
    DLRadioButton *firstRadioButton;
      UIDatePicker *datePicker, *datePicker2;
    
}
@property (weak, nonatomic) IBOutlet UILabel *currentPrice, *totalValue, *taxType;
//@property (weak, nonatomic) IBOutlet NSString *coin;

@property (strong, nonatomic) IBOutlet UITextField  *company;
@property (strong) NSManagedObject *coindb, *newcoindb, *addtransdb;
@property (strong) NSString *companyName;
@property (weak, nonatomic) IBOutlet NSString *coinImageString, *currency;
//currency is tradetype to be added to database

@property (weak, nonatomic) IBOutlet UIImageView *coinImage;
@property (weak, nonatomic) IBOutlet UIView *radioView;
 @property (strong, nonatomic) UITableViewCell *radioButtonCell;
@property (strong, nonatomic) IBOutlet UITextField *tradePrice, *qty, *fee, *totalCostBasis;
@property (weak, nonatomic) IBOutlet UITextField *dateSelectionTextField, *dateSelectionTextField2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSave;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnBack:(id)sender;

@end
