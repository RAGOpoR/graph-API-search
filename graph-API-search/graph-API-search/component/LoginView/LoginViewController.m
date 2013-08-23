//
//  LoginViewController.m
//  testTabApp
//
//  Created by Jai Govindani on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//#import "URLCacheAlert.h"
#import "LoginViewController.h"
#import "ZodioAPIClient.h"
//#include "JKGJSONDriller.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

//#import "TWSignedRequest.h"
//#import "OAuth+Additions.h"
//#import <Twitter/Twitter.h>
//#import <Accounts/Accounts.h>
//#import "JSONKit.h"

//#import "JGZodioSignupViewController.h"
//#import "JGFormFactory.h"
//#import "IIViewDeckController.h"
//#import "JGSocialCredentialManager.h"

//#import "ZRootViewController.h"
#import "JBKenBurnsView.h"
#import "UIView+Alignment.h"
#import <objc/runtime.h>

#define TW_X_AUTH_MODE_KEY                  @"x_auth_mode"
#define TW_X_AUTH_MODE_REVERSE_AUTH         @"reverse_auth"
#define TW_X_AUTH_MODE_CLIENT_AUTH          @"client_auth"
#define TW_X_AUTH_REVERSE_PARMS             @"x_reverse_auth_parameters"
#define TW_X_AUTH_REVERSE_TARGET            @"x_reverse_auth_target"
#define TW_X_AUTH_USERNAME                  @"x_auth_username"
#define TW_X_AUTH_PASSWORD                  @"x_auth_password"
#define TW_SCREEN_NAME                      @"screen_name"
#define TW_USER_ID                          @"user_id"
#define TW_OAUTH_URL_REQUEST_TOKEN          @"https://api.twitter.com/oauth/request_token"
#define TW_OAUTH_URL_AUTH_TOKEN             @"https://api.twitter.com/oauth/access_token"

#define POP_ALERT(_W,_X) [[[UIAlertView alloc] initWithTitle:_W message:_X delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]



@interface LoginViewController ()

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@property (strong, nonatomic) NSDictionary *userInfoForPOST;
@property (strong, nonatomic) ZodioAPIClient *loginZodioAPIClient;
@property (strong, nonatomic) NSArray *JSONPathsForZodioLogin;
@property (strong, nonatomic) NSArray *JSONPathsForTwitterRegistration;
@property (strong, nonatomic) NSArray *JSONPathForTwitterLogin;
@property (nonatomic, strong) ACAccountStore *accountStore;

- (BOOL)_checkForLocalCredentials;
- (BOOL)_checkForKeys;
//- (void)_handleError:(NSError *)error forResponse:(NSURLResponse *)response;
//- (void)_handleStep2Response:(NSString *)responseStr;



@end

@implementation LoginViewController

@synthesize emailTextField;
@synthesize passwordTextField;
@synthesize username, password;
@synthesize userInfoForPOST;
@synthesize loginZodioAPIClient;
@synthesize JSONPathsForZodioLogin;
@synthesize JSONPathsForTwitterRegistration;
@synthesize JSONPathForTwitterLogin;
@synthesize twitterLoginInfo;
@synthesize loginForegroundViewFacebookSSO = _loginForegroundViewFacebookSSO;
@synthesize loginForegroundViewExistingUser = _loginForegroundViewExistingUser;
@synthesize loginForegroundViewResetPassword = _loginForegroundViewResetPassword;
@synthesize resetPasswordTextField = _resetPasswordTextField;
@synthesize accountStore = _accountStore;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.awesomeMenuDisabled = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(keyboardWillShow:)
													 name:UIKeyboardWillShowNotification
												   object:nil];
		
//		[[NSNotificationCenter defaultCenter] addObserver:self
//												 selector:@selector(keyboardWillHide:)
//													 name:UIKeyboardWillHideNotification
//												   object:nil];
    }
    
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (hardwareNumber() >= 4) {
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    emailTextField.delegate = self;
    passwordTextField.delegate = self;
    self.resetPasswordTextField.delegate = self;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIDeviceHardware *deviceHardware = [[UIDeviceHardware alloc] init];
    
    if (deviceHardware.platformInteger == 5 || screenBounds.size.height == 1136 || screenBounds.size.height == 568)
    {
        
    }
    else {
//        self.loginForegroundViewFacebookSSO.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"16first-page_blank-background.png"]];
//        self.loginForegroundViewExistingUser.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"16first-page_blank-background.png"]];
//        self.loginForegroundViewResetPassword.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"16first-page_blank-background.png"]];
    }
    
    NSArray *photos = [NSArray arrayWithObject:[UIImage imageNamed:@"BG_login.png"]];
    [self.animatedBackgroundView animateWithImages:photos transitionDuration:60 loop:YES isLandscape:YES];
    
    [self.view addSubview:self.loginForegroundViewFacebookSSO];

    loginZodioAPIClient = [ZodioAPIClient sharedClient];
    BOOL isRetina = NO;
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] &&
       [[UIScreen mainScreen] scale] == 2.0) {
        isRetina =  YES;
    }
    else {
        isRetina = NO;
    }
    
