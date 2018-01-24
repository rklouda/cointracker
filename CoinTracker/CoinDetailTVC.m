//
//  CoinDetailTVC.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/15/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "CoinDetailTVC.h"
#import "CoinHeaderTableViewCell.h"
#import "addCoinTCV.h"
#import "AddTransactionTVC.h"
#import "MainCustomTVCell.h"

@interface CoinDetailTVC ()

@end

@implementation CoinDetailTVC

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
    
    NSString *urlReceived = [NSString stringWithFormat:@"https://www.cryptocompare.com/api/data/coinlist/"];
    
    NSURL *url = [NSURL URLWithString:urlReceived];
    
    NSError* error = nil;
    NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *BTCUSD = [NSJSONSerialization JSONObjectWithData:myData
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    

    NSLog(@"BTCUSD: %@",[BTCUSD allKeys]);
    
    NSArray *temp2 = [BTCUSD valueForKey:@"Data"][_coin];
   
 NSLog(@"Array: %@", temp2);
     NSLog(@"BTCUSD: %@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][_coin][@"ImageUrl"]);
    
    _coinImageString = [NSString stringWithFormat:@"%@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][_coin][@"ImageUrl"]];
    
    
    NSString *tempURL = [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/price?fsym=%@&tsyms=USD",  [self.coindb valueForKey:@"coinname"]];
    
    NSURL *url2 = [NSURL URLWithString:tempURL];
    
    NSError* error2 = nil;
    NSString* text2 = [NSString stringWithContentsOfURL:url2 encoding:NSASCIIStringEncoding error:&error2];
    NSData *myData2 = [text2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *BTCUSD2 = [NSJSONSerialization JSONObjectWithData:myData2
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
    
    
    NSLog(@"BTCUSD2: %@", BTCUSD2);
    
    temp3 = [BTCUSD2 allValues] ;
    NSLog(@"temp3: %@", temp3[0]);
    
 
    
    
    
   //   [self.navigationItem setTitle:_coin];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch/Search the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    NSLog(@"Coindb viewdidappear: %@", [self.coindb valueForKey:@"coinname"]);
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"coinname == %@",[self.coindb valueForKey:@"coinname"]]];
    

    
    
    self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"CompanyArray CDTVC : %@", self.companyarray);
   

    

    
    [self.tableView reloadData];
    
    
    /*
    // Fetch ALL the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Coin"];
    self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
      return self.companyarray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 120.0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. Dequeue the custom header cell
    CoinHeaderTableViewCell* headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    
    // 2. Set the various properties
    headerCell.coinName.text =  [self.coindb valueForKey:@"coinname"];
    
    
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
    
    headerCell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
    
    
//headerCell.image.image = [UIImage imageWithData:[self.coindb valueForKey:@"image"]];
    
  //  [headerCell.title sizeToFit];
    
   //  headerCell.image.image = [UIImage imageWithData:[self.companyarray valueForKey:@"image"]];
    
//    headerCell.subtitle.text = @"$200.00";
  //  [headerCell.subtitle sizeToFit];
 //   [headerCell.subtitle setTextAlignment:NSTextAlignmentRight];
    
    //*totalHoldings, *totalValue, *totalNetCost, *totalGain, *currentPrice;
    
    NSNumber *totHoldings= [self.companyarray valueForKeyPath:@"@sum.qty"];
     NSNumber *totCost= [self.companyarray valueForKeyPath:@"@sum.totalvalue"]; //totalvalue at purchase time
  //   NSNumber *totfee= [self.companyarray valueForKeyPath:@"@sum.fee"];
    
    
    float totValue = ([totHoldings floatValue] * [temp3[0] floatValue]);
   
    float totGain = totValue - [totCost floatValue];
    float totPercentGain = (totValue - [totCost floatValue])/[totCost floatValue] *100;
    
    
    NSLog(@"SUM: %@", totHoldings);

    headerCell.totalHoldings.text = [NSString stringWithFormat:@"%@", totHoldings];
    headerCell.totalNetCost.text = [NSString stringWithFormat:@"%@", totCost];
 
    headerCell.totalValue.text =[NSString stringWithFormat:@"$%.2f", totValue];

    
    headerCell.currentPrice.text = [NSString stringWithFormat:@"$%@", temp3[0]];
    
    if (totGain >= 0) {
    headerCell.percentGain.textColor = [UIColor blackColor];
    headerCell.totalGain.textColor = [UIColor blackColor];
    }else
    {
        headerCell.percentGain.textColor = [UIColor redColor];
        headerCell.totalGain.textColor = [UIColor redColor];
    }
    
    headerCell.percentGain.text = [NSString stringWithFormat:@"%.2f%%", totPercentGain];
    headerCell.totalGain.text = [NSString stringWithFormat:@"$%.2f", totGain];
    
  //  NSManagedObject *device = _coindb;
    
    
   // headerCell.image.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
    
   //  headerCell.image.image = [UIImage imageWithData:[self.companyarray valueForKey:@"image"]];

    
    // 3. And return
    return headerCell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    MainCustomTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //  switch (indexPath.section) {
    //      case 0:{
    
    
    // Configure the cell...
    //  cell.textLabel.text = [NSString stringWithFormat:@"BTC = $%@",[coinArray valueForKey:@"BTC"][@"USD"]];
    
    //   _coin = [[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
    //   cell.textLabel.text =[[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
    //cell.coinLabel.text =[[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
    
    NSManagedObject *device = [self.companyarray objectAtIndex:indexPath.row];
    
 //   [cell.coinLabel setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"coinname"]]];
    
    [cell.type setText:[device valueForKey:@"currency"]];
    
    float qty = [[device valueForKey:@"qty"] floatValue];
    
    if ([cell.type.text isEqualToString:@"Sell"]) {
        cell.qty.textColor = [UIColor redColor];
  
    } else
    {
        cell.qty.textColor = [UIColor blackColor];
        
    }
    
    [cell.qty setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"qty"]]];

     [cell.tradePrice setText:[NSString stringWithFormat:@"$%@",[device valueForKey:@"tradeprice"]]];
     [cell.currentPrice setText:[NSString stringWithFormat:@"$%@",temp3[0]]];
    [cell.totalValue setText:[NSString stringWithFormat:@"$%@", [device valueForKey:@"totalvalue"]]];
   // float fee = [[device valueForKey:@"fee"] floatValue];

    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/YY"];
    cell.tradeDate.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:[device valueForKey:@"tradedate"]]];
    
   

    float BTCtradeprice =[[device valueForKey:@"tradeprice"] floatValue];
    float BTCcost = (BTCtradeprice*qty);
    
    float BTCcurrentPrice = [temp3[0] floatValue];
    float profit =(qty*BTCcurrentPrice) - BTCcost;
    
    float BTCgain = (profit/BTCcost)*100;
    NSLog(@"Trade Cost: %.2f profit: %.2f Qty: %.2f", BTCcost, profit, BTCcurrentPrice);
    
 //   cell.totalCost.text = [NSString stringWithFormat:@"%.2f", BTCcost ];
    cell.gain.text = [NSString stringWithFormat:@"$%.2f",profit ];
    cell.gainpercent.text = [NSString stringWithFormat:@"%.2f%%", BTCgain ];
    
 //   cell.image.image = [UIImage imageWithData:[device valueForKey:@"image"]];
    
 return cell;
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

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.companyarray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.companyarray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editTransaction"]) {
        NSLog(@"Edit Transaction pass device");
        NSManagedObject *selectedDevice = [self.companyarray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        
      //  AddTransactionTVC *destViewController = segue.destinationViewController;
      //  destViewController.coindb = selectedDevice;
        
        UINavigationController *nav = [segue destinationViewController];
       
        AddTransactionTVC *destViewController = (AddTransactionTVC *)nav.topViewController;
        destViewController.coindb = selectedDevice;
        
     //   destViewController.navigationController.title = @"Edit Transaction";
        
    } //add transaction
   if ([[segue identifier] isEqualToString:@"addTransaction"]) {
       
       NSManagedObject *selectedDevice = self.coindb;
       
       UINavigationController *nav = [segue destinationViewController];
       
       NSLog(@"Coin to pass from CDTVC: %@", [self.coindb valueForKey:@"coinname"]);
       
       AddTransactionTVC *destViewController = (AddTransactionTVC *)nav.topViewController;
       destViewController.addtransdb = selectedDevice;
    // destViewController.navigationController.title = @"Add Transaction";
       
       //  AddTransactionTVC *destViewController = segue.destinationViewController;
    }
    

#pragma mark - Navigation
/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 if ([[segue identifier] isEqualToString:@"addTransaction"]) {
 
// NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
 AddTransactionTVC *destinationViewController = (AddTransactionTVC *)segue.destinationViewController;
 
     NSLog(@"Coin to pass: %@", _coin);
    destinationViewController.companyName = _coin;
     
 
 }
 */
 }

@end
