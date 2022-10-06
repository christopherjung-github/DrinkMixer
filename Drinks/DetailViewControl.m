//
//  DetailViewControl.m
//  Drinks
//
//  Created by Christopher Jung on 10/3/22.
//

#import "DetailViewControl.h"
#import "DrinkConstants.h"

@interface DetailViewControl () {
// code should be entered in the interface section of the implementation file
// if you don't want users to view the name
}

@end

@implementation DetailViewControl

@synthesize drink=drink, drinkName=drinkName, ingredients=ingredients, directions=directions, scrollView=scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentSize = self.view.frame.size;

    NSLog(@"the detail view did load");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"the detail view will appear");

    self.drinkName.text   = [self.drink objectForKey:NAME_KEY];
    self.ingredients.text = [self.drink objectForKey:INGREDIENTS_KEY];
    self.directions.text  = [self.drink objectForKey:DIRECTIONS_KEY];

    NSLog(@"%@", [NSString stringWithFormat: @"ingredients is %@\n", self.ingredients.text]);

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