//    BOOL isRetinaScreen = isRetina;
    
//    if (isRetinaScreen)
//    {
//        CGRect headFrame = self.existingUserFrameHeadLabel.frame;
//        self.existingUserFrameHeadLabel.frame = CGRectMake(headFrame.origin.x, headFrame.origin.y-18, headFrame.size.width, headFrame.size.height);
//        CGRect bodyFrame = self.existingUserFrame.frame;
//        self.existingUserFrame.frame = CGRectMake(bodyFrame.origin.x, bodyFrame.origin.y+12, bodyFrame.size.width, bodyFrame.size.height);
//        CGRect forgotPasswordFrame = self.forgotPassword.frame;
//        self.forgotPassword.frame = CGRectMake(forgotPasswordFrame.origin.x, forgotPasswordFrame.origin.y-10, forgotPasswordFrame.size.width, forgotPasswordFrame.size.height);
//    }
    


}

- (void)viewDidUnload
{
    NSLog(@"View did unload");

//    [self setLoginForegroundView:nil];
//    [self setLoginBackgroundImage:nil];
//    [self setLoginScrollView:nil];
//    [self setSkipButton:nil];
//    [self setBackButton:nil];
    [self setEmailTextField:nil];
    [self setPasswordTextField:nil];
    self.resetPasswordTextField = nil;
    [self setAnimatedBackgroundView:nil];
    [self setZodioLogoImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setupNotificationMonitoring
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(facebookSessionStateChanged:)
//                                                 name:ZFacebookSessionStateChangedNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(dismiss)
//                                                 name:TwitterLoginSuccessfulNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(dismiss)
//                                                 name:ZodioLoginSuccessfulNotification
//                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [[JGZodioCurrentUser currentUser] clearUserData];
    
//    [self setupNotificationMonitoring];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (IBAction)scrollDownToLoginPage:(id)sender {
//
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    
//    [UIView animateWithDuration:0.75 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
////        skipButton.hidden = YES;
//        backButton.hidden = YES;
//        loginScrollView.contentOffset = CGPointMake(0.0, 480.0);} 
//                     completion:^(BOOL completed){
////        skipButton.hidden = NO;
//        backButton.hidden = NO;
//                     }];
//    
////    [self.loginScrollView setContentOffset:CGPointMake(0.0, 480.0) animated:YES];
//    NSLog(@"down button pressed");
//    
//  
//
//}

//- (IBAction)scrollUpToFacebookLogin:(id)sender {
//    
//    [UIView animateWithDuration:0.75 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
////        skipButton.hidden = YES;
//        backButton.hidden = YES;
//        loginScrollView.contentOffset = CGPointMake(0.0, 0.0);} 
//                     completion:^(BOOL completed){
////                         skipButton.hidden = NO;
//                         backButton.hidden = NO;
//                     }];
//    
////    [loginScrollView setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
//    
//}

- (IBAction)navigateToLoginPage:(id)sender {

//    if ([[sender nextResponder] isEqual:self.loginForegroundViewFacebookSSO]) {
//        [self animateViewControllerFrom:self.loginForegroundViewFacebookSSO toView:self.loginForegroundViewExistingUser rightDirection:YES];
//        [self.loginForegroundViewExistingUser addSubview:self.animatedBackgroundView];
//    }
//    else {
//        [self animateViewControllerFrom:self.loginForegroundViewResetPassword toView:self.loginForegroundViewExistingUser rightDirection:NO];
//    }
//    
//    [self.loginForegroundViewExistingUser addSubview:self.animatedBackgroundView];
//    [self.loginForegroundViewExistingUser sendSubviewToBack:self.animatedBackgroundView];

}

- (IBAction)navigateToFacebookSSOPage:(id)sender {
//    [self animateViewControllerFrom:self.loginForegroundViewExistingUser toView:self.loginForegroundViewFacebookSSO rightDirection:NO];
//    [self.loginForegroundViewFacebookSSO addSubview:self.animatedBackgroundView];
//    [self.loginForegroundViewFacebookSSO sendSubviewToBack:self.animatedBackgroundView];
}

- (IBAction)navigateToResetPasswordPage:(id)sender {
//    [self animateViewControllerFrom:self.loginForegroundViewExistingUser toView:self.loginForegroundViewResetPassword rightDirection:YES];
//    [self.loginForegroundViewResetPassword addSubview:self.animatedBackgroundView];
//    [self.loginForegroundViewResetPassword sendSubviewToBack:self.animatedBackgroundView];
}



- (void)animateViewControllerFrom:(UIView *)currentView toView:(UIView *)nextView rightDirection:(BOOL)isRight {
//    nextView.center = CGPointMake((isRight) ? nextView.center.x+320 : nextView.center.x , nextView.center.y);
//    nextView.alpha = 1;
//    [UIView animateWithDuration:0.3f
//						  delay:0.0f
//						options:UIViewAnimationCurveEaseInOut
//					 animations:^{
//                         nextView.center = CGPointMake((isRight) ? nextView.center.x-320 : nextView.center.x+320, nextView.center.y);
//						 
//					 } completion:^(BOOL finished) {
////                         currentView.alpha = 0;
//					 }];
    

    
    
	//[UIView setAnimationRepeatCount:5];
//	currentView.transform = CGAffineTransformMakeScale(0.5,0.5);
   
	/*CALayer *layer = myview.layer;
	 CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
	 rotationAndPerspectiveTransform.m34 = 1.0 / -500;
	 rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 45.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
	 layer.transform = rotationAndPerspectiveTransform;
	 
	 */
//	self.myview.frame = CGRectMake((self.myview.frame.origin.x) , (self.myview.frame.origin.y), 0, 0);
//	[UIView setAnimationDidStopSelector:@selector(cleanUPcell)];

    
    
    
//    UIView *superView = currentView.superview;
//    CATransition *animation = [CATransition animation];
//    [animation setDuration:0.5];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromRight];
//    [animation setTimingFunction:[CAMediaTimingFunction   functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [[nextView layer] addAnimation:animation forKey:@"SwitchToView1"];
//	[superView addSubview:nextView];
//    [currentView removeFromSuperview];
    

    if (hardwareNumber() >= 4) {
        self.view.userInteractionEnabled = NO;
        
        UIView *current = currentView;
        
        nextView.frame = current.frame;
        
        CGFloat halfWidth = current.bounds.size.width / 2.0;
        CGFloat duration = 0.5;
        CGFloat perspective = -1.0/900.0;
        
        UIView *superView = current.superview;
        CATransformLayer *transformLayer = [[CATransformLayer alloc] init];
        transformLayer.frame = current.layer.bounds;
        
        [current removeFromSuperview];
        [transformLayer addSublayer:current.layer];
        [transformLayer addSublayer:nextView.layer];
        [superView.layer addSublayer:transformLayer];
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        CATransform3D transform = CATransform3DIdentity;
        
        
        transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
        transform = CATransform3DRotate(transform, (isRight) ? M_PI_2 : -M_PI_2, 0, 1, 0);
        transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
        
        
        nextView.layer.transform = transform;
        [CATransaction commit];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^(void) {
            [nextView.layer removeFromSuperlayer];
            nextView.layer.transform = CATransform3DIdentity;
            [current.layer removeFromSuperlayer];
            
            [superView addSubview:nextView];
            [transformLayer removeFromSuperlayer];
            
            self.view.userInteractionEnabled = YES;
        }];
        
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        
        transform = CATransform3DIdentity;
        transform.m34 = perspective;
        transformAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
        
        transform = CATransform3DIdentity;
        transform.m34 = perspective;
        
        transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
        transform = CATransform3DRotate(transform, (isRight) ? -M_PI_2 : M_PI_2, 0, 1, 0);
        transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
        
        transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
        
        transformAnimation.duration = duration;
        
        [transformLayer addAnimation:transformAnimation forKey:@"rotate"];
        transformLayer.transform = transform;
        
        [CATransaction commit];
    }
    else {
        self.view.userInteractionEnabled = NO;
        if (isRight) {
            nextView.transform = CGAffineTransformMakeScale(1.9,1.9);
            nextView.alpha = 0.1;
            [self.view addSubview:nextView];
        }
        else {
            
        }
        
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
//                             [UIView setAnimationRepeatCount:1.0];
                             // other animations here
                             if (isRight) {
                                 nextView.transform = CGAffineTransformMakeScale(1.0,1.0);
                                 nextView.alpha = 1;
                             }
                             else {
                                 currentView.transform = CGAffineTransformMakeScale(1.9,1.9);
                                 currentView.alpha = 0;
                             }
            
                         }
                         completion:^(BOOL finished){
                             // ... completion stuff
                             [self.view addSubview:nextView];
                             [currentView removeFromSuperview];
                             self.view.userInteractionEnabled = YES;
                         }
         ];
        
    }
}

