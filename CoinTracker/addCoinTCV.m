//
//  addCoinTCV.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/14/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "addCoinTCV.h"
#import "AddTransactionTVC.h"
#import "SVProgressHUD.h"

@interface addCoinTCV ()

@end


@implementation addCoinTCV
    BOOL searchEnabled;


- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD show];
    searchEnabled = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
  
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
     _searchResults = [[NSMutableArray alloc] init];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor blueColor];
    
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(update:)
                  forControlEvents:UIControlEventValueChanged];
    
 [SVProgressHUD show];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    context = [self managedObjectContext];
    
 //   NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
 //   NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Coin"];
    
  //  coinArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];

    //  NSLog(@"RESULT coinArray from COINS: %@", coinArray);
    
    
 //Self if we are in the model class
 

 
    
    
    
  /*  NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Coin"];
    
    NSError* error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest
                                                           error:&error];
    
  
    
    
    
    coinArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
 */
 //   NSString *valueToSave = @"https://api.coinmarketcap.com/v1/ticker/";
 //   [self getTheCoins:valueToSave];
 
    NSString *valueToSave = @"https://api.coinmarketcap.com/v1/ticker/";
    [self getTheCoins:valueToSave];

     searchEnabled = NO;
   [SVProgressHUD dismiss];
   [self.tableView reloadData];
 //   NSLog(@"Company Array for prices:%@", coinArray);
  
}


- (IBAction)update:(id)sender {
    
    
 


 
}



