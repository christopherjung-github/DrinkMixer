//
//  AddDrinkViewController.m
//  DrinkMixer
//
//  Created by William McCarthy on 12/8/2022.
//

#import <UIKit/UIKit.h>
#import "AddDrinkViewControl.h"
#import "DrinkConstants.h"


@interface AddDrinkViewControl()

@end



@implementation AddDrinkViewControl

@synthesize drinkArray=drinkArray;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.leftBarButtonItem
      = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
      target:self
      action:@selector(cancel:)];
  self.navigationItem.rightBarButtonItem
      = [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
      target:self
      action:@selector(save:)];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  NSLog(@"Registering for keyboard events");
  
  [[NSNotificationCenter defaultCenter]
      addObserver:self
      selector:@selector(keyboardDidShow:)
      name:UIKeyboardDidShowNotification
      object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
      selector:@selector(keyboardDidHide:)
      name:UIKeyboardDidShowNotification
      object:nil];
  keyboardVisible = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
  NSLog(@"Unregistering for keyboard events");
  [[NSNotificationCenter defaultCenter]
   removeObserver:self];
}

#pragma mark -
#pragma mark - Keyboard Handlers

- (void)keyboardDidShow:(NSNotification *)notif {
  NSLog(@"Received UIKeyboardDidShowNotification");
  if (keyboardVisible) {
    NSLog(@"Keyboard is already visible... Ignoring notification");
    return;
  }
  NSLog(@"Resizing smaller for keyboard");
  NSDictionary *info = [notif userInfo];
  NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
  
  CGRect keyboardRect = [aValue CGRectValue];
  keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
  CGFloat keyboardTop = keyboardRect.origin.y;
  
  CGRect viewFrame = self.view.bounds;
  viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
  
  self.scrollView.frame = viewFrame;
  keyboardVisible = YES;
}

- (void)keyboardDidHide:(NSNotification *)notif {
  NSLog(@"Received UIKeyboardDidHideNotification");
  if (!keyboardVisible) {
    NSLog(@"Keyboard already hidden... Ignoring notification");
    return;
  }
  NSLog(@"Resizing bigger with no keyboard");
  self.scrollView.frame = self.view.bounds;
  keyboardVisible = NO;
}

#pragma mark - Action Items save and cancel

- (IBAction)save:(id)sender {
  NSLog(@"Save pressed!");
  
  if (self.drink != nil) {
    // working with existing drink -- remove it, then create new (edited) one
    [drinkArray removeObject:self.drink];
    self.drink = nil;
  }
  
  NSMutableDictionary *newDrink = [[NSMutableDictionary alloc] init];
  [newDrink setValue:self.drinkName.text forKey:NAME_KEY];
  [newDrink setValue:self.ingredients.text forKey:INGREDIENTS_KEY];
  [newDrink setValue:self.directions.text forKey:DIRECTIONS_KEY];
  
  [drinkArray addObject:newDrink];
  
  NSSortDescriptor *nameSorter
      = [[NSSortDescriptor alloc] initWithKey:NAME_KEY
                                  ascending:YES
                                  selector:@selector(caseInsensitiveCompare:)];
  
  [drinkArray sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadNotification" object:self];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
  NSLog(@"Cancel pressed!");
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end