- (IBAction)backgroundTap:(id)sender {
    
//    [emailTextField resignFirstResponder];
//    [passwordTextField resignFirstResponder];
//    [self.resetPasswordTextField resignFirstResponder];
    [self.view endEditing:YES];
}

//TODO: Stop using JSON Driller!
- (IBAction)doZodioLogin:(id)sender
{
    if ([emailTextField.text length] > 0 && [passwordTextField.text length] > 0)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
        //TODO: update API login
//        [[ZSessionManager sharedManager] loginWithZodioUsername:emailTextField.text password:passwordTextField.text];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"Invalid Username/Password", @"Message showed to user when they didn't enter a username or a password")];
    }

}

- (IBAction)doZodioResetPassword:(id)sender {
    
//    //TODO add user location into POST
//    userInfoForPOST = [NSDictionary dictionaryWithObjectsAndKeys:self.resetPasswordTextField.text, @"email", nil];
//    
//    NSLog(@"prepared post");
//    
//    
////    JSONPathsForZodioLogin = [NSArray arrayWithObjects:
////                              @"access_token",
////                              @"status",
////                              @"data.user_id",
////                              @"data.status",
////                              @"data.type",
////                              @"message",
////                              @"response_type", nil];
//    
//    NSString *path = [NSString stringWithFormat:@"%@%@", kAPIBasePath, kForgotPasswordPath];
//    NSMutableURLRequest *zodioLoginRequest = [[ZodioAPIClient sharedClient] requestWithMethod:@"POST" path:path parameters:userInfoForPOST];
//    
//    AFJSONRequestOperation *zodioLoginRequestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:zodioLoginRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
//                                                          {
//                                                              NSLog(@"Received raw login results: %@", JSON);
//                                                              [self requestCompletedWithStatus:ZodioStatusOK andResults:JSON requestType:nil];
//                                                              
//                                                          }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
//                                                          {
//                                                              [self requestCompletedWithStatus:ZodioStatusUnknownError andResults:JSON requestType:nil];
//                                                              NSLog(@"Login failed with status code: %d", response.statusCode);
//                                                          }];
//    
//    
//    [[ZodioAPIClient sharedClient] enqueueHTTPRequestOperation:zodioLoginRequestOperation forOwner:self];
//    
}

