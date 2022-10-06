//
//  DetailViewControl.h
//  Drinks
//
//  Created by Christopher Jung on 10/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewControl : UIViewController {
    NSDictionary *drink;
    UIScrollView *scrollView;
}

@property (strong, nonatomic) IBOutlet UITextField *drinkName;
@property (strong, nonatomic) IBOutlet UITextView *ingredients;
@property (strong, nonatomic) IBOutlet UITextView *directions;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, retain) NSDictionary *drink;

@end

NS_ASSUME_NONNULL_END
