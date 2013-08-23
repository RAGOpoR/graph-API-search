//
//  ZViewController.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 5/10/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "ZViewController.h"





#import "LoginViewController.h"
#import "UIDeviceHardware.h"
//#import "ZInfoBarController.h"


@interface ZViewController ()

@end

@implementation ZViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.trackedViewName = [[ZTracker sharedTracker] trackingNameForViewController:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //This is to fix orientation issues when going from landscape to portrait
    //See: http://stackoverflow.com/questions/14633213/force-portrait-orientation-while-pushing-from-landscape-view-controller
    //See: http://jira.zodio.com/browse/ZI-1880
    
//    UIViewController *c = [[UIViewController alloc]init];
//    [self presentModalViewController:c animated:NO];
//    [self dismissModalViewControllerAnimated:NO];

    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kZodioBackgroundTexture]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    UIApplication* application = [UIApplication sharedApplication];
//    if (application.statusBarOrientation != UIInterfaceOrientationPortrait)
//    {
//        UIViewController *c = [[UIViewController alloc]init];
//        [self presentViewController:c animated:NO completion:nil];
//        [self dismissViewControllerAnimated:NO completion:nil];
//    }
//    
//    if (!self.awesomeMenuDisabled)
//    {
//        [self.view addSubview:[[ZMenuController sharedController] menu]];
//        [[ZMenuController sharedController].menu moveOriginToPoint:CGPointZero animated:NO];
//    }
//    
//    if (self.navigationController && !self.navigationBarHidden)
//    {
//        [self.navigationController setNavigationBarHidden:NO];
//    }
}

#pragma mark - Autorotate

#pragma mark - iOS 5

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationPortrait)||(interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown))
    {
        return YES;
    }
    
    else return NO;
}

#pragma mark - iOS 6

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)clearProgressAndErrorViews
{
//    [self dismissHUD];
//    [self removeFullscreenErrorView];
}

- (void)dismissHUD
{
//    [self dismissZProgressHUD];
//    [SVProgressHUD dismiss];
}

#pragma mark - Login Page

- (BOOL)userIsLoggedIn
{
//    if (![JGZodioCurrentUser currentUser].userID)
//    {
//        if (self.presentingViewController)
//        {
//            [self showLoginPage];
//        }
//        else
//        {
//            [(ZRootViewController*)self.viewDeckController showLoginPage];
//        }
//        
//        return NO;
//    }
    
    return YES;
}

- (void)showLoginPage
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIViewController *loginView;
    UIDeviceHardware *deviceHardware = [[UIDeviceHardware alloc] init];
    
    if (deviceHardware.platformInteger == 5 || screenBounds.size.height == 1136 || screenBounds.size.height == 568)
    {
        loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone5" bundle:nil];
    }
    else
    {
        loginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    }
    
    [self presentViewController:loginView animated:YES completion:nil];
}

#pragma mark right menu setting

- (void) setupNextButtonWithImageName:(NSString*)defaultImageName andHilightedImageName:(NSString*)hilightedImageName withImageWidth:(float)width andImageHeight:(float)height {
    UIButton *buttonNext = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    [buttonNext setImage:[UIImage imageNamed:defaultImageName] forState:UIControlStateNormal];
    [buttonNext setImage:[UIImage imageNamed:hilightedImageName] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(nextButtonPress) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *navNextButton = [[UIBarButtonItem alloc] initWithCustomView: buttonNext];
    [self.navigationItem setRightBarButtonItem:navNextButton];
}

- (void)setupLeftCancelButtonItem
{
    if (self.navigationController) {
        if (self.navigationController.topViewController == self) {
            UIButton *buttonBack = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 69, 32)];
            [buttonBack setTitle:@"Cancel" forState:UIControlStateNormal];
            [buttonBack setTitle:@"Cancel" forState:UIControlStateHighlighted];
            [buttonBack setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            
            [buttonBack addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
            
            UIBarButtonItem *navBackButton = [[UIBarButtonItem alloc] initWithCustomView: buttonBack];
            [self.navigationItem setLeftBarButtonItem:navBackButton];
        }
    }
}


@end