#pragma mark - Facebook Login Methods

- (IBAction)doFacebookLogin:(id)sender
{
    NSLog(@"Do a Login");
//    http://namjai.eu1.frbit.net/public/auth/login
    [SVProgressHUD showWithStatus:@"Loging In"];
    [[ZodioAPIClient sharedClient] doLoginWithToken:nil forOwner:self];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
//    [[JGZodioCurrentUser currentUser] clearUserData];
//    NSLog(@"Calling awesome session opener");
//    [[JGSocialCredentialManager sharedManager] myAwesomeSessionOpenerUsingUI:YES forOwner:nil];
}

- (void)facebookSessionStateChanged:(NSNotification*)notification
{
//    if ([[JGSocialCredentialManager sharedManager] facebookIsEffectivelyLoggedIn])
//    {
//        BOOL notFirstLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kFirstTimeLogin];
//        if (notFirstLogin)
//        {
//            [self dismiss];
//            
//        }
//        else
//        {
//            [self dismiss];
//            
//            //Need new tutorial
//
//        }
//    }
//    

}


- (IBAction)skipLogin:(id)sender
{
    //Let the user do the tour first, don't ask for location services or push notifications yet
//    [[ZLocationManager sharedZLocationManager] startUpdatingLocation];
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    [self dismiss];

}

- (void)dismiss
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self dismissViewControllerAnimated:YES completion:^{

    }];
    

}

