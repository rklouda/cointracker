//
//  AddTransactionTVC.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "AddTransactionTVC.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "RadioButtonCell.h"
#import "SVProgressHUD.h"


@interface AddTransactionTVC ()

@end


@implementation AddTransactionTVC
@synthesize coindb, companyName;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///NEED TO ADD Date, Buy/Sell and Exchange
    
  
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
   // _coinLabel.text = _coin;
   //  [self.company setText:[self.coindb valueForKey:@"symbol"]];

  // construct first name cell, section 0, row 0
    
  
  //  self.radioButtonCell = [[UITableViewCell alloc] init];
  //  self.radioButtonCell.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.5f];
  //  self.firstNameText = [[UITextField alloc]initWithFrame:CGRectInset(self.radioView.bounds, 15, 0)];
  //  self.firstNameText.placeholder = @"First Name";
      [SVProgressHUD show];
 //TextField Delegates
   self.qty.delegate = self;
self.tradePrice.delegate = self;
    self.fee.delegate = self;
     self.totalCostBasis.delegate = self;
    

 //Set done on keyboard
    UIToolbar* keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(yourTextViewDoneButtonPressed)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.qty.inputAccessoryView = keyboardToolbar;
    self.tradePrice.inputAccessoryView = keyboardToolbar;
    self.fee.inputAccessoryView = keyboardToolbar;
    self.totalCostBasis.inputAccessoryView = keyboardToolbar;
    
     //Set up radion buttons
    CGRect frame = CGRectMake(10, 0, 120, 44);
    firstRadioButton = [self createRadioButtonWithFrame:frame
                                                                 Title:@"Buy"
                                                                 Color:[UIColor blackColor]];
    // other buttons
    NSArray *colorNames = @[@"Sell"];//, @"Watch"];
    NSArray *colors = @[[UIColor blackColor]]; //, [UIColor blackColor]];
    NSInteger i = 0;
    NSMutableArray *otherButtons = [NSMutableArray new];
    for (UIColor *color in colors) {
        CGRect frame = CGRectMake(120 * i+ 120, 0, 120, 44);
        radioButton = [self createRadioButtonWithFrame:frame
                                                                Title:colorNames[i]
                                                                Color:color];
        // put icon on the right side
        //  radioButton.iconOnRight = YES;
        //  radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        [otherButtons addObject:radioButton];
        i++;
    }
    
    firstRadioButton.otherButtons = otherButtons;
    [firstRadioButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    
   //Set up datapicker
    datePicker=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeDate;
    [self.dateSelectionTextField setInputView:datePicker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowSelectedDate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.dateSelectionTextField setInputAccessoryView:toolBar];
    [datePicker setDate:[NSDate date]];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM DD, YYYY"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    
    datePicker2=[[UIDatePicker alloc]init];
    datePicker2.datePickerMode=UIDatePickerModeDate;
    [self.dateSelectionTextField2 setInputView:datePicker2];
    
    UIToolbar *toolBar2=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolBar2 setTintColor:[UIColor grayColor]];
    UIBarButtonItem *doneBtn2=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ShowSelectedDate2)];
    UIBarButtonItem *space2=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar2 setItems:[NSArray arrayWithObjects:space2,doneBtn2, nil]];
    [self.dateSelectionTextField2 setInputAccessoryView:toolBar2];
    [datePicker2 setDate:[NSDate date]];
    
    NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
    [formatter2 setDateFormat:@"MMM DD, YYYY"];
    self.dateSelectionTextField2.text=[NSString stringWithFormat:@"%@",[formatter2 stringFromDate:datePicker2.date]];

    
    
