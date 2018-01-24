//
//  CoinsTVC.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/14/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "CoinsTVC.h"
#import "addCoinTCV.h"
#import "CoinDetailTVC.h"
#import "MainHeaderTableViewCell.h"
#import "MainCustomTVCell.h"
#import <CoreData/CoreData.h>
#import "CoinHeaderTableViewCell.h"

@interface CoinsTVC ()

@end

@implementation CoinsTVC

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
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    totalMarket = 0.0;
    totalGainRK = 0.0;
    totalCostRK = 0.0;
         _companyarray = [[NSMutableArray alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 //   self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
 //   addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
 //   self.navigationItem.rightBarButtonItem = addButton;
    
    
    
 
    
    
/*
    NSString *valueToSave = @"https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,LTC,BCH,ETH&tsyms=USD&e=Coinbase&extraParams=robsapp";
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"coinURLString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"coinURLString"];

    [self getTheCoins:savedValue];
*/
    /*
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    
 //   fetchRequest.propertiesToGroupBy = @[[self.companyarray valueForKey:@"coinname"]];
    
//    self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Transaction"
                                              inManagedObjectContext:managedObjectContext];
    
    NSAttributeDescription* statusDesc = [entity.attributesByName objectForKey:@"coinname"];
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath: @"coinname"]; // Does not really matter
    NSExpression *countExpression = [NSExpression expressionForFunction: @"count:"
                                                              arguments: [NSArray arrayWithObject:keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName: @"count"];
    [expressionDescription setExpression: countExpression];
    [expressionDescription setExpressionResultType: NSInteger32AttributeType];
    
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:statusDesc, expressionDescription, nil]];
    [fetchRequest setPropertiesToGroupBy:[NSArray arrayWithObject:statusDesc]];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSError* error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest
                                                           error:&error];
    
    NSLog(@"RESULT: %@", results);
    */
  //  self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    /*
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];
    [fetchRequest2 setPredicate:[NSPredicate predicateWithFormat:@"coinname == %@",[results valueForKey:@"coinname"]]];
    

    self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest2 error:nil] mutableCopy];
    
    NSLog(@"CompanyName: %@", self.companyarray);
    */
    
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor blueColor];
   
  self.refreshControl.tintColor = [UIColor whiteColor];
  [self.refreshControl addTarget:self
                          action:@selector(preGetTheCoins)
                forControlEvents:UIControlEventValueChanged];
    

  //  [self calculateGains];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     totalMarket = 0.0;
        totalGainRK = 0.0;
      totalCostRK = 0.0;
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];


  // fetchRequest.propertiesToGroupBy = @[[self.companyarray valueForKey:@"coinname"]];
    
//   self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    

    NSEntityDescription* entity = [NSEntityDescription entityForName:@"Transaction"
                                              inManagedObjectContext:managedObjectContext];
    
    NSAttributeDescription* statusDesc = [entity.attributesByName objectForKey:@"coinname"];
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath: @"coinname"];

    NSExpression *countExpression = [NSExpression expressionForFunction: @"count:"
                                                              arguments: [NSArray arrayWithObject:keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName: @"count"];
    [expressionDescription setExpression: countExpression];
    [expressionDescription setExpressionResultType: NSInteger32AttributeType];
    
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:statusDesc, expressionDescription, nil]];
    [fetchRequest setPropertiesToGroupBy:[NSArray arrayWithObject:statusDesc]];
    [fetchRequest setResultType:NSDictionaryResultType];
    NSError* error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest
                                                           error:&error];
    
    NSLog(@"RESULT: %@", results);
    
    self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    

    
    
    
    // Fetch the devices from persistent data store
//    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];

  //  fetchRequest.propertiesToGroupBy = @[[self.companyarray valueForKey:@"coinname"]];
 
    
 //   self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
   // fetchRequest.returnsDistinctResults = YES;
 //   NSLog(@"CompanyName: %@", [self.coindb valueForKey:@"coinname"]);
    
 //   [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"coinname == %@",[self.coindb valueForKey:@"coinname"]]];
    
    
    
    
 //   self.companyarray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
 //   NSLog(@"CompanyName: %@", self.companyarray);
 
    [self.tableView reloadData];
    NSLog(@"Company Array for prices:%@", self.companyarray);
    

    
    
 
}