//TODO remove this class if unneeded
- (void)loginSuccessful:(BOOL)status
{
    [SVProgressHUD dismiss];
    
    if (status)
    {
        NSLog(@"Login was successful");
    }
    else
    {
        NSLog(@"Login failed");
        
//        UIAlertView *loginFailedAlertView = [[UIAlertView allloc]
//                                             initWithTitle:NSLocalizedString(@"Login Failed", @"Word to use to indicate a Login Failed")
//                                             message:NSLocalizedString(@"Please re-check your username and password and try again", @"Word to use to indicate a Please re-check your username and password and try again")
//                                             delegate:self
//                                             cancelButtonTitle:NSLocalizedString(@"OK", @"Word to use to indicate a OK")
//                                             otherButtonTitles:nil, nil];
//        
//        [loginFailedAlertView show];
        
//        BlockAlertView *loginFailedAlertView = [BlockAlertView alertWithTitle:NSLocalizedString(@"Login Failed", @"Word to use to indicate a Login Failed")
//                                                                      message:NSLocalizedString(@"Please re-check your username and password and try again", @"Word to use to indicate a Please re-check your username and password and try again")];
//        [loginFailedAlertView setCancelButtonWithTitle:NSLocalizedString(@"OK", @"OK") block:nil];
        
    }
}

-(void) processTwitterLogin:(NSDictionary *)loginResponse
{
//    NSString *returnedAccessToken = [loginResponse objectForKey:kAccessTokenFieldName];
//    NSString *returnedUserID = [loginResponse objectForKey:kUserIDFieldNameFromLogin];
//    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:returnedAccessToken forKey:kAccessTokenFieldName];
//    [userDefaults setObject:returnedAccessToken forKey:kTWAccessTokenFieldName];
//    [userDefaults setObject:returnedUserID forKey:kUserIDFieldName];
//    [userDefaults setObject:@"1" forKey:kFBDisconnectedFieldName];
//    [userDefaults synchronize];
//    
// //   [[ZodioAPIClient sharedClient] getFBTokenForCurrentUser];
//    
//    [[ZLocationManager sharedZLocationManager] startUpdatingLocation];
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
//    
//    [self dismiss];
//    
 
}


#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:emailTextField] || [textField isEqual:passwordTextField]) {
        if ([textField isEqual:emailTextField]) {
            [passwordTextField becomeFirstResponder];
            return YES;
        }
        if (![emailTextField isEqual:@""] && ![passwordTextField isEqual:@""]) {
            [self doZodioLogin:self];
            [self backgroundTap:self];
        }
    
    }
    else {
        [self doZodioResetPassword:self];
        [self backgroundTap:self];
    }
    
    return YES;
}

-(void) keyboardWillShow:(NSNotification *)note{
    
    if ([UIScreen mainScreen].bounds.size.height < 568)
    {
        // get keyboard size and loctaion
        CGRect keyboardBounds;
        [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
        NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        
        // Need to translate the bounds to account for rotation.
        //    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
//        NSDictionary *info = [note userInfo];
//        NSValue *aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
//        CGSize keyboardSize = [aValue CGRectValue].size;
        
        // get a rect for the textView frame
//        CGRect containerFrame = self.view.frame;
        
        //    containerFrame.size.height = [[UIScreen mainScreen] applicationFrame].size.height - (keyboardSize.height);
        // animations settings
        
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:[duration doubleValue]];
//        [UIView setAnimationCurve:[curve intValue]];
        
        [UIView animateWithDuration:[duration doubleValue]
                              delay:0
                            options:[curve intValue]
                         animations:^{
                             
                             self.view.frame = CGRectMake(0,  -30 , self.view.frame.size.width, self.view.frame.size.height);
                             [self.zodioLogoImageView moveOriginToPoint:CGPointMake(self.zodioLogoImageView.frame.origin.x, self.zodioLogoImageView.frame.origin.y + 29)];

                         }completion:^(BOOL finished){
                             [[NSNotificationCenter defaultCenter] removeObserver:self
                                                                             name:UIKeyboardWillShowNotification
                                                                           object:nil];
                             
                             [[NSNotificationCenter defaultCenter] addObserver:self
                                                                      selector:@selector(keyboardWillHide:)
                                                                          name:UIKeyboardWillHideNotification
                                                                        object:nil];
                         }];
        
//        self.view.frame = CGRectMake(0, self.view.frame.origin.y - 30 , self.view.frame.size.width, self.view.frame.size.height);
        
//        [UIView commitAnimations];
    }
}

