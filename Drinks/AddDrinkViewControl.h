//
//  AddDrinkViewController.h
//  DrinkMixer
//
//  Created by William McCarthy on 12/8/2022.
//

#ifndef AddDrinkViewController_h
#define AddDrinkViewController_h

#import "DetailViewControl.h"


@interface AddDrinkViewControl : DetailViewControl {
  BOOL keyboardVisible;
  NSMutableArray *drinkArray;
}

@property (nonatomic, retain) NSMutableArray *drinkArray;


- (void)keyboardDidShow:(NSNotification *)notif;
- (void)keyboardDidHide:(NSNotification *)notif;

@end

#endif /* AddDrinkViewController_h */