-(void)getTheCoins:(NSString *)Str
{
  

    
//    NSManagedObjectContext *newcoins = [newDevice valueForKey:@"coinarray"];
    
    NSURL *url = [NSURL URLWithString:Str];
    
    NSError* error = nil;
    NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
    coins = [NSJSONSerialization JSONObjectWithData:myData
                                            options:NSJSONReadingAllowFragments
                                              error:&error];
    if( text )
    {
        
     NSLog(@"Coins dict:%@", coins);
  
     NSArray*keys=[coins valueForKey:@"symbol"];
NSArray*keys2=[coins valueForKey:@"name"];
        
        
    NSLog(@"Coins allkeys:%@", keys2);
        coinArray = [[NSMutableArray alloc] init];
        coinSymbolArray = [[NSMutableArray alloc] init];
  coinNameArray = [[NSMutableArray alloc] init];
    
       
        
        
        for (NSString *key in keys) {
            
            NSDictionary *dic = @{ @"symbol":key};
            
           /*    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
            [newDevice setValue:dic[@"symbol"] forKey:@"symbol"];
            
        
            NSString *urlReceived = [NSString stringWithFormat:@"https://www.cryptocompare.com/api/data/coinlist/"];
            
            NSURL *url = [NSURL URLWithString:urlReceived];
            
            NSError* error = nil;
            NSString* text = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
            NSData *myData = [text dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *BTCUSD = [NSJSONSerialization JSONObjectWithData:myData
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
            
            
            NSLog(@"BTCUSD: %@",[BTCUSD allKeys]);
            
         //   NSArray *temp2 = [BTCUSD valueForKey:@"Data"][[coinArray valueForKey:@"symbol"] ];
            
            
          //  NSLog(@"Array: %@", temp2);
        //    NSLog(@"BTCUSD: %@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[coinArray valueForKey:@"symbol"][@"ImageUrl"]];
            
            _coinImageString = [NSString stringWithFormat:@"%@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[coinArray valueForKey:@"symbol"]][@"ImageUrl"]];
            
            NSLog(@"Image String: %@", _coinImageString);
            
            
            _coinImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
            
            
            NSData *imageData = UIImagePNGRepresentation(_coinImage.image);
            
            
            [newDevice setValue:imageData forKey:@"image"];
*/
            
            
            
            
            
        [coinArray addObject:dic];
            
      //
            
           NSDictionary *dict = @{ @"coinname":key};
         /*    NSManagedObject *newDeviceCN = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
            [newDeviceCN setValue:dict[@"coinname"] forKey:@"coinname"];
          */
            [coinSymbolArray addObject:dict];
           //
         }
        
         for (NSString *key2 in keys2) {
   NSDictionary *dict2 = @{ @"name":key2};
            
       [coinNameArray addObject:dict2];
         }
      
    

    }
    else
    {
        NSLog(@"Error = %@", error);
    }
    
  

    
    NSLog(@"CoinArray: %@", coinArray);
    NSLog(@"CoinNameArray: %@", coinNameArray);
    NSLog(@"CoinSymbolArray: %@", coinSymbolArray);
  //  NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:[coinNameArray valueForKey:@"name"]];
  //  [newDevice setValue:arrayData forKey:@"coinarray"];
  //  [self managedObjectContext];
  
  /*  NSManagedObject *newData;
    for (int i = 0; i < coinArray.count; i++){
       // newData = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
        [newDevice setValue:[coinArray[i] valueForKey:@"symbol"] forKey:@"coinname"];
        // [newData setValue:array2[i] forKey:@"sub-entities"];
    }
  
    
  //  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:coinArray];
  //  [newDevice setValue:data forKey:@"coinarray"];
 
    
  //  NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save array! %@ %@", error, [error localizedDescription]);
    }else {
        NSLog(@"Data array saved successfully ..%@", newDevice);
    }
      */
    
    
    /*
    NSManagedObjectContext *context = [self managedObjectContext];
    
     NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
        
        [newDevice setValue:coinArray forKey:@"coinname"];
   
     //   NSData *imageData = UIImagePNGRepresentation(_coinImage.image);
   //   [newDevice setValue:imageData forKey:@"image"];
    
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }else{
            NSLog(@"New Coins Saved!!");
        }
     
     */
    // Reload table data
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
 
}
-(void)viewDidDisappear:(BOOL)animated{
    

    
    
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows

    
    if (searchEnabled) {
        return [self.searchResults count];
    }
    else{
       return coinArray.count;
    }
   
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSManagedObject *device = [coinArray objectAtIndex:indexPath.row];
    NSManagedObject *device2 = [coinNameArray objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    if (searchEnabled) {
        NSManagedObject *device3 = [self.searchResults objectAtIndex:indexPath.row];
    
         [cell.textLabel setText:[NSString stringWithFormat:@"%@",[device3 valueForKey:@"symbol"]]];
      //    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[device2 valueForKey:@"name"]]];
        
    }
    else{
     
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"symbol"]]];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[device2 valueForKey:@"name"]]];
        
    }
    
    
    // Configure the cell...
    

     
   
   
 
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
    
    NSArray *temp2 = [BTCUSD valueForKey:@"Data"][[[coinArray objectAtIndex:indexPath.row] valueForKey:@"symbol"] ];
    
    
    NSLog(@"Array: %@", temp2);
    NSLog(@"BTCUSD: %@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[[coinArray objectAtIndex:indexPath.row] valueForKey:@"symbol"]][@"ImageUrl"]);
    
    _coinImageString = [NSString stringWithFormat:@"%@%@", [BTCUSD valueForKey:@"BaseLinkUrl"],[BTCUSD valueForKey:@"Data"][[[coinArray objectAtIndex:indexPath.row] valueForKey:@"symbol"]][@"ImageUrl"]];
    
    NSLog(@"Image String: %@", _coinImageString);
    
    
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_coinImageString]]];
    
    
    CGSize  itemSize = CGSizeMake(25, 25);
    
    UIGraphicsBeginImageContextWithOptions(itemSize, false, self.view.contentScaleFactor);
    
    CGRect  imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    
    [cell.imageView.image drawInRect:imageRect];
    
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
*/
    
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"addSymbol"]) {
        
     //   NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
         [SVProgressHUD show];
       
       NSManagedObject *selectedDevice = [coinSymbolArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
      //  AddTransactionTVC *destinationViewController = (AddTransactionTVC *)segue.destinationViewController;
        
        NSLog(@"Coin Symbol to pass: %@ %@:", [coinSymbolArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]], selectedDevice);
        
        UINavigationController *nav = [segue destinationViewController];
        
        AddTransactionTVC *destViewController = (AddTransactionTVC *)nav.topViewController;
     
      //  destViewController.companyName= [coinArray objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        
        
        
       destViewController.newcoindb =  selectedDevice;
        
        
    }
}
- (void)modalViewControllerDidCancel
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"symbol CONTAINS[c] %@",
                                    searchString];
  
  
    _searchResults = [coinArray filteredArrayUsingPredicate:resultPredicate];
    
    NSLog(@"Search Results: %@", _searchResults);

    [self.tableView reloadData];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchEnabled = YES;
 //  [self updateSearchResultsForSearchController:];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    searchEnabled = NO;
    [self.tableView reloadData];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        searchEnabled = NO;
        [self.tableView reloadData];
    }
    else {
        searchEnabled = YES;
      //  [self filterContentForSearchText:searchBar.text];
    }
}
@end