-(void) keyboardWillHide:(NSNotification *)note{
    
    if ([UIScreen mainScreen].bounds.size.height < 568)
    {        
        NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        //	CGRect keyboardBounds;
        // Need to translate the bounds to account for rotation.
        //    NSDictionary *info = [note userInfo];
        //    NSValue *aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
        //    CGSize keyboardSize = [aValue CGRectValue].size;
        //    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
        
        // get a rect for the textView frame
//        CGRect containerFrame = self.view.frame;
        
//        containerFrame.size.height = [[UIScreen mainScreen] applicationFrame].size.height;
        
        // animations settings
        
//         [UIView beginAnimations:nil context:NULL];
//         [UIView setAnimationBeginsFromCurrentState:YES];
//         [UIView setAnimationDuration:[duration doubleValue]];
//         [UIView setAnimationCurve:[curve intValue]];
        
        [UIView animateWithDuration:[duration doubleValue]
                              delay:0
                            options:[curve intValue]
                         animations:^{
                             
                             [self.zodioLogoImageView moveOriginToPoint:CGPointMake(self.zodioLogoImageView.frame.origin.x, self.zodioLogoImageView.frame.origin.y - 29)];
                             self.view.frame = CGRectMake(0, kStatusBarHeight, self.view.frame.size.width, self.view.frame.size.height);
                             
                         }completion:^(BOOL finished){
                             [[NSNotificationCenter defaultCenter] removeObserver:self
                                                                             name:UIKeyboardWillHideNotification
                                                                           object:nil];
                             
                             [[NSNotificationCenter defaultCenter] addObserver:self
                                                                      selector:@selector(keyboardWillShow:)
                                                                          name:UIKeyboardWillShowNotification
                                                                        object:nil];
                         }];
         
         // set views with new info
//         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
//         [UIView commitAnimations];
        
    }

}

- (void)requestCompletedWithStatus:(NSInteger)statusOK andResults:(NSMutableDictionary *)value requestType:(NSString *)requestType {
    if ([requestType isEqual: kAPIClientRequestTypeFacebook] && statusOK == StatusOK) {
        [SVProgressHUD showSuccessWithStatus:@"Login Success!"];
       [self dismiss];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"Login Failed!"];        
    }

}

- (void)requestType:(NSString *)request failedWithError:(NSError *)error andData:(id)JSON
{
    
}


//twitter Methods
- (void)showAlert:(NSString *)alert title:(NSString *)title
{
    //  This can be triggered from different threads, ensure that we keep it on the main queue
    dispatch_async(dispatch_get_main_queue(), ^{
        POP_ALERT(title, alert);
    });
}

- (BOOL)_checkForKeys
{
    BOOL resp = YES;
    
//    if (![TWSignedRequest consumerKey] || ![TWSignedRequest consumerSecret]) {
//        [self showAlert:@"You must add reverse auth-enabled keys to TWSignedRequest.m" title:nil];
//        resp = NO;
//    }
   // [hud hide:YES];
    return resp;
}

- (BOOL)_checkForLocalCredentials
{
    BOOL resp = YES;
    
//    if (![TWTweetComposeViewController canSendTweet]) {
//        [self showAlert:@"Please configure a Twitter account in Settings." title:@"Yikes"];
//        resp = NO;
//    }
    //[hud hide:YES];
    return resp;
}
//Twitter IBAction
- (IBAction)loginWithTwitter:(id)sender
{
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
//    [[JGSocialCredentialManager sharedManager] loginWithTwitter];

}

- (IBAction)zodioSignupWithEmail:(id)sender
{
//    JGZodioSignupViewController *signupViewController = [JGFormFactory signupWithEmailForm];
//    signupViewController.parentLoginViewController = self;
//    
//    ZNavigationController *signupNav = [ZRootViewController customizedNavigationController];
//    [signupNav setViewControllers:[NSArray arrayWithObject:signupViewController]];
//    
    
//    [self presentSemiViewController:signupNav withOptions:@{
//     KNSemiModalOptionKeys.pushParentBack    : @(YES),
//     KNSemiModalOptionKeys.animationDuration : @(2.0),
//     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
//	 }];
    
//    [self presentSemiViewController:signupNav];
    
//    [self presentModalViewController:signupNav animated:YES];
    //    [self.viewDeckController presentViewController:signupViewController animated:YES completion:nil];
    
    
}


