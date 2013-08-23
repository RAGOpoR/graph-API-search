//
//  ZViewController.h
//  ZodioJai
//
//  Created by Jai Govindani on 4/13/13.
//
//

#import <UIKit/UIKit.h>
//#import "GAITrackedViewController.h"

@interface ZViewController : UIViewController {

    BOOL _awesomeMenuDisabled;
    BOOL _footerPopupViewEnabled;
    BOOL _tutorialShown;
    BOOL _navigationBarHidden;
}

//@property (strong, nonatomic) AwesomeMenu *awesomeMenu;
@property (nonatomic) BOOL awesomeMenuDisabled;
@property (nonatomic) BOOL footerPopupViewEnabled;
@property (nonatomic) BOOL tutorialShown;
@property (nonatomic) BOOL navigationBarHidden;

/*!
 @abstract Clears all progress HUDs, fullscreen error views, and tableview animations - infinite scrolling and pull to refresh
 */
- (void)clearProgressAndErrorViews;

/*!
 @abstract Clears all HUDs - ZProgressHUD and SVProgressHUD
 */
- (void)dismissHUD;

/*!
 @abstract Checks if the current user is logged in and if not, triggers the login page
 */
- (BOOL)userIsLoggedIn;

/*!
 @abstract Presents the login page as a modal view controller
 */
- (void)showLoginPage;

- (void)setupNextButtonWithImageName:(NSString*)defaultImageName andHilightedImageName:(NSString*)hilightedImageName withImageWidth:(float)width andImageHeight:(float)height;
- (void)setupLeftCancelButtonItem;

@end
