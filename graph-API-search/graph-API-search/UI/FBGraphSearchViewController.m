//
//  FBGraphSearchViewController.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "FBGraphSearchViewController.h"
#import "FBGraphSearchDataSource.h"

@interface FBGraphSearchViewController ()

@end

@implementation FBGraphSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.dataSource = [[FBGraphSearchDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    
    self.tableView.isAccessibilityElement = YES;
    self.tableView.accessibilityIdentifier = @"FBGraphSearch list";
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 45;
    
    return height;
}

@end
