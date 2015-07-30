//
//  ROTableViewController.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ROTableViewDataSource;
@interface ROTableViewController : UIViewController <UITableViewDelegate> {
    UITableView *_tableView;
    ROTableViewDataSource *_dataSource;
}

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) ROTableViewDataSource *dataSource;

- (void)setupTableViewWithStyle:(UITableViewStyle)style;
@end
