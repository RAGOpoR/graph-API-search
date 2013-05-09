//
//  FBGraphSearchViewController.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROTableViewController.h"

@interface FBGraphSearchViewController : ROTableViewController {
    UISearchBar *_searchBar;
}

@property (nonatomic, strong) UISearchBar *searchBar;

@end
