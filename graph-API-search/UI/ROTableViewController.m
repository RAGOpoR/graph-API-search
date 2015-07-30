//
//  ROTableViewController.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/9/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ROTableViewController.h"
#import "ROTableViewDataSource.h"

@interface ROTableViewController ()

@end

@implementation ROTableViewController

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
	// Do any additional setup after loading the view.
    [self setupTableViewWithStyle:UITableViewStylePlain];
    self.tableView.isAccessibilityElement = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self setDataSource:nil];
    [self setTableView:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableViewWithStyle:(UITableViewStyle)style
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat expectSizeHeight;
    
    if (self.tabBarController)
    {
        expectSizeHeight = screenBound.size.height - kSumOfStatusBarAndNavigationBarAndTabBar;
    }
    
    else
    {
        expectSizeHeight = screenBound.size.height - (kNavigationBarHeight + kStatusBarHeight);
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, expectSizeHeight) style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = (id<UITableViewDataSource>)self.dataSource;
    
    //    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *tableBackgroundView = [[UIView alloc] initWithFrame:self.tableView.frame];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundView = tableBackgroundView;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Table View Delegate

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

@end
