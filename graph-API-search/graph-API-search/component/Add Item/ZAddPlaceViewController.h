//
//  ZAddPlaceViewController.h
//  ZodioJai
//
//  Created by Jai Govindani on 9/18/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#include "ZAddPlaceLocationSelector.h"
#import "PrettyKit.h"


typedef enum {
    kAddPlaceEditingModeAdd,
    kAddPlaceEditingModeEdit
} kAddPlaceEditingMode;

@class JGBusiness;

@protocol AddPlaceDelegate <NSObject>

@optional
- (void)placeAddedWithID:(NSString *)place;
- (void)businessAdded:(JGBusiness*)business;
- (void)placeDataUpdated;

@end


@interface ZAddPlaceViewController : ZViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate, LocationSelectorDelegate, UITextFieldDelegate, ZodioAPIClientDelegate>
{
//    JGBusiness *_business;
    kAddPlaceEditingMode _editingMode;
    NSString *_businessName;
}

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UITableView *addBusinessTableView;
@property (strong, nonatomic) IBOutlet PrettyCustomViewTableViewCell *addBusinessTableViewMapCell;
@property (strong, nonatomic) IBOutlet MKMapView *addBusinessMapCellMap;
@property (strong, nonatomic) IBOutlet UIView *mapInstructionView;
@property (strong, nonatomic) IBOutlet UIView *mapContainerView;


@property (strong, nonatomic) IBOutlet PrettyTableViewCell *addBusinessTableViewNameCell;
@property (strong, nonatomic) IBOutlet UITextField *nameCellTextField;

@property (strong, nonatomic) IBOutlet PrettyTableViewCell *addBusinessTableViewCategoryCell;
@property (strong, nonatomic) IBOutlet UILabel *categoryCellCategoryLabel;

@property (strong, nonatomic) IBOutlet PrettyTableViewCell *addBusinessTableViewAddressCell;
@property (strong, nonatomic) IBOutlet UILabel *addressCellAddressLabel;

@property (strong, nonatomic) NSString *businessName;

@property (strong, nonatomic) NSString *businessCategory;
@property (nonatomic) BOOL categorySelected;

@property (strong, nonatomic) NSMutableDictionary *businessAddressInfo;
@property (nonatomic) BOOL businessAddressEntered;

@property (nonatomic) CLLocationCoordinate2D businessLocation;
@property (strong, nonatomic) NSString *businessLocationPlacemarkAsJSONString;
@property (nonatomic) BOOL businessLocationSelected;

@property (strong, nonatomic) JGBusiness *business;
@property (nonatomic) kAddPlaceEditingMode editingMode;

/*!
 @abstract Used to add a place after a search returned with no results.  The name passed is automatically added to the name textbox, giving users 1 less step to do.
 @param name Name of the place to add - automatically populated into the name textfield
 */
- (id)initForAddingPlaceWithName:(NSString *)name;

/*!
 @abstract Inits the view controller in editing mode
 @param business The business to edit
 */
- (id)initForEditingBusiness:(JGBusiness*)business;

//- (void)pushNextLevel;
- (void)addressCellSelected;
- (IBAction)backgroundTap:(id)sender;

- (void)drawMapCell;

//Data return methods
- (void)categorySelected:(NSString *)category;
- (void)locationSelected:(CLLocationCoordinate2D)location;

- (void)addPlace;

- (void)reverseGeocodeBusinessLocation;
- (BOOL)websiteValidationPassed;

@end
