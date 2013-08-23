//
//  LoginViewController.h
//  testTabApp
//
//  Created by Jai Govindani on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZViewController.h"

@class KenBurnsView;

@interface LoginViewController : ZViewController <UIScrollViewDelegate, UITextFieldDelegate, ZodioAPIClientDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *resetPasswordTextField;

@property (strong, nonatomic) IBOutlet UIView *loginForegroundViewFacebookSSO;
@property (strong, nonatomic) IBOutlet UIView *loginForegroundViewExistingUser;
@property (strong, nonatomic) IBOutlet UIView *loginForegroundViewResetPassword;

@property (weak, nonatomic) IBOutlet KenBurnsView *animatedBackgroundView;
@property (nonatomic, retain) NSDictionary *twitterLoginInfo;
@property (weak, nonatomic) IBOutlet UIImageView *zodioLogoImageView;


- (IBAction)backgroundTap:(id)sender;

- (IBAction)doZodioLogin:(id)sender;
- (IBAction)doFacebookLogin:(id)sender;
- (IBAction)loginWithTwitter:(id)sender;
- (IBAction)zodioSignupWithEmail:(id)sender;

- (IBAction)skipLogin:(id)sender;
- (void)loginSuccessful:(BOOL)status;

- (IBAction)navigateToLoginPage:(id)sender;
- (IBAction)navigateToFacebookSSOPage:(id)sender;
- (IBAction)navigateToResetPasswordPage:(id)sender;
- (void)animateViewControllerFrom:(UIView *)currentView toView:(UIView *)nextView rightDirection:(BOOL)isRight;
@end
