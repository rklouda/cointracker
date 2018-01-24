//
//  addCoinTCV.m
//  CoinTracker
//
//  Created by Robert Klouda on 1/14/18.
//  Copyright © 2018 Robert Klouda. All rights reserved.
//

#import "addCoinTCV.h"
#import "AddTransactionTVC.h"

@interface addCoinTCV ()

@end


@implementation addCoinTCV

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
    
    context = [self managedObjectContext];
    
    newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Coin"];
    
    NSError* error = nil;
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest
                                                           error:&error];
    
    NSLog(@"RESULT: %@", results);
    
    coinArray = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    

    NSString *valueToSave = @"https://api.coinmarketcap.com/v1/ticker/";
    [self getTheCoins:valueToSave];
    
  //  [self.tableView reloadData];
 //   NSLog(@"Company Array for prices:%@", coinArray);
  
}


- (IBAction)update:(id)sender {
    
  //
    
   // [newDevice setValue:self.company.text forKey:@"companyname"];

NSError *error = nil;
// Save the object to persistent store
if (![context save:&error]) {
    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
}
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
     NSLog(@"Coins dict:%@", coins);
  
     NSArray*keys=[coins valueForKey:@"symbol"];
NSArray*keys2=[coins valueForKey:@"name"];
        
    NSLog(@"Coins allkeys:%@", keys2);
        coinArray = [[NSMutableArray alloc] init];
        coinSymbolArray = [[NSMutableArray alloc] init];
  coinNameArray = [[NSMutableArray alloc] init];
        
        for (NSString *key in keys) {
            
            NSDictionary *dic = @{ @"symbol":key};
            
        [coinArray addObject:dic];
            
            NSDictionary *dict = @{ @"coinname":key};
            
            [coinSymbolArray addObject:dict];
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
    NSLog(@"CoinNameArray: %@", coinNameArray);

    
  
    
    
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
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return coinArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    // Configure the cell...
    NSManagedObject *device = [coinArray objectAtIndex:indexPath.row];
     NSManagedObject *device2 = [coinNameArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",[device valueForKey:@"symbol"]]];
   
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[device2 valueForKey:@"name"]]];

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

@end
