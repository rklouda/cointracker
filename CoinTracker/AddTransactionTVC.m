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
    
 //TextField Delegates
   self.qty.delegate = self;
self.tradePrice.delegate = self;
    self.fee.delegate = self;
 
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
   // self.qty = [self.newcoindb valueForKey:@"qty"];
       float help;
       help  =[[self.coindb valueForKey:@"qty"] floatValue];
      
       NSString *qtytext = [NSString stringWithFormat:@"%.2f", help];
       [self.qty setText:qtytext];
       
       
       
         [self.tradePrice setText:[self.coindb valueForKey:@"tradeprice"]];
       [self.totalValue setText:[self.coindb valueForKey:@"totalvalue"]];
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

- (IBAction)btnSave:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.coindb) {
        // Update existing device
        
        [self.coindb setValue:self.company.text forKey:@"coinname"];
       //  [self.coindb setValue:self.qty.text forKey:@"qty"];
     //   self.qty.text = @"-1";
        
        
        float holding = [self.qty.text floatValue];
        if ([self.currency isEqualToString:@"Sell"]) {
            holding = holding *-1;
        }
     [self.coindb setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
        
        
        
             [self.coindb setValue:self.tradePrice.text forKey:@"tradeprice"];
        
      //  float BTC = [[self.coindb valueForKey:@"qty"] floatValue];
      //  float tradeprice = [[self.coindb  valueForKey:@"tradeprice"] floatValue];
      //  float totalvalue = BTC * tradeprice;
        
     //   self.totalValue.text = [NSString stringWithFormat:@"%.2f", totalvalue];
        
        [self.coindb setValue:self.totalValue.text forKey:@"totalvalue"];
           [self.coindb setValue:self.fee.text forKey:@"fee"];
           [self.coindb setValue:self.currency forKey:@"currency"];
        [self.coindb setValue:datePicker.date forKey:@"tradedate"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"Coin Transaction Updated!!");
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (_newcoindb) {
        
        NSLog(@"Create a new device newdcoindb: Coin:%@",companyName);
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction" inManagedObjectContext:context];
       //    NSManagedObject *Device = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
        
        [newDevice setValue:self.company.text forKey:@"coinname"];
       // [Device setValue:self.company.text forKey:@"coinname"];
        
      //  [newDevice setValue:self.qty.text forKey:@"qty"];
        float holding = [self.qty.text floatValue];
        if ([self.currency isEqualToString:@"Sell"]) {
            holding = holding *-1;
        }
       [newDevice setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
        
        
        
             [newDevice setValue:self.tradePrice.text forKey:@"tradeprice"];
        
        
        [newDevice setValue:self.totalValue.text forKey:@"totalvalue"];
         [newDevice setValue:self.fee.text forKey:@"fee"];
           [newDevice setValue:self.currency forKey:@"currency"];
          [newDevice setValue:datePicker.date forKey:@"tradedate"];
        
        NSData *imageData = UIImagePNGRepresentation(_coinImage.image);
        
        [newDevice setValue:imageData forKey:@"image"];
      //  [Device setValue:imageData forKey:@"image"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"New Coin Transaction newcoindb Saved!!");
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
      //  [Device setValue:self.company.text forKey:@"coinname"];
        
        float holding = [self.qty.text floatValue];
        if ([self.currency isEqualToString:@"Sell"]) {
            holding = holding *-1;
        }
        [newDevice setValue:[NSNumber numberWithFloat:holding] forKey:@"qty"];
      
         
           // [newDevice setValue:self.qty.text forKey:@"qty"];
        
          [newDevice setValue:self.tradePrice.text forKey:@"tradeprice"];
        
        
        [newDevice setValue:self.totalValue.text forKey:@"totalvalue"];
           [newDevice setValue:self.fee.text forKey:@"fee"];
           [newDevice setValue:self.currency forKey:@"currency"];
        
        
        
           [newDevice setValue:datePicker.date forKey:@"tradedate"];
        
        NSData *imageData = UIImagePNGRepresentation(_coinImage.image);
        
        [newDevice setValue:imageData forKey:@"image"];
      //  [Device setValue:imageData forKey:@"image"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"New Coin Transaction addtransdb Saved!!");
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
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    switch(section)
    {
        case 0:  return 3;  // section 0 has 2 rows
        case 1:  return 5;
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
            self.qty.text = @"0";
        }
    } else {
        NSLog(@"%@ is selected.\n", radioButton.selectedButton.titleLabel.text);
        self.currency = radioButton.selectedButton.titleLabel.text;
         self.qty.text = @"0";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSLog(@"Length of text fields: %lu, %lu, %lu", self.fee.text.length,self.tradePrice.text.length , self.qty.text.length);
    
    if (self.fee.text.length >0 && self.tradePrice.text.length >0 && self.qty.text.length >0)
    {
        self.btnSave.enabled = YES;
    }
    else
    {
        self.btnSave.enabled = NO;
    }
    
    
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
    
    float totalvalue = (BTC * tradeprice)+fee;
    
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