//- (void)performReverseAuth:(id)sender
//{
//        //  Check to make sure that the user has added his credentials
//    if ([self _checkForKeys] && [self _checkForLocalCredentials]) {
//        //
//        //  Step 1)  Ask Twitter for a special request_token for reverse auth
//        //
//        NSURL *url = [NSURL URLWithString:TW_OAUTH_URL_REQUEST_TOKEN];
//        
//        // "reverse_auth" is a required parameter
//        NSDictionary *dict = [NSDictionary dictionaryWithObject:TW_X_AUTH_MODE_REVERSE_AUTH forKey:TW_X_AUTH_MODE_KEY];
//        TWSignedRequest *signedRequest = [[TWSignedRequest alloc] initWithURL:url parameters:dict requestMethod:TWSignedRequestMethodPOST];
//        
//        
//        [signedRequest performRequestWithHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            if (!data) {
//                [self showAlert:@"Unable to receive a request_token." title:nil];
//                [self _handleError:error forResponse:response];
//            }
//            else {
//                NSString *signedReverseAuthSignature = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                //   NSLog(@"ReverseAuthSign:%@", signedReverseAuthSignature);
//                //
//                //  Step 2)  Ask Twitter for the user's auth token and secret
//                //           include x_reverse_auth_target=CK2 and x_reverse_auth_parameters=signedReverseAuthSignature parameters
//                //
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    
//                    NSDictionary *step2Params = [NSDictionary dictionaryWithObjectsAndKeys:[TWSignedRequest consumerKey], TW_X_AUTH_REVERSE_TARGET, signedReverseAuthSignature, TW_X_AUTH_REVERSE_PARMS, nil];
//                    NSURL *authTokenURL = [NSURL URLWithString:TW_OAUTH_URL_AUTH_TOKEN];
//                    TWRequest *step2Request = [[TWRequest alloc] initWithURL:authTokenURL parameters:step2Params requestMethod:TWRequestMethodPOST];
//                    
//                    //  Obtain the user's permission to access the store
//                    //
//                    
//                    self.accountStore = [[ACAccountStore alloc] init];
//                    ACAccountType *twitterType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
//                    
//                    [self.accountStore requestAccessToAccountsWithType:twitterType withCompletionHandler:^(BOOL granted, NSError *error) {
//                        if (!granted) {
//                            [self showAlert:@"User rejected access to his/her account." title:@""];
//                        }
//                        else {
//                            // obtain all the local account instances
//                            NSArray *accounts = [self.accountStore accountsWithAccountType:twitterType];
//                            
//                            // we can assume that we have at least one account thanks to +[TWTweetComposeViewController canSendTweet], let's return it
//                            [step2Request setAccount:[accounts objectAtIndex:0]];
//                            [step2Request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
//                                // Thanks to Marc Delling for pointing out that we should check the status code below
//                                if (!responseData || ((NSHTTPURLResponse*)response).statusCode >= 400) {
//                                    
//                                    [self _handleError:error forResponse:response];
//                                }
//                                else {
//                                    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//                                    [self _handleStep2Response:responseStr];
//                                }
//                            }];
//                        }
//                    }];
//                });
//            }
//        }];
//    }
//}

//- (void)_handleError:(NSError *)error forResponse:(NSURLResponse *)response
//{
//    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
//    
//    NSLog(@"[Error]: %@", [error localizedDescription]);
//    NSLog(@"[Error]: Response Code:%d \"%@\" ", [urlResponse statusCode], [NSHTTPURLResponse localizedStringForStatusCode:[urlResponse statusCode]]);
//    
//   }

