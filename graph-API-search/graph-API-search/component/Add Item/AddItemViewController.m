//
//  AddItemViewController.m
//  graph-API-search
//
//  Created by Siam Wannakosit on 8/24/13.
//  Copyright (c) 2013 Siam Wannakosit. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

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
    // Do any additional setup after loading the view from its nib.
    [self setupNextButtonWithImageName:@"plusIcon.png" andHilightedImageName:@"plusIcon-hl.png" withImageWidth:36 andImageHeight:32];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    
    [self setupLeftCancelButtonItem];
    _mapTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped:)];
    _mapTapRecognizer.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)nextButtonPress {
    [SVProgressHUD showWithStatus:@"Posting..."];
    [[ZodioAPIClient sharedClient] createTicketWithString:@"" andLocation:@"" forOwner:(id<ZodioAPIClientDelegate>)self];
}

#pragma mark APIClient

- (void)requestCompletedWithStatus:(NSInteger)status andResults:(NSMutableDictionary *)results requestType:(NSString *)requestType {
    
    if (status == StatusOK) {
        if ([requestType isEqualToString:kAPIClientRequestTypeCreateTicket]) {
            [SVProgressHUD showSuccessWithStatus:@"Done!!"];
//            [self.dataSource processJSONArray:[results objectForKey:@"data"]];
//            [self.tableView reloadData];
            
        }
        
    }
    else if (status == StatusNoResultsError) {
        [SVProgressHUD dismiss];
    }
}

- (void)requestType:(NSString *)request failedWithError:(NSError *)error andData:(id)JSON {
    [SVProgressHUD showErrorWithStatus:@"Failed"];
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)mapTapped:(UIGestureRecognizer*)gestureRecognizer
{
    
    for (id <MKAnnotation> currentAnnotation in self.locationSelectorMapView.annotations)
    {
        if ([currentAnnotation isKindOfClass:[MKUserLocation class]])
        {
            
        }
        else
        {
            [self.locationSelectorMapView removeAnnotation:currentAnnotation];
        }
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.locationSelectorMapView];
    _selectedLocation = [self.locationSelectorMapView convertPoint:touchPoint toCoordinateFromView:self.locationSelectorMapView];
    
    MKPointAnnotation *selectedLocationAnnotation = [[MKPointAnnotation alloc] init];
    selectedLocationAnnotation.coordinate = self.selectedLocation;
    [self.locationSelectorMapView addAnnotation:selectedLocationAnnotation];
    
//    [self.delegate locationSelected:self.selectedLocation];
    self.locationSelected = YES;
}

- (void)mapPanned:(UIGestureRecognizer*)gestureRecognizer
{
//    if (_mapFocusedOnUserLocation == YES)
//    {
//        [self.recenterMapButton setBackgroundImage:[UIImage imageNamed:@"RecenterMap.png"] forState:UIControlStateNormal];
//        _mapFocusedOnUserLocation = NO;
//    }
}

- (void)recenterMap:(id)sender
{
    //    [self.locationSelectorMapView setCenterCoordinate:[[ZLocationManager sharedZLocationManager] currentLocation].coordinate animated:YES];
    //
    //    if (locationSelected == NO)
    //    {
    //        [self.locationSelectorMapView setRegion:MKCoordinateRegionMakeWithDistance([[ZLocationManager sharedZLocationManager] currentLocation].coordinate, 1000, 1000)];
    //    }
    //
    //    [self.recenterMapButton setBackgroundImage:[UIImage imageNamed:@"RecenterMapActive.png"] forState:UIControlStateNormal];
    //
    //    mapFocusedOnUserLocation = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
