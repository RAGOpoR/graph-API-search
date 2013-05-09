//
//  ROTableViewController.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROTableViewController : UIViewController <UITableViewDelegate> {
    UITableView *_tableView;
}

@property (strong, nonatomic) UITableView *tableView;

@end