//#define RESPONSE_EXPECTED_SIZE 4
//- (void)_handleStep2Response:(NSString *)responseStr
//{
//    
//    NSDictionary *dict = [NSURL ab_parseURLQueryString:responseStr];
//    // NSLog(@"twitter credentials: %@", dict);
//    
//    if ([dict count] == RESPONSE_EXPECTED_SIZE) {
//        self.twitterLoginInfo = [NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:kTWOauthToken], @"tw_token", [dict valueForKey:kTWOauthTokenSecret], @"tw_token_secret",[dict valueForKey:kTWScreenName], @"tw_screen_name",[dict valueForKey:kTWUserID], @"tw_id", nil];
//        
//        
//        NSDictionary *twitterInfoForPOST  = [NSDictionary dictionaryWithObjectsAndKeys:[dict valueForKey:kTWOauthToken], @"tw_token", [dict valueForKey:kTWOauthTokenSecret], @"tw_token_secret",kZodioAPIDeviceID,kZodioAPIDeviceIDFieldName, @"iphone", kLoginClientSecretFieldName, kAPIkey ,kAPIKeyFieldName,  nil];
//        
//        
//        
//        //   JSONPathsForZodioLogin = [NSArray arrayWithObjects:@"access_token", @"status", @"data.user_id", @"data.status", @"data.type", @"message", @"response_type", nil];
//        
//        NSLog(@"prepared JSON paths");
//        
//        JSONPathsForTwitterRegistration = [NSArray arrayWithObjects:@"data.first_time_log_in",@"data.message", @"response_type", nil];
//        JSONPathForTwitterLogin = [NSArray arrayWithObjects:@"access_token",@"data.user_id", @"message", @"first_fb_sign_in" ,nil];
//        
//        JSONPathsForZodioLogin = [NSArray arrayWithObjects:
//                                  @"access_token",
//                                  @"status",
//                                  @"data.user_id",
//                                  @"data.status",
//                                  @"data.type",
//                                  @"message",
//                                  @"response_type", nil];
//        
//        [loginZodioAPIClient postPath:@"v141/external/twlogin.php" parameters:twitterInfoForPOST
//                              success:^(AFHTTPRequestOperation *operation, id JSON)
//         
//         {
//             
//             
//             NSDictionary *resultsdictionary = [[NSDictionary alloc]initWithDictionary:JSON];
//             
//              NSLog(@"Json response: %@", resultsdictionary);
//             if (resultsdictionary != nil && ![resultsdictionary isEqual:[NSNull null]] && [resultsdictionary isKindOfClass:[NSDictionary class]] && [[resultsdictionary objectForKey:@"data"] objectForKey:@"first_time_log_in"] && [[[resultsdictionary objectForKey:@"data"] objectForKey:@"message"]isEqualToString:@"redirect to register page"])
//             {
//                 [self openRegistrationView];
//             }
//             else
//                 if ([resultsdictionary objectForKey:[JSONPathForTwitterLogin objectAtIndex:0]] && [[resultsdictionary objectForKey:@"message"] isEqualToString:@"Login success"])
//                     
//                 {
//                     
//                     NSLog(@" Json response Twitter_login: %@", resultsdictionary);
//                     
//                     NSMutableDictionary *loginResultsToProcess = [[NSMutableDictionary alloc] init];
//                     
//        
//                     
//                     for (NSString *key in JSONPathsForZodioLogin)
//                     {
//                         [loginResultsToProcess setObject:[resultsdictionary valueForKeyPath:key] forKey:key];
//                     }
//                     [[JGSocialCredentialManager sharedManager] processTwitterLogin:loginResultsToProcess];
//                     
//                     [self dismiss];
//                 }
//             
//         }
//                              failure:^(AFHTTPRequestOperation *operation, NSError *loginError)
//         {
//             NSLog(@"Request failed with error: %@, %@", loginError, loginError.userInfo);
//             //[self loginSuccessful:NO];
//         }];
//        
//    }
//    
//}

//-(void)registerTwitterAccountWithParams:(NSDictionary *)twitterInfoDict
//{
//    [loginZodioAPIClient postPath:@"v141/external/mobile_signup.php" parameters:twitterInfoDict
//                          success:^(AFHTTPRequestOperation *operation, id JSON)
//     
//     {
//         
//         NSLog(@"success: JSON: %@", JSON);
//         [twitterRegisterViewController dismissModalViewControllerAnimated:YES];
//         [self performReverseAuth:0];
//     }
//                          failure:^(AFHTTPRequestOperation *operation, NSError *loginError)
//     {
//         NSLog(@"Request failed with error: %@,Info: %@", operation.responseData, loginError.userInfo);
//         
//     
//         NSDictionary* errorDict = (NSDictionary*)[operation.responseData objectFromJSONData];
//         NSLog(@"Error Dict: %@", errorDict);
////         UIAlertView *alert = [[UIAlertView allloc]initWithTitle:@"Error" message:[errorDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
////         [alert show];
//         
//         BlockAlertView *alert = [BlockAlertView alertWithTitle:NSLocalizedString(@"Error", @"Error") message:[errorDict safeObjectForKey:@"message"]];
//         [alert setCancelButtonWithTitle:@"OK" block:nil];
//         [alert show];
//         
//     }];
//}

#pragma mark- ZTwitterRegistration Delegate method
//-(void)sendRegisterParams: (NSDictionary *) twitterParameters
//{
//    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:twitterParameters];
//    [dictionary addEntriesFromDictionary:twitterLoginInfo];
//     NSDictionary *twitterAddInfo  = [NSDictionary dictionaryWithObjectsAndKeys:kZodioAPIDeviceID,kZodioAPIDeviceIDFieldName, @"iphone", kLoginClientSecretFieldName, kAPIkey ,kAPIKeyFieldName,  nil];
//    [dictionary addEntriesFromDictionary:twitterAddInfo];
//    NSLog(@"dictionary : %@", dictionary);
//    
//    [self registerTwitterAccountWithParams:dictionary];
//}
@end
     

