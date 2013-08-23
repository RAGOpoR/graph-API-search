//
//  ZAddPlaceLocationSelector.h
//  ZodioJai
//
//  Created by Jai Govindani on 9/18/12.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@protocol LocationSelectorDelegate <NSObject>

- (void)locationSelected:(CLLocationCoordinate2D)location;

@end

@interface ZAddPlaceLocationSelector : ZViewController <MKMapViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) MKMapView *locationSelectorMapView;
@property (nonatomic) CLLocationCoordinate2D selectedLocation;
@property (nonatomic) BOOL locationSelected;
@property (strong, nonatomic) UITapGestureRecognizer *mapTapRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *mapPanRecognizer;

@property (strong, nonatomic) UIButton *recenterMapButton;
@property (nonatomic) BOOL mapFocusedOnUserLocation;
@property (nonatomic, strong) UITextView *textInput;

- (void)mapTapped:(UIGestureRecognizer*)gestureRecognizer;
- (void)mapPanned:(UIGestureRecognizer*)gestureRecognizer;
- (IBAction)recenterMap:(id)sender;

@end
