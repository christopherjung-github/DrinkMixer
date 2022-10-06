//
//  ViewController.m
//  Drinks
//
//  Created by Christopher Jung on 9/7/22.
//

#import "ViewController.h"
#import "DetailViewControl.h"
#import "AddDrinkViewControl.h"
#import "DrinkConstants.h"

@interface ViewController () {
    NSMutableArray *drinks;
    UIBarButtonItem *addButton;
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (strong, retain) NSMutableArray *drinks;
//- (IBAction)addButtonPressed:(id)sender;

@end


@implementation ViewController

@synthesize tableView=tableView, addButton=addButton, drinks=drinks;

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    drinks = [[NSMutableArray alloc] initWithContentsOfFile:path];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = self.addButton;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView: (UITableView *) tableView { return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [drinks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"drinkCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [[drinks objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setEditing:true animated:true];
    [[self tableView] reloadData];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        delete the row from the data source
        [drinks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        TODO: still to come
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue
//        sender:(id)sender {
//  DetailViewController *detailVC;
//  if ([segue.identifier isEqualToString:@"detailVC"]) {
//    NSIndexPath *indexPath = [tableView indexPathForCell:sender];
//    detailVC = (DetailViewController *)segue.destinationViewController;
//    [detailVC setValue:[drinks objectAtIndex:indexPath.row] forKey:@"drink"];
//  }
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath { return YES; }

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"in didSelectViewRowAtIndexPath");
    
    if (!self.editing) {
        DetailViewControl *detailVC = [[DetailViewControl alloc] initWithNibName:@"DetailViewControl" bundle:nil];
        //        DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
        
        detailVC.drink = [drinks objectAtIndex:indexPath.row];

        NSLog(@"%@", [NSString stringWithFormat: @"drink in VC is %@\n", detailVC.drink]);
        NSLog(@"%@", [NSString stringWithFormat: @"ingredient in VC is %@\n", [detailVC.drink objectForKey:INGREDIENTS_KEY]]);
        
        [self.navigationController pushViewController:detailVC animated:YES];
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    } else {
//        AddDrinkViewControl *editingDrinkVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewControl"];
        AddDrinkViewControl *editingDrinkVC = [[AddDrinkViewControl alloc] initWithNibName:@"DetailViewControl" bundle:nil];
            editingDrinkVC.drink = [drinks objectAtIndex:indexPath.row];
            editingDrinkVC.drinkArray = drinks;
            
            UINavigationController *editingNavCon = [[UINavigationController alloc] initWithRootViewController:editingDrinkVC];
            [self presentViewController:editingNavCon animated:YES completion:nil];
    }
}

- (void)receiveNotification:(NSNotification *)notif {
  NSLog(@"in receiveNotification, reloading data...");
  [tableView reloadData];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - IBActions

- (IBAction)addButtonPressed:(id)sender {
  NSLog(@"Add button pressed!");

//  AddDrinkViewControl *addDrinkVC = [self.storyboard instantiateViewControllerWithIdentifier:@"addDrinkVC"];
    AddDrinkViewControl *addDrinkVC = [[AddDrinkViewControl alloc] initWithNibName:@"DetailViewControl" bundle:nil];
    
  UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addDrinkVC];

  addDrinkVC.drinkArray = drinks;

  // register self with NSNotificationCenter for tableShouldUpload selector
  //    allows addNavController to send request for data to upload when save is chosen
  NSLog(@"creating NSNotification for ReloadNotification");

  [[NSNotificationCenter defaultCenter]
      addObserver:self
      selector:@selector(receiveNotification:)
      name:@"ReloadNotification"
      object:nil];
  
  [self presentViewController:addNavController animated:YES completion:nil];
  
  NSLog(@"after presenting the addNavController");
//  [self.navigationController pushViewController:addDrinkVC animated:YES];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:!editing];
}

@end
