//
//  ZAddPlaceLocationSelector.m
//  ZodioJai
//
//  Created by Jai Govindani on 9/18/12.
//
//

#import "ZAddPlaceLocationSelector.h"

@interface ZAddPlaceLocationSelector ()

@end

@implementation ZAddPlaceLocationSelector

@synthesize delegate;
@synthesize locationSelectorMapView;
@synthesize selectedLocation;
@synthesize mapTapRecognizer;
@synthesize locationSelected;
@synthesize mapPanRecognizer;
@synthesize mapFocusedOnUserLocation;
@synthesize recenterMapButton;

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
    
//    self.title = NSLocalizedString(@"Location", @"Location Navigation Title") ;
    
    UIView *instructionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    instructionView.backgroundColor = [UIColor blackColor];
    instructionView.alpha = 0.5;
    
    UILabel *instructionViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 40)];
    instructionViewLabel.backgroundColor = [UIColor clearColor];
    instructionViewLabel.textColor = [UIColor whiteColor];
    instructionViewLabel.font = [UIFont boldSystemFontOfSize:13];
    [instructionViewLabel setText:NSLocalizedString(@"Tap the map to select a location",@"suggestion word Tap the map for select a location")];
    
    _textInput = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];//[[UITextField alloc] initWithFrame:CGRectMake(100, 100, 320, 30)];
    _textInput.delegate = self;
    
    
    recenterMapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [recenterMapButton setBackgroundImage:[UIImage imageNamed:@"RecenterMap.png"] forState:UIControlStateNormal];
    [recenterMapButton setFrame:CGRectMake(285, 5, 31, 31)];
    [recenterMapButton addTarget:self action:@selector(recenterMap:) forControlEvents:UIControlEventTouchUpInside];
//    CGRect screenBound = [[UIScreen mainScreen] bounds];
//    CGFloat expectScreenHeight = screenBound.size.height - kSumOfStatusBarAndNavigationBarAndTabBar;
    self.locationSelectorMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [self.view addSubview:self.locationSelectorMapView];
    [self.view addSubview:instructionView];
    [self.view addSubview:instructionViewLabel];
    [self.view addSubview:_textInput];
    [self.view addSubview:recenterMapButton];
    
    
    if (locationSelected == YES)
    {
        self.locationSelectorMapView.centerCoordinate = self.selectedLocation;
        
        [self.locationSelectorMapView setRegion:MKCoordinateRegionMakeWithDistance(self.selectedLocation, 1000, 1000)];
        
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
                
        MKPointAnnotation *selectedLocationAnnotation = [[MKPointAnnotation alloc] init];
        selectedLocationAnnotation.coordinate = self.selectedLocation;
        [self.locationSelectorMapView addAnnotation:selectedLocationAnnotation];
        
    }
    else
    {
        [self recenterMap:self];
    }
    
    self.locationSelectorMapView.showsUserLocation = YES;
    
    mapTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mapTapped:)];
    mapPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(mapPanned:)];
    
    mapTapRecognizer.delegate = self;
    mapPanRecognizer.delegate = self;
    
    
    [self.locationSelectorMapView addGestureRecognizer:self.mapTapRecognizer];
    [self.locationSelectorMapView addGestureRecognizer:self.mapPanRecognizer];
    
    [self setupNextButtonWithImageName:@"plusIcon.png" andHilightedImageName:@"plusIcon-hl.png" withImageWidth:36 andImageHeight:32];
    [self setupBackButtonWithImageName:@"reject" andHilightedImageName:nil withImageWidth:36 andImageHeight:32];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    
    [self setupLeftCancelButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapTapped:(UIGestureRecognizer*)gestureRecognizer
{

        //DDLogVerbose(@"Map tapped");
    
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
        selectedLocation = [self.locationSelectorMapView convertPoint:touchPoint toCoordinateFromView:self.locationSelectorMapView];
        
        MKPointAnnotation *selectedLocationAnnotation = [[MKPointAnnotation alloc] init];
        selectedLocationAnnotation.coordinate = self.selectedLocation;
        [self.locationSelectorMapView addAnnotation:selectedLocationAnnotation];
        
        [self.delegate locationSelected:self.selectedLocation];
        self.locationSelected = YES;
}

- (void)mapPanned:(UIGestureRecognizer*)gestureRecognizer
{
    if (mapFocusedOnUserLocation == YES)
    {
        [self.recenterMapButton setBackgroundImage:[UIImage imageNamed:@"RecenterMap.png"] forState:UIControlStateNormal];
        mapFocusedOnUserLocation = NO;
    }
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

- (void)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)nextButtonPress {
    NSString *latAndLongAsString = [NSString stringWithFormat:@"%f,%f",self.selectedLocation.latitude,self.selectedLocation.longitude];
    [SVProgressHUD showWithStatus:@"Posting..."];
    [[ZodioAPIClient sharedClient] createTicketWithString:_textInput.text andLocation:latAndLongAsString forOwner:(id<ZodioAPIClientDelegate>)self];
}

- (void)backButtonPress {
    
}

#pragma mark APIClient

- (void)requestCompletedWithStatus:(NSInteger)status andResults:(NSMutableDictionary *)results requestType:(NSString *)requestType {
    
    if (status == StatusOK) {
        if ([requestType isEqualToString:kAPIClientRequestTypeCreateTicket]) {
            [SVProgressHUD showSuccessWithStatus:@"Done!!"];
            //            [self.dataSource processJSONArray:[results objectForKey:@"data"]];
            //            [self.tableView reloadData];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
        
    }
    else if (status == StatusNoResultsError) {
        [SVProgressHUD dismiss];
    }
}

- (void)requestType:(NSString *)request failedWithError:(NSError *)error andData:(id)JSON {
    [SVProgressHUD showErrorWithStatus:@"Failed"];
}
@end
