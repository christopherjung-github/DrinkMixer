//
//  ViewController.h
//  Drinks
//
//  Created by Christopher Jung on 9/7/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
@private
    UITableView *tableView;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

