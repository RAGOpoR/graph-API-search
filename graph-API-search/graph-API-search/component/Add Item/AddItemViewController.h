//
//  AddItemViewController.h
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/24/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddItemViewController : ZViewController <MKMapViewDelegate, UIGestureRecognizerDelegate> {
    CLLocationCoordinate2D _selectedLocation;
    BOOL _locationSelected;
    UITapGestureRecognizer *_mapTapRecognizer;
    UIPanGestureRecognizer *_mapPanRecognizer;
    BOOL _mapFocusedOnUserLocation;
    MKMapView *_locationSelectorMapView;
}

//@property (strong, nonatomic) MKMapView *locationSelectorMapView;
@property (nonatomic) CLLocationCoordinate2D selectedLocation;
@property (nonatomic) BOOL locationSelected;
@property (strong, nonatomic) UITapGestureRecognizer *mapTapRecognizer;
@property (strong, nonatomic) UIPanGestureRecognizer *mapPanRecognizer;

@property (nonatomic) BOOL mapFocusedOnUserLocation;

- (void)mapTapped:(UIGestureRecognizer*)gestureRecognizer;
- (void)mapPanned:(UIGestureRecognizer*)gestureRecognizer;

@property (nonatomic, strong) IBOutlet UITextView *inputTextField;
@property (nonatomic, strong) IBOutlet MKMapView *locationSelectorMapView;

@end