////////////////////////////////////////
if (_newcoindb) {
        self.navigationItem.title = @"Add Transaction";
        
        NSLog(@"Coin passed newcoindb: %@",[self.newcoindb valueForKey:@"coinname"]);
    self.company.userInteractionEnabled = NO;
  //  NSLog(@"Coin passed: %@",[self.newcoindb valueForKey:@"coinname"]);
        
        self.company.text = [self.newcoindb valueForKey:@"coinname"];
    /*
          //add in transaction db
        [self.qty setText:[self.newcoindb valueForKey:@"qty"]];
     [self.tradePrice setText:[self.newcoindb valueForKey:@"tradeprice"]];
     [self.totalValue setText:[self.newcoindb valueForKey:@"totalvalue"]];
       [self.fee setText:[self.newcoindb valueForKey:@"fee"]];
          self.currency = [self.newcoindb valueForKey:@"currency"];
        
        if ([self.currency isEqualToString:@"Buy"]) {
            [firstRadioButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
           if ([self.currency isEqualToString:@"Sell"]){
              [radioButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
        [datePicker setDate:[self.newcoindb valueForKey:@"tradedate"]];
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"MMM DD, YYYY"];
        self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    */
      
        NSString *urlReceived = [NSString stringWithFormat:@"https://www.cryptocompare.com/api/data/coinlist/"];
        
        NSURL *url = [NSURL URLWithString:urlReceived];
        
        NSError* error = nil;
        NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
        NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *BTCUSD = [NSJSONSerialization JSONObjectWithData:myData
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
        
        
        NSLog(@"BTCUSD: %@",[BTCUSD allKeys]);
        
        NSArray *temp2 = [BTCUSD valueForKey:@"Data"][[self.newcoindb valueForKey:@"coinname"] ];
        
        
        NSLog(@"Array: %@", temp2);
        NSLog(@"BTCUSD: %@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[self.newcoindb valueForKey:@"coinname"]][@"ImageUrl"]);
        
        _coinImageString = [NSString stringWithFormat:@"%@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[self.newcoindb valueForKey:@"coinname"]][@"ImageUrl"]];
        
        
        NSLog(@"Image String: %@", _coinImageString);
        
        //  cell.imageView.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
        
      _coinImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
        
        NSString *tempURL = [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/price?fsym=%@&tsyms=USD",[self.newcoindb valueForKey:@"coinname"]];
        
        NSURL *url2 = [NSURL URLWithString:tempURL];
        
        NSError* error2 = nil;
        NSString* text2 = [NSString stringWithContentsOfURL:url2 encoding:NSASCIIStringEncoding error:&error2];
        NSData *myData2 = [text2 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *BTCUSD2 = [NSJSONSerialization JSONObjectWithData:myData2
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&error2];
        
        
   NSLog(@"BTCUSD2 help: %@", BTCUSD2);
        
     NSArray *temp3 = [BTCUSD2 allValues] ;
     NSLog(@"temp3: %@", temp3[0]);
     self.currentPrice.text =[NSString stringWithFormat:@"$%@", temp3[0]];
        
    }
    
 if (coindb)
   {
        self.navigationItem.title = @"Edit Transaction";
        NSLog(@"Coin passed coindb: %@",[self.coindb valueForKey:@"coinname"]);
        self.company.userInteractionEnabled = NO;
   // [self.company setText:[self.coindb valueForKey:@"symbol"]];
      self.company.text = [self.coindb valueForKey:@"coinname"];
    
         //add in transaction db
    //   self.qty.text = [self.coindb valueForKey:@"qty"];
       if ([self.currency isEqualToString:@"Sell"]){
           
         
           self.qty.textColor = [UIColor redColor];
       }
       else
       {
           self.qty.textColor = [UIColor blackColor];
           
       }
     float help;
       help  =[[self.coindb valueForKey:@"qty"] floatValue];
      
       NSString *qtytext = [NSString stringWithFormat:@"%.2f", help];
       [self.qty setText:qtytext];
       
       
       float help2;
       help2  =[[self.coindb valueForKey:@"totalvalue"] floatValue];
       
       NSString *TVtext = [NSString stringWithFormat:@"%.2f", help2];
       [self.totalValue setText:TVtext];
       [self.totalCostBasis setText:TVtext];
       
       
       // [self.totalValue setText:[self.coindb valueForKey:@"totalvalue"]];
       
      self.taxType = [self.coindb valueForKey:@"taxtype"];
       
         [self.tradePrice setText:[self.coindb valueForKey:@"tradeprice"]];
     
           [self.fee setText:[self.coindb valueForKey:@"fee"]];
        self.currency = [self.coindb valueForKey:@"currency"];
       
       if ([self.currency isEqualToString:@"Buy"]) {
           [firstRadioButton sendActionsForControlEvents:UIControlEventTouchUpInside];
       }
         if ([self.currency isEqualToString:@"Sell"]){
           [radioButton sendActionsForControlEvents:UIControlEventTouchUpInside];
       }
       
       
    [datePicker setDate:[self.coindb valueForKey:@"tradedate"]];
       
       NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
       [formatter setDateFormat:@"MMM dd, YYYY"];
       self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
       
   [datePicker2 setDate:[self.coindb valueForKey:@"receivedate"]];
       NSDateFormatter *formatter2=[[NSDateFormatter alloc]init];
       [formatter2 setDateFormat:@"MMM dd, YYYY"];
       self.dateSelectionTextField2.text=[NSString stringWithFormat:@"%@",[formatter2 stringFromDate:datePicker2.date]];
      
       
       
       self.coinImage.image = [UIImage imageWithData:[self.coindb valueForKey:@"image"]];
       
  /*
       NSString *urlReceived = [NSString stringWithFormat:@"https://www.cryptocompare.com/api/data/coinlist/"];
       
       NSURL *url = [NSURL URLWithString:urlReceived];
       
       NSError* error = nil;
       NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
       NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
       NSDictionary *BTCUSD = [NSJSONSerialization JSONObjectWithData:myData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&error];
       
       
       NSLog(@"BTCUSD: %@",[BTCUSD allKeys]);
       
       NSArray *temp2 = [BTCUSD valueForKey:@"Data"][[self.coindb valueForKey:@"coinname"] ];
       
       
       NSLog(@"Array: %@", temp2);
       NSLog(@"BTCUSD: %@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[self.coindb valueForKey:@"coinname"]][@"ImageUrl"]);
       
       _coinImageString = [NSString stringWithFormat:@"%@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[self.coindb valueForKey:@"coinname"]][@"ImageUrl"]];
       
       
       NSLog(@"Image String: %@", _coinImageString);
       
       //  cell.imageView.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
       
       _coinImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
       
    */
     //  NSLog(@"Radio Button in AddTransaction: %@", button.titleLabel.text);
       
       NSString *tempURL = [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/price?fsym=%@&tsyms=USD", [self.coindb valueForKey:@"coinname"]];
       
       NSURL *url2 = [NSURL URLWithString:tempURL];
       
       NSError* error2 = nil;
       NSString* text2 = [NSString stringWithContentsOfURL:url2 encoding:NSASCIIStringEncoding error:&error2];
       NSData *myData2 = [text2 dataUsingEncoding:NSUTF8StringEncoding];
       NSDictionary *BTCUSD2 = [NSJSONSerialization JSONObjectWithData:myData2
                                                              options:NSJSONReadingAllowFragments
                                                                error:&error2];
       
       
       NSLog(@"BTCUSD2: %@", BTCUSD2);
       
    NSArray *temp3 = [BTCUSD2 allValues] ;
   NSLog(@"temp3: %@", temp3[0]);
    self.currentPrice.text =[NSString stringWithFormat:@"$%@", temp3[0]];
       
       

       
       
 }
    if (_addtransdb)
    {
         self.navigationItem.title = @"Add Transaction";
         NSLog(@"Coin passed: %@",[self.addtransdb valueForKey:@"coinname"]);
        self.company.userInteractionEnabled = NO;
        // [self.company setText:[self.coindb valueForKey:@"symbol"]];
        self.company.text = [self.addtransdb valueForKey:@"coinname"];
      
        
        //add in transaction db
   //          [self.qty setText:[self.addtransdb valueForKey:@"qty"]];
   //   [self.tradePrice setText:[self.addtransdb valueForKey:@"tradeprice"]];
   //     [self.totalValue setText:[self.addtransdb valueForKey:@"totalvalue"]];
        
        NSString *urlReceived = [NSString stringWithFormat:@"https://www.cryptocompare.com/api/data/coinlist/"];
        
        NSURL *url = [NSURL URLWithString:urlReceived];
        
        NSError* error = nil;
        NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
        NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *BTCUSD = [NSJSONSerialization JSONObjectWithData:myData
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
        
        
        NSLog(@"BTCUSD: %@",[BTCUSD allKeys]);
        
        NSArray *temp2 = [BTCUSD valueForKey:@"Data"][[self.addtransdb valueForKey:@"coinname"] ];
        
        
        NSLog(@"Array: %@", temp2);
        NSLog(@"BTCUSD: %@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[self.addtransdb valueForKey:@"coinname"]][@"ImageUrl"]);
        
        _coinImageString = [NSString stringWithFormat:@"%@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[self.addtransdb valueForKey:@"coinname"]][@"ImageUrl"]];
        
        
        NSLog(@"Image String: %@", _coinImageString);
        
        //  cell.imageView.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
        
        _coinImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
     
        NSString *tempURL = [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/price?fsym=%@&tsyms=USD", [self.addtransdb valueForKey:@"coinname"]];
        
        NSURL *url2 = [NSURL URLWithString:tempURL];
        
        NSError* error2 = nil;
        NSString* text2 = [NSString stringWithContentsOfURL:url2 encoding:NSASCIIStringEncoding error:&error2];
        NSData *myData2 = [text2 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *BTCUSD2 = [NSJSONSerialization JSONObjectWithData:myData2
                                                                options:NSJSONReadingAllowFragments
                                                                  error:&error2];
        
        
        NSLog(@"BTCUSD2: %@", BTCUSD2);
        
        NSArray *temp3 = [BTCUSD2 allValues] ;
       NSLog(@"temp3: %@", temp3[0]);
     self.currentPrice.text =[NSString stringWithFormat:@"$%@", temp3[0]];
        
    }
  //else{

    //  self.company.userInteractionEnabled = NO;
  //     self.company.text = [self.coindb valueForKey:@"coinname"];
  //  }
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
   //  self.navigationItem.rightBarButtonItem = self.editButtonItem;
      [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}
-(void)viewWillAppear:(BOOL)animated{
  //  [SVProgressHUD show];
    
}
- (IBAction)btnSave:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
      [SVProgressHUD show];
    if (self.coindb) {
        // Update existing device
        
        [self.coindb setValue:self.company.text forKey:@"coinname"];
    //  [self.coindb setValue:self.qty.text forKey:@"qty"];
     //   self.qty.text = @"-1";
        
        float totCost =[self.totalValue.text floatValue];
           float holding = [self.qty.text floatValue];
        if ([self.currency isEqualToString:@"Sell"]) {
           // holding = -(holding);
           // totCost = -(totCost);
            
            // Now do number check.
            if (holding > 0)
            {
                holding = (0 - holding);
                    [self.coindb setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
            }
            else if (holding < 0)
            {
                // Since number is negative, lets try to
                // minus minus the number and make it positive.
               // holding = (0 - holding);
                    [self.coindb setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
            }
            NSLog(@"HOLDING: %f", holding);
            if (totCost > 0)
            {
                totCost = (0 - totCost);
            }
            else if (totCost < 0)
            {
                // Since number is negative, lets try to
                // minus minus the number and make it positive.
              // totCost = (0 - totCost);
            }
            
            
            NSDate *startDate = datePicker2.date;
            NSDate *endDate = datePicker.date;
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSUInteger unitFlags = NSCalendarUnitMonth |NSCalendarUnitDay;
            
            NSDateComponents *components = [gregorian components:unitFlags fromDate:startDate  toDate:endDate options:0];
            //  NSInteger months = [components month];
            NSInteger days = [components day];
            NSLog(@"DAYS: %ld", (long)days);
            
            if (days >365) {
                [coindb setValue:@"Long Term" forKey:@"taxtype"];
            }else
                [coindb setValue:@"Short Term" forKey:@"taxtype"];
            
        }
         if ([self.currency isEqualToString:@"Buy"]) {
            [coindb setValue:@"Unrealized" forKey:@"taxtype"];
        }
       
      [self.coindb setValue:[NSNumber numberWithFloat:totCost] forKey:@"totalvalue"];
        
   //  [self.coindb setValue:self.totalValue.text forKey:@"totalvalue"];
        
             [self.coindb setValue:self.tradePrice.text forKey:@"tradeprice"];
        
      //  float BTC = [[self.coindb valueForKey:@"qty"] floatValue];
      //  float tradeprice = [[self.coindb  valueForKey:@"tradeprice"] floatValue];
      //  float totalvalue = BTC * tradeprice;
        
     //   self.totalValue.text = [NSString stringWithFormat:@"%.2f", totalvalue];
        
     
           [self.coindb setValue:self.fee.text forKey:@"fee"];
           [self.coindb setValue:self.currency forKey:@"currency"];
        [self.coindb setValue:datePicker.date forKey:@"tradedate"];
      [self.coindb setValue:datePicker2.date forKey:@"receivedate"];
   //   [self.coindb setValue:self.taxType forKey:@"taxtype"];
        
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"Coin Transaction Updated!!");
              [SVProgressHUD dismiss];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (_newcoindb) {
        
        NSLog(@"Create a new device newdcoindb: Coin:%@",companyName);
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
       //    NSManagedObject *Device = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
        
        [newDevice setValue:self.company.text forKey:@"coinname"];
       // [Device setValue:self.company.text forKey:@"coinname"];
        
        
        //    [newDevice setValue:self.qty.text forKey:@"qty"];
   
 
        
        
        float totCost =[self.totalValue.text floatValue];
        float holding = [self.qty.text floatValue];
        if ([self.currency isEqualToString:@"Sell"]) {
            // Now do number check.
            if (holding > 0)
            {
                holding = (0 - holding);
            }
            else if (holding < 0)
            {
                // Since number is negative, lets try to
                // minus minus the number and make it positive.
                holding = (0 - holding);
            }
            
            if (totCost > 0)
            {
                totCost = (0 - totCost);
            }
            else if (totCost < 0)
            {
                // Since number is negative, lets try to
                // minus minus the number and make it positive.
                totCost = (0 - totCost);
            }
            
            NSDate *startDate = datePicker2.date;
            NSDate *endDate = datePicker.date;
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSUInteger unitFlags = NSCalendarUnitMonth |NSCalendarUnitDay;
            
            NSDateComponents *components = [gregorian components:unitFlags fromDate:startDate  toDate:endDate options:0];
            //  NSInteger months = [components month];
            NSInteger days = [components day];
            
          
            
            if (days >365) {
                  self.taxType.text = @"Long Term";
                [newDevice setValue:self.taxType forKey:@"taxtype"];
            }else
                
                self.taxType.text = @"Short Term";
            
                [newDevice setValue:self.taxType forKey:@"taxtype"];
            
        }
        if ([self.currency isEqualToString:@"Buy"]) {
        
            [newDevice setValue:@"Unrealized" forKey:@"taxtype"];
        }
        
        
        [newDevice setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
        [newDevice setValue:[NSNumber numberWithFloat:totCost] forKey:@"totalvalue"];
    
        
        
             [newDevice setValue:self.tradePrice.text forKey:@"tradeprice"];
        
        
     //   [newDevice setValue:self.totalValue.text forKey:@"totalvalue"];
         [newDevice setValue:self.fee.text forKey:@"fee"];
           [newDevice setValue:self.currency forKey:@"currency"];
          [newDevice setValue:datePicker.date forKey:@"tradedate"];
        [newDevice setValue:datePicker2.date forKey:@"receivedate"];
         [newDevice setValue:self.taxType forKey:@"taxtype"];
        
        NSData *imageData = UIImagePNGRepresentation(_coinImage.image);
        
        [newDevice setValue:imageData forKey:@"image"];
      //  [Device setValue:imageData forKey:@"image"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"New Coin Transaction newcoindb Saved!!");
              [SVProgressHUD dismiss];
        }
 
    //   [self dismissViewControllerAnimated:NO completion:nil];
        [self performSegueWithIdentifier:@"backHome"
                                  sender:nil];

    }
    if (_addtransdb)
    {
        
        NSLog(@"Create a new device addtransdb: Coin:%@",companyName);
       NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
        
      //  NSManagedObject *Device = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
        
        [newDevice setValue:self.company.text forKey:@"coinname"];
      [newDevice setValue:self.company.text forKey:@"coinname"];
        
        float totCost =[self.totalValue.text floatValue];
        float holding = [self.qty.text floatValue];
        if ([self.currency isEqualToString:@"Sell"]) {
            // Now do number check.
            if (holding > 0)
            {
                holding = (0 - holding);
                  [newDevice setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
            }
            else if (holding < 0)
            {
                // Since number is negative, lets try to
                // minus minus the number and make it positive.
                holding = (0 - holding);
                  [newDevice setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
            }
            
            if (totCost > 0)
            {
                totCost = (0 - totCost);
            }
            else if (totCost < 0)
            {
                // Since number is negative, lets try to
                // minus minus the number and make it positive.
                totCost = (0 - totCost);
            }
            
            NSDate *startDate = datePicker2.date;
            NSDate *endDate = datePicker.date;
            
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSUInteger unitFlags = NSCalendarUnitMonth |NSCalendarUnitDay;
            
            NSDateComponents *components = [gregorian components:unitFlags fromDate:startDate  toDate:endDate options:0];
          //  NSInteger months = [components month];
            NSInteger days = [components day];
            
            if (days >365) {
                [newDevice setValue:@"Long Term" forKey:@"taxtype"];
            }else
                [newDevice setValue:@"Short Term" forKey:@"taxtype"];
            
        }
        if ([self.currency isEqualToString:@"Buy"]) {
        
            [newDevice setValue:@"Unrealized" forKey:@"taxtype"];
        }
        
      
        [newDevice setValue:[NSNumber numberWithFloat:totCost] forKey:@"totalvalue"];
        
        
       // [newDevice setValue:self.totalValue.text forKey:@"totalvalue"];
           [newDevice setValue:self.fee.text forKey:@"fee"];
           [newDevice setValue:self.currency forKey:@"currency"];
       
        
           [newDevice setValue:datePicker.date forKey:@"tradedate"];
        [newDevice setValue:datePicker2.date forKey:@"receivedate"];
       
        NSData *imageData = UIImagePNGRepresentation(_coinImage.image);
        
        [newDevice setValue:imageData forKey:@"image"];
      //  [Device setValue:imageData forKey:@"image"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"New Coin Transaction addtransdb Saved!!");
              [SVProgressHUD dismiss];
        }
        
           [self dismissViewControllerAnimated:NO completion:nil];
       // [self performSegueWithIdentifier:@"backHome"sender:nil];
        
    }
}


- (IBAction)btnBack:(id)sender {
    NSLog(@"Cancel pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    switch(section)
    {
        case 0:  return 3;  // section 0 has 2 rows
            
           
        case 1: {
            if ([self.currency isEqualToString:@"Sell"]) {
                NSLog(@"Currency = %@", self.currency);
                return 7;
            }else
            return 5;}
            
        case 2:  return 2;
            // section 1 has 1 row
        default: return 0;
    };
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // cell = [tableView dequeueReusableCellWithIdentifier:@"RadioButtonCell" forIndexPath:indexPath];

    if (indexPath.row == 0) {
        NSLog(@"Index 0");
    static NSString *CellIdentifier =@"RadioButtonCell";
    RadioButtonCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
  //  cell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
 //   if (cell == nil) {
   //    cell = [[RadioButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RadioButtonCell"];
        //  cell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
 //   }

        // cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        // programmatically add button
        // first button
      CGRect frame = CGRectMake(10, 0, 120, 44);
        
        DLRadioButton *firstRadioButton = [self createRadioButtonWithFrame:frame
                                                                     Title:@"Buy"
                                                                     Color:[UIColor blackColor]];
        
        // other buttons
        NSArray *colorNames = @[@"Sell", @"Watch"];
        NSArray *colors = @[[UIColor blackColor], [UIColor blackColor]];
        NSInteger i = 0;
        NSMutableArray *otherButtons = [NSMutableArray new];
        for (UIColor *color in colors) {
            CGRect frame = CGRectMake(120 * i+ 120, 0, 120, 44);
            DLRadioButton *radioButton = [self createRadioButtonWithFrame:frame
                                                                    Title:colorNames[i]
                                                                    Color:color];
            // put icon on the right side
            //  radioButton.iconOnRight = YES;
            //  radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            
            [otherButtons addObject:radioButton];
            i++;
        }
        
        firstRadioButton.otherButtons = otherButtons;
        
        // Configure the view for the selected state
 
      //  cell.textLabel.text = @"Rob";
        return cell;
     //  cell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    }
 

    
    return cell;
}
*/
// Return the row for the corresponding section and row
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       // RadioButtonCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    

    
    
    switch(indexPath.section)
    {
        case 0:
            switch(indexPath.row)
        {
            case 2:
            {
                
                
                return self.radioButtonCell;
         
        }
        }

}
        return nil;
}
*/

#pragma mark - Helper

- (DLRadioButton *)createRadioButtonWithFrame:(CGRect) frame Title:(NSString *)title Color:(UIColor *)color
{
    RadioButtonCell *cell;
    cell = [[RadioButtonCell alloc] init];
    
    DLRadioButton *radioButton = [[DLRadioButton alloc] initWithFrame:frame];
    radioButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [radioButton setTitle:title forState:UIControlStateNormal];
    [radioButton setTitleColor:color forState:UIControlStateNormal];
    radioButton.iconColor = color;
    radioButton.indicatorColor = color;
    radioButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioButton addTarget:self action:@selector(logSelectedButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.radioView addSubview:radioButton];

    
    return radioButton;
}


- (IBAction)logSelectedButton:(DLRadioButton *)radioButton {
    if (radioButton.isMultipleSelectionEnabled) {
        for (DLRadioButton *button in radioButton.selectedButtons) {
            NSLog(@"%@ is selected.\n", button.titleLabel.text);
            self.currency = button.titleLabel.text;
           // self.qty.text = @"0";
               [self.tableView reloadData];
        }
    } else {
        NSLog(@"%@ is selected.\n", radioButton.selectedButton.titleLabel.text);
        self.currency = radioButton.selectedButton.titleLabel.text;
        // self.qty.text = @"0";
        [self.tableView reloadData];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

   // if (range.location == 0 && string.length == 0)
        

        
    NSLog(@"Length of text fields: %lu, %lu, %lu", self.fee.text.length,self.tradePrice.text.length , self.qty.text.length);
    
    
    
      float BTC = [self.qty.text floatValue];
    float tradeprice = [self.tradePrice.text floatValue];
    float fee = [self.fee.text floatValue];
    
    float totalvalue = (BTC * tradeprice)+fee;
    
      self.totalValue.text = [NSString stringWithFormat:@"%.2f", totalvalue];
    
    NSLog(@"textField:shouldChangeCharactersInRange:replacementString:%f", totalvalue);
    
 
    //
    
  //  if ([string isEqualToString:@"#"]) {
  //      return NO;
  //  }
  //  else {
        return YES;
  //  }
}
- (BOOL)isQtyEmpty
{
    BOOL emptyQty = self.qty.text.length == 0;
    self.qty.backgroundColor = emptyQty ? [UIColor redColor] : [UIColor whiteColor];
    return emptyQty;
}

- (BOOL)isTradePriceEmpty
{
    BOOL emptyTradePrice = self.tradePrice.text.length == 0;
    self.tradePrice.backgroundColor = emptyTradePrice ? [UIColor redColor] : [UIColor whiteColor];
    return emptyTradePrice;
}
- (BOOL)isFeeEmpty
{
    BOOL emptyFee = self.fee.text.length == 0;
    self.fee.backgroundColor = emptyFee ? [UIColor redColor] : [UIColor whiteColor];
    return emptyFee;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    float BTC = [self.qty.text floatValue];
    float tradeprice = [self.tradePrice.text floatValue];
    float fee = [self.fee.text floatValue];
    
    float totalvalue = (BTC * tradeprice)+fee;
    
    self.totalValue.text = [NSString stringWithFormat:@"%.2f", totalvalue];
    
    NSLog(@"textField:shouldChangeCharactersInRange:replacementString:%f", totalvalue);
 

 
}
-(void)yourTextViewDoneButtonPressed
{
    [self.tradePrice resignFirstResponder];
      [self.fee resignFirstResponder];
      [self.qty resignFirstResponder];
    
    float BTC = [self.qty.text floatValue];
    float tradeprice = [self.tradePrice.text floatValue];
    float fee = [self.fee.text floatValue];
    float totalvalue;
   
    
    if ([self.currency isEqualToString:@"Sell"]) {
      totalvalue = [self.totalCostBasis.text floatValue];
    }
    else{
       totalvalue = (BTC * tradeprice)+fee;
        
        
        }
    
    
    
    
    
    
    
    
    self.totalValue.text = [NSString stringWithFormat:@"%.2f", totalvalue];
    
    NSLog(@"textField:shouldChangeCharactersInRange:replacementString:%f", totalvalue);
}

-(void)ShowSelectedDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM DD, YYYY"];
    self.dateSelectionTextField.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker.date]];
    
    [self.dateSelectionTextField resignFirstResponder];
}

-(void)ShowSelectedDate2
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM DD, YYYY"];
    self.dateSelectionTextField2.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:datePicker2.date]];
    
    [self.dateSelectionTextField2 resignFirstResponder];
}
/*
  
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