-(void)preGetTheCoins{
    totalMarket = 0.0;
    totalGainRK = 0.0;
    totalCostRK = 0.0;
   [self.tableView reloadData];
  //  NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"coinURLString"];
    
  //  [self getTheCoins:savedValue];
    [self.refreshControl endRefreshing];
    
    
}
-(void)calculateGains{
    float BTC = 0.04200088;
    float BTCprice = 11909.00;
    float BTCfee = 7.34;
    float BTCcost = BTCfee + (BTCprice * BTC);
    float BTCValue;
    
    NSURL *url = [NSURL URLWithString:@"https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD"];
    
    NSError* error = nil;
    NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *BTCUSD = [NSJSONSerialization JSONObjectWithData:myData
                                    options:NSJSONReadingAllowFragments
                                             error:&error];
   
    
    NSLog(@"BTCUSD: %@", BTCUSD);
    
        NSArray *temp2 = [BTCUSD allValues] ;
        BTCValue =[temp2[0] floatValue]*BTC;
        
        NSLog(@"BTC Value: %f", [temp2[0] floatValue]*BTC);
        NSLog(@"BTC Cost: %f", BTCcost);
        
  
       float BTCgain = (((BTCValue)-BTCcost)/BTCcost)*100;
        
        NSLog(@"BTC Gain: %2f ", BTCgain);

    
    float ETH = 1.01990878;
    float ETHprice = 483.78;
    float ETHfee = 7.34;
    float ETHcost = ETHfee + (ETHprice * ETH);
    float ETHValue;
    
    NSURL *urlETH = [NSURL URLWithString:@"https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"];
    
  //  NSError* error = nil;
    NSString* textETH = [NSString stringWithContentsOfURL:urlETH encoding:NSASCIIStringEncoding error:&error];
    NSData *myDataETH = [textETH dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *ETHUSD = [NSJSONSerialization JSONObjectWithData:myDataETH
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
 
        NSArray *temp2ETH = [ETHUSD allValues] ;
        ETHValue =[temp2ETH[0] floatValue]*ETH;
        
        NSLog(@"ETH Value: %f2", [temp2ETH[0] floatValue]*ETH);
        NSLog(@"ETH Cost: %f2", ETHcost);
        
        
        float ETHgain = (((ETHValue)-ETHcost)/ETHcost)*100;
        
        NSLog(@"ETH Gain: %f2 ", ETHgain);
  
    
    float ETH2 = 0.53283003;
    float ETH2price = 924.61;
    float ETH2fee = 7.34;
    float ETH2cost = ETH2fee + (ETH2price * ETH2);
    float ETH2Value;
    
    NSURL *urlETH2 = [NSURL URLWithString:@"https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD"];
    
    //  NSError* error = nil;
    NSString* textETH2 = [NSString stringWithContentsOfURL:urlETH2 encoding:NSASCIIStringEncoding error:&error];
    NSData *myDataETH2 = [textETH2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *ETH2USD = [NSJSONSerialization JSONObjectWithData:myDataETH2
                                                            options:NSJSONReadingAllowFragments
                                                                    error:&error];
  
        NSArray *temp2ETH2 = [ETH2USD allValues] ;
        ETH2Value =[temp2ETH2[0] floatValue]*ETH2;
        
        NSLog(@"ETH2 Value: %f2", [temp2ETH2[0] floatValue]*ETH2);
        NSLog(@"ETH2 Cost: %f", ETH2cost);
        
        
        float ETH2gain = (((ETH2Value)-ETH2cost)/ETH2cost)*100;
        
        NSLog(@"ETH2 Gain: %f2 ", ETH2gain);
  
    
    float LTC = 4.03721216;
    float LTCprice = 107.53;
    float LTCfee = 8.07;
    float LTCcost = LTCfee + (LTCprice * LTC);
    float LTCValue;
    
    NSURL *urlLTC = [NSURL URLWithString:@"https://min-api.cryptocompare.com/data/price?fsym=LTC&tsyms=USD"];
    
    //  NSError* error = nil;
    NSString* textLTC = [NSString stringWithContentsOfURL:urlLTC encoding:NSASCIIStringEncoding error:&error];
    NSData *myDataLTC = [textLTC dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *LTCUSD = [NSJSONSerialization JSONObjectWithData:myDataLTC
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error];
    
        NSArray *tempLTC = [LTCUSD allValues] ;
        LTCValue =[tempLTC[0] floatValue]*LTC;
        
        NSLog(@"LTC Value: %f2", [tempLTC[0] floatValue]*LTC);
        NSLog(@"LTC Cost: %f2", LTCcost);
        
        
        float LTCgain = (((LTCValue)-LTCcost)/LTCcost)*100;
        
        NSLog(@"LTC Gain: %f2 ", LTCgain);
        
    
    
    float BTH = 1.0;
    float BTHprice = 3171.78;
    float BTHfee = 47.26;
    float BTHcost = BTHfee + (BTHprice * BTH);
    float BTHValue;
    
    NSURL *urlBTH = [NSURL URLWithString:@"https://min-api.cryptocompare.com/data/price?fsym=BCH&tsyms=USD"];
    
    //  NSError* error = nil;
    NSString* textBTH = [NSString stringWithContentsOfURL:urlBTH encoding:NSASCIIStringEncoding error:&error];
    NSData *myDataBTH = [textBTH dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *BTHUSD = [NSJSONSerialization JSONObjectWithData:myDataBTH
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    
        NSArray *tempBTH = [BTHUSD allValues] ;
        BTHValue =[tempBTH[0] floatValue]*BTH;
        
        NSLog(@"BTH Value: %f2", [tempBTH[0] floatValue]*BTH);
        NSLog(@"BTH Cost: %f2", BTHcost);
        
        
        float BTHgain = (((BTHValue)-BTHcost)/BTHcost)*100;
        
        NSLog(@"BTH Gain: %f2 ", BTHgain);
        
    
    
    float totalCost = BTCcost+ETHcost+ETH2cost+LTCcost+BTHcost;
    float totalValue = BTCValue+ETHValue+ETH2Value+LTCValue+BTHValue;
    
    float totalGain = totalValue - totalCost;
    totalPercentGain = totalGain/totalCost;
    
    AmountTV = totalValue;
    AmountTG = totalGain;

    // Update call amount value
    NSNumber *amountTV = [[NSNumber alloc] initWithFloat:(float)AmountTV];
      NSNumber *amountTG = [[NSNumber alloc] initWithFloat:(float)AmountTG];
    NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_currencyFormatter setCurrencyCode:@"USD"];
    [_currencyFormatter setNegativeFormat:@"-¤#,##0.00"];
    
 
    _BTCLabel.text = [NSString stringWithFormat:@"%@ \n %@ \n %.2f%%",  [_currencyFormatter stringFromNumber:amountTV], [_currencyFormatter stringFromNumber:amountTG], totalPercentGain*100];
    
    
    
}

-(void)getTheCoins:(NSString *)Str
{
    
    NSURL *url = [NSURL URLWithString:Str];
    
    NSError* error = nil;
    NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
    coins = [NSJSONSerialization JSONObjectWithData:myData
                                            options:NSJSONReadingAllowFragments
                                              error:&error];
    if( text )
    {
    //    NSLog(@"Text=%@", [coins valueForKey:@"BTC"][@"USD"]);
    //    NSLog(@"Text=%@",coins);
    //    _BTCLabel.text = [NSString stringWithFormat:@"BTC = $%@",[coins valueForKey:@"BTC"][@"USD"]];
        
        NSArray*keys=[coins allKeys];
        coinArray = [[NSMutableArray alloc] init];
        
        for (NSString *key in keys) {
            NSDictionary *dic = @{ @"coin":key, @"price": [coins objectForKey:key] };
            [coinArray addObject:dic];
        }
        NSLog(@"Array - %@",coinArray);
        
    }
    else
    {
        NSLog(@"Error = %@", error);
    }
    
    // Reload table data
    [self.tableView reloadData];
    
    [self.refreshControl endRefreshing];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:{
             return self.companyarray.count;
        }break;
   
        default:
            return 0;
            break;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
            return 100.0;
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     return 100;

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    // 1. Dequeue the custom header cell
    MainHeaderTableViewCell* headerCell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
    
  
  
    
    
    // Update call amount value
    NSNumber *amountTV = [[NSNumber alloc] initWithFloat:(float)totalMarket];
    NSNumber *amountTG = [[NSNumber alloc] initWithFloat:(float)totalGainRK];
    NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_currencyFormatter setCurrencyCode:@"USD"];
    [_currencyFormatter setNegativeFormat:@"-¤#,##0.00"];
    
   
    
    // 2. Set the various properties
    headerCell.title.text = [_currencyFormatter stringFromNumber:amountTV];
    [headerCell.title sizeToFit];
    
    headerCell.subtitle.text = [_currencyFormatter stringFromNumber:amountTG];
    headerCell.percent.text = @"0.0";
    
    float totalPercentRK = 0.0;
    totalPercentRK = (totalMarket - totalCostRK)/totalCostRK;
    
     headerCell.percent.text = [NSString stringWithFormat:@"%.2f%%", totalPercentRK*100];
    
    if (totalGainRK >= 0) {
        headerCell.subtitle.textColor = [UIColor blackColor];
        headerCell.percent.textColor = [UIColor blackColor];
    }else
    {
        headerCell.subtitle.textColor = [UIColor redColor];
        headerCell.percent.textColor = [UIColor redColor];
    }
    
    //  [headerCell.subtitle sizeToFit];
    [headerCell.subtitle setTextAlignment:NSTextAlignmentRight];
    
  //  headerCell.image.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
    
    // 3. And return
    return headerCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 //  MainCustomTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  CoinHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSManagedObject *device = [self.companyarray objectAtIndex:indexPath.row];
    
    
    NSString *tempURL = [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/price?fsym=%@&tsyms=USD",  [device valueForKey:@"coinname"]];
    
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
    
    
    //  switch (indexPath.section) {
    //      case 0:{
    
    
    // Configure the cell...
    //  cell.textLabel.text = [NSString stringWithFormat:@"BTC = $%@",[coinArray valueForKey:@"BTC"][@"USD"]];
    
    //   _coin = [[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
    //   cell.textLabel.text =[[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
    //cell.coinLabel.text =[[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
 
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Transaction"];

    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"coinname == %@",[device valueForKey:@"coinname"]]];
    NSMutableArray *full = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
   
    
    NSLog(@"fullArray CDTVC : %@", full);
    
    float totHoldings= [[full valueForKeyPath:@"@sum.qty"] floatValue];
    [cell.totalHoldings setText:[NSString stringWithFormat:@"%.4f",totHoldings]];
    
    NSNumber *totValue= [full valueForKeyPath:@"@sum.totalvalue"];
    [cell.totalNetCost setText:[NSString stringWithFormat:@"$%@",totValue]];
    
    totalCostRK = totalCostRK + [totValue floatValue];
    
    [cell.coinName setText:[NSString stringWithFormat:@"%@ (%@)",[device valueForKey:@"coinname"], [device valueForKey:@"count"]]];
    
  //  NSManagedObject *device2 = [full objectAtIndex:indexPath.row];
  
  
 // cell.image.image = [UIImage imageWithData:[singleobj valueForKey:@"image"]];
    
   
    
//  [cell.tradePrice setText:[NSString stringWithFormat:@"$%@",[device valueForKey:@"tradeprice"]]];
    float cprice = [temp3[0] floatValue];
   [cell.currentPrice setText:[NSString stringWithFormat:@"$%.2f",cprice]];

  // float fee = [[full valueForKey:@"fee"] floatValue];
    
    
    float totalqty = totHoldings;
    
    float totMarketValue= totalqty * [temp3[0] floatValue];
    [cell.totalValue setText:[NSString stringWithFormat:@"$%.2f",totMarketValue]];
    
    totalMarket = totalMarket + totMarketValue;
    
    float totGain = (totMarketValue - [totValue floatValue]);
    [cell.totalGain setText:[NSString stringWithFormat:@"$%.2f",totGain]];
    
    totalGainRK = totalGainRK + totGain;
    
    [cell.percentGain setText:[NSString stringWithFormat:@"%.2f%%", (totMarketValue - [totValue floatValue])/[totValue floatValue]*100]];
    
    
    if ((totMarketValue - [totValue floatValue]) >= 0) {
        cell.percentGain.textColor = [UIColor blackColor];
       cell.totalGain.textColor = [UIColor blackColor];
    }else
    {
        cell.percentGain.textColor = [UIColor redColor];
       cell.totalGain.textColor = [UIColor redColor];
    }
    
    
    NSString *urlReceived = [NSString stringWithFormat:@"https://www.cryptocompare.com/api/data/coinlist/"];
    
    NSURL *url = [NSURL URLWithString:urlReceived];
    
    NSError* error = nil;
    NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *BTCUSD = [NSJSONSerialization JSONObjectWithData:myData
                                                           options:NSJSONReadingAllowFragments
                                                             error:&error];
    
    
    NSLog(@"BTCUSD: %@",[BTCUSD allKeys]);
    
    NSArray *temp2 = [BTCUSD valueForKey:@"Data"][[device valueForKey:@"coinname"] ];
    
    
    NSLog(@"Array: %@", temp2);
    NSLog(@"BTCUSD: %@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[device valueForKey:@"coinname"]][@"ImageUrl"]);
    
    _coinImageString = [NSString stringWithFormat:@"%@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[device valueForKey:@"coinname"]][@"ImageUrl"]];
    
    
    NSLog(@"Image String: %@", _coinImageString);
    
    //  cell.imageView.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
    
    cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
    
    return cell;
}
  //  switch (indexPath.section) {
  //      case 0:{
  
   
    // Configure the cell...
 //  cell.textLabel.text = [NSString stringWithFormat:@"BTC = $%@",[coinArray valueForKey:@"BTC"][@"USD"]];
    
 //   _coin = [[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
//   cell.textLabel.text =[[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
//cell.coinLabel.text =[[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
           
  /*         NSManagedObject *device = [self.companyarray objectAtIndex:indexPath.row];
            
            [cell. setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"coinname"]]];
               [cell.qty setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"qty"]]];
      [cell.tradePrice setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"tradeprice"]]];
    
   cell.image.image = [UIImage imageWithData:[device valueForKey:@"image"]];

    
    NSString *tempURL = [NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/price?fsym=%@&tsyms=USD",  [device valueForKey:@"coinname"]];
    
    NSURL *url2 = [NSURL URLWithString:tempURL];
    
    NSError* error2 = nil;
    NSString* text2 = [NSString stringWithContentsOfURL:url2 encoding:NSASCIIStringEncoding error:&error2];
    NSData *myData2 = [text2 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *BTCUSD2 = [NSJSONSerialization JSONObjectWithData:myData2
                                                            options:NSJSONReadingAllowFragments
                                                              error:&error2];
    
    
    NSLog(@"BTCUSD2: %@", BTCUSD2);
    NSArray *temp3;
    temp3 = [BTCUSD2 allValues] ;
    NSLog(@"temp3: %@", temp3[0]);
    
    [cell.currentPrice setText:[NSString stringWithFormat:@"%@",temp3[0]]];
    
    */
    
  /*
    NSInteger Amount = [[[coinArray objectAtIndex:indexPath.row] valueForKey:@"price"][@"USD"] integerValue ];
    // Update call amount value
    NSNumber *amount = [[NSNumber alloc] initWithFloat:(float)Amount];
    NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_currencyFormatter setCurrencyCode:@"USD"];
    [_currencyFormatter setNegativeFormat:@"-¤#,##0.00"];

 //   cell.detailTextLabel.text =  [_currencyFormatter stringFromNumber:amount];
            
   cell.priceLabel.text =[_currencyFormatter stringFromNumber:amount];
            
    //[NSString stringWithFormat:@"$%@",[[coinArray objectAtIndex:indexPath.row] valueForKey:@"price"][@"USD"]];
    
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

  //  cell.imageView.image =  [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
    
   cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
            
    CGSize  itemSize = CGSizeMake(25, 25);
    
    UIGraphicsBeginImageContextWithOptions(itemSize, false, self.view.contentScaleFactor);
    
    CGRect  imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    
    [cell.imageView.image drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
       
        }break;
            
        default:
            break;
    }
    */
 
  //  return cell;
//}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

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
/*

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [coinArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        
        NSLog(@"coinArray after delete: %@", [coinArray valueForKey:@"coin"]);
        
        NSString *temp = [[coinArray valueForKey:@"coin"] componentsJoinedByString:@","];

        NSString *valueToSave =[NSString stringWithFormat:@"https://min-api.cryptocompare.com/data/pricemulti?fsyms=%@&tsyms=USD&e=Coinbase&extraParams=robsapp",temp] ;
        NSLog(@"valueToSave in Delete:%@", valueToSave);
        
        
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"coinURLString"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        [tableView reloadData];
        
        
       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
/*    if ([[segue identifier] isEqualToString:@"coinDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        CoinDetailTVC *destinationViewController = (CoinDetailTVC *)segue.destinationViewController;
        
        destinationViewController.self.coin =  [[coinArray objectAtIndex:indexPath.row] valueForKey:@"coin"];
        
  }*/
    
    if ([[segue identifier] isEqualToString:@"coinDetail"]) {
        NSLog(@"Edit Transaction pass device");
        NSManagedObject *selectedDevice = [self.companyarray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        
      CoinDetailTVC *destViewController = segue.destinationViewController;
      destViewController.coindb = selectedDevice;
        
        
        
      //  UINavigationController *nav = [segue destinationViewController];
        
      //  AddTransactionTVC *destViewController = (AddTransactionTVC *)nav.topViewController;
      //  destViewController.coindb = selectedDevice;
        
    }
}


@end
