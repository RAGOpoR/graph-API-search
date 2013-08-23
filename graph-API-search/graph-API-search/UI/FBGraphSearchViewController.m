//
//  FBGraphSearchViewController.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "FBGraphSearchViewController.h"
#import "FBGraphSearchDataSource.h"
#import "ViewController.h"
#import "AddItemViewController.h"
#import "ZAddPlaceLocationSelector.h"
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
    self.tableView.accessibilityIdentifier = @"Item listing";
	// Do any additional setup after loading the view.
    [self setupNextButtonWithImageName:@"plusIcon.png" andHilightedImageName:@"plusIcon-hl.png" withImageWidth:36 andImageHeight:32];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 100;
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%d",indexPath.row);
    ViewController *currentView = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    [currentView setCurrentObject:[self.dataSource.objectArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:currentView animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerSearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    
    UIEdgeInsets imgButtonInsets = UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f);
    UIImageView *shareButtonFrame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Button"]];
    shareButtonFrame.image = [shareButtonFrame.image resizableImageWithCapInsets:imgButtonInsets];
    [shareButtonFrame setContentMode:UIViewContentModeScaleAspectFill];
    [shareButtonFrame setFrame:CGRectMake(0, 143, 145, 36)];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 8, 45, 36)];
    
    [searchButton setBackgroundImage:shareButtonFrame.image forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(doSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:NSLocalizedString(@"Search",nil) forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    searchButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
    //        [self.shareButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [searchButton.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-55, 39)];
    self.searchBar.delegate = (id<UISearchBarDelegate>)self;
    self.searchBar.placeholder = NSLocalizedString(@"Search", @"Search");
    self.searchBar.backgroundImage = [UIImage new];
    [self.searchBar setTranslucent:YES];
    
    
    [headerSearchView addSubview:self.searchBar];
    [headerSearchView addSubview:searchButton];
    headerSearchView.layer.borderColor = [UIColor blackColor].CGColor;
    headerSearchView.layer.borderWidth = 1.0f;
    return headerSearchView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

#pragma mark APIClient

- (void)requestCompletedWithStatus:(NSInteger)status andResults:(NSMutableDictionary *)results requestType:(NSString *)requestType {
    [SVProgressHUD dismiss];
    if (status == StatusOK) {
        if ([requestType isEqualToString:kZodioAPIClientRequestTypeGetFacebookGraphSearch]) {

            [self.dataSource processJSONArray:[results objectForKey:@"data"]];
            [self.tableView reloadData];
            
        }
        
    }
    else if (status == StatusNoResultsError) {

    }
}

- (void)requestType:(NSString *)request failedWithError:(NSError *)error andData:(id)JSON {
    [SVProgressHUD showErrorWithStatus:@"Failed"];
}

- (void)doSearchButton:(id)sender {
    NSString *unescaped = self.searchBar.text;
    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (__bridge CFStringRef) unescaped,
                                                                                                    NULL,
                                                                                                    CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                                    kCFStringEncodingUTF8));
//    NSLog(@"%@",escapedString);
    [[ZodioAPIClient sharedClient] facebookGraphSearchForKeyword:escapedString
                                                        withPage:0
                                                        andLimit:0
                                                        forOwner:(id<ZodioAPIClientDelegate>)self];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Searching", @"Searching")];
}

#pragma mark buttons

- (void)nextButtonPress{
    //Add New Item
//    DealfishAppDelegate *appDelegate = [DealfishAppDelegate sharedDelegate];
//    [appDelegate gotoAddItemViewWithNavBack:true andViewController:self];
    
    AddItemViewController *addItemViewController = [[AddItemViewController alloc] initWithNibName:@"AddItemViewController" bundle:nil];
    ZAddPlaceLocationSelector *zAddLocation = [[ZAddPlaceLocationSelector alloc] initWithNibName:nil bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:zAddLocation];
    ZNavigationBar *navBar = (ZNavigationBar *)[navController navigationBar];
    //    [navBar setTintColor:kZodioColorBlue];
    [navBar setBackgroundImage:[UIImage imageNamed:@"Home_TopBar_RoundCorner_withLogo"] forBarMetrics:UIBarMetricsDefault];
//    ZNavigationController *addPlaceNav = [ZRootViewController customizedNavigationController];
//    [navController setViewControllers:[NSArray arrayWithObject:addItemViewController]];
    
    [self.navigationController presentViewController:navController
                                            animated:YES
                                          completion:nil];
    
    
    
//    [self presentViewController:addItemViewController animated:YES completion:nil];
}
@end
