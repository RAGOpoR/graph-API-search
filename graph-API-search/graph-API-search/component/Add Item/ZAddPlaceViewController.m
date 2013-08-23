//
//  ZAddPlaceViewController.m
//  ZodioJai
//
//  Created by Jai Govindani on 9/18/12.
//
//

#import "ZAddPlaceViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "JSONKit.h"

#import "ZAddPlaceLocationSelector.h"
//#import "JGBusiness.h"

@interface ZAddPlaceViewController ()

@end

@implementation ZAddPlaceViewController

@synthesize addBusinessTableView;
@synthesize addBusinessTableViewMapCell;
@synthesize addBusinessMapCellMap;
@synthesize addBusinessTableViewNameCell;
@synthesize nameCellTextField;
@synthesize addBusinessTableViewCategoryCell;
@synthesize categoryCellCategoryLabel;
@synthesize addBusinessTableViewAddressCell;
@synthesize addressCellAddressLabel;
//@synthesize businessName;
@synthesize businessCategory;
@synthesize businessAddressInfo;
@synthesize businessLocation;
@synthesize businessLocationSelected;
@synthesize businessAddressEntered;
@synthesize categorySelected;
@synthesize delegate;
@synthesize businessLocationPlacemarkAsJSONString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initForAddingPlaceWithName:(NSString *)name
{
    self = [super initWithNibName:@"ZAddPlaceViewController" bundle:nil];
    
    if (self)
    {
        self.businessName = name;
    }
    
    return self;

}

- (id)initForEditingBusiness:(JGBusiness*)business
{
    self = [super initWithNibName:@"ZAddPlaceViewController" bundle:nil];
    
    if (self)
    {
//        self.business = [business copy];
        self.editingMode = kAddPlaceEditingModeEdit;
        
    }
    
    return self;
}

//- (void)setBusiness:(JGBusiness *)business
//{
//    _business = business;
//    
////    self.editingMode = kAddPlaceEditingModeEdit;
//    
//    if (_business.category)
//    {
//        [self categorySelected:[[ZodioAPIClient sharedClient] categoryKeywordForFullName:_business.category]];
//    }
//    
//    if (_business.coordinate.latitude != 0 && _business.coordinate.longitude != 0)
//    {
//        [self locationSelected:_business.coordinate];
//    }
//    
//    if (_business.displayAddress && [_business.displayAddress count] > 0)
//    {
//        [self addressEntered:[NSMutableDictionary dictionaryWithObject:
//                              [_business.displayAddress objectAtIndex:0]
//                                                                forKey:kAddPlaceStreetAddressFieldName]];
//        [self.addressCellAddressLabel setText:[_business.displayAddress safeObjectAtIndex:0]];
//    }
//
//}
//
//- (void)setBusinessName:(NSString *)businessName
//{
//    _businessName = businessName;
//    
//    if (!self.business)
//    {
//        self.business = [[JGBusiness alloc] init];
//        self.business.name = _businessName;
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.awesomeMenuDisabled = YES;
    // Do any additional setup after loading the view from its nib.
//    self.title = NSLocalizedString(@"Add a Place",@"Add a Place Navigation title");
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kZodioBackgroundTexture]];
    
    UIView *tableViewBackground = [[UIView alloc] initWithFrame:self.addBusinessTableView.frame];
//    tableViewBackground.backgroundColor = kZodioColorGray;
    self.addBusinessTableView.backgroundView = tableViewBackground;
    
//    self.addBusinessTableView.backgroundColor = kZodioColorGray;
    self.addBusinessTableView.clipsToBounds = YES;
    self.addBusinessTableView.layer.masksToBounds = YES;
    
//    UIBarButtonItem *addPlaceButton = [JGBarButtonItemFactory barButtonItemWithTitle:NSLocalizedString(@"Submit", @"Submit")];
//    [((UIButton*)addPlaceButton.customView) addTarget:self action:@selector(addPlace) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = addPlaceButton;
    [self setupNextButtonWithImageName:@"plusIcon.png" andHilightedImageName:@"plusIcon-hl.png" withImageWidth:36 andImageHeight:32];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:@"UITextFieldTextDidChangeNotification" object:nil];
    
//    [[ZodioAPIClient sharedClient] getAddBusinessCategoryStructure];
    
//    UIBarButtonItem *cancelButton = [JGBarButtonItemFactory barButtonItemWithTitle:NSLocalizedString(@"Cancel", @"Cancel")];
//    [((UIButton*)cancelButton.customView) addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = cancelButton;

    [self setupLeftCancelButtonItem];
//    if (self.businessName)
//    {
//        [self.nameCellTextField setText:self.businessName];
//    }
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    //need to add this call otherwise the map won't show the annotation for the business. Map is loaded after init.
    if (self.editingMode == kAddPlaceEditingModeEdit)
    {
//        [self locationSelected:self.business.coordinate];
    }
    


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    


}

- (void)ZViewDidAppear
{
    [self.view endEditing:YES];
}

- (void)ZViewWillDisappear
{
    [self.view endEditing:YES];
    

}

- (void)viewDidUnload {
    
    DDLogVerbose(@"View did unload");

    [self setAddBusinessTableView:nil];
    [self setAddBusinessTableViewMapCell:nil];
    [self setAddBusinessMapCellMap:nil];
    [self setAddBusinessTableViewNameCell:nil];
    [self setAddBusinessTableViewCategoryCell:nil];
    [self setNameCellTextField:nil];
    [self setCategoryCellCategoryLabel:nil];
    [self setAddBusinessTableViewAddressCell:nil];
    [self setAddressCellAddressLabel:nil];
    [self setMapInstructionView:nil];
    [self setMapContainerView:nil];
    [super viewDidUnload];
}

#pragma mark - 
#pragma mark - Zodio API Client Delegate Methods

- (void)requestType:(NSString *)request failedWithError:(NSError *)error andData:(id)JSON
{
//    [SVProgressHUD showErrorWithStatus:svProgressHudErrorMessage];
}

- (void)requestCompletedWithStatus:(NSInteger)status andResults:(NSMutableDictionary *)results requestType:(NSString *)requestType
{
    if ([requestType caseInsensitiveCompare:kZodioAPIClientRequestTypeAddPlace] == 0)
    {
        if (status == StatusOK)
        {
//            [SVProgressHUD showSuccessWithStatus:svProgressHudAddedMessage];
            [SVProgressHUD dismiss];
            

            
//            if ([results objectForKey:kIDFieldName])
//            {
//                self.business = [JGBusiness businessWithID:[results objectForKey:kIDFieldName]];
//                self.business.name = self.businessName;
//                
//                if ([self.delegate respondsToSelector:@selector(businessAdded:)])
//                {
//                    [self.delegate businessAdded:self.business];
//                }
//                
//                [self dismissViewControllerAnimated:YES completion:nil];
//
//            }
//            else
//            {
//                //Error
//                [self requestType:requestType failedWithError:nil andData:nil];
//            }
            
            
            //Add code here to push to new page
        }
        else
        {
            [self requestType:requestType failedWithError:nil andData:nil];
        }
    }
    else
    {
        //Check if it was an edit business operation
        if (self.editingMode == kAddPlaceEditingModeEdit)
        {
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Thanks!", @"Message shown to user after editing business")];
            if ([self.delegate respondsToSelector:@selector(placeDataUpdated)])
            {
                [self.delegate placeDataUpdated];
            }
        }
    }
}

#pragma mark -
#pragma mark - Text Field Methods

- (void)textFieldDidChange:(NSNotification *)notification
{
    if (notification.object == nameCellTextField)
    {
//        self.businessName = ((UITextField*)notification.object).text;
//        self.business.name = self.businessName;
//        DDLogVerbose(@"Business name is now: %@", self.businessName);
    }

}


#pragma mark -
#pragma mark - Table View Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRowsToReturn = 0;
    
    switch (section)
    {
        case 0:
            numberOfRowsToReturn = 3;
            break;
            
        case 1:
            numberOfRowsToReturn = 1;
            break;
            
        default:
            break;
    }
    
    return numberOfRowsToReturn;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightToReturn = 0;
    
    if (indexPath.section == 1)
    {
        heightToReturn = self.addBusinessTableViewMapCell.frame.size.height;
    }
    else
    {
        heightToReturn = 44;
    }
    
    heightToReturn += [PrettyTableViewCell tableView:tableView neededHeightForIndexPath:indexPath];
    return heightToReturn;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrettyTableViewCell *cellToReturn;
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
//                    nameCellTextField.text = self.business.name;
                    cellToReturn = addBusinessTableViewNameCell;
                    break;
                    
                case 1:
                {
                    cellToReturn = addBusinessTableViewCategoryCell;
                    if (self.editingMode == kAddPlaceEditingModeEdit)
                    {
//                        if (self.business.category)
//                        {
//                            [self.categoryCellCategoryLabel
//                             setText:self.business.displayCategory];
//                        }
                    }

                }
                    break;
                    
                case 2:
                {
                    cellToReturn = addBusinessTableViewAddressCell;
                    if (self.editingMode == kAddPlaceEditingModeEdit)
                    {
//                        if (self.business.displayAddress.count > 0)
//                        {
//                            [self.addressCellAddressLabel setText:[self.business.displayAddress safeObjectAtIndex:0]];
//                        }
                    }

                }
                    
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        case 1:
        {
            [self drawMapCell];
            [((PrettyCustomViewTableViewCell*)self.addBusinessTableViewMapCell) setCustomView:self.mapContainerView];
            cellToReturn = addBusinessTableViewMapCell;
            cellToReturn.layer.masksToBounds = YES;
            cellToReturn.clipsToBounds = YES;
        }
            break;
            
        default:
            break;
    }
    
    cellToReturn.cornerRadius = 3.0f;
    cellToReturn.shadowOpacity = 0.3f;
    cellToReturn.selectionStyle = UITableViewCellSelectionStyleNone;
    [cellToReturn prepareForTableView:tableView indexPath:indexPath];
    return cellToReturn;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
            
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                    //Touched name cell
                    break;
                    
                case 1:
                {
                    //Touched category cell
//                    ZAddPlaceCategorySelector *categorySelector = [[ZAddPlaceCategorySelector alloc] initWithData:[[[ZodioAPIClient sharedClient] addBusinessCategories] objectForKey:kCategoriesListDataKey]];
//                    categorySelector.delegate = self;
//                    [self.navigationController pushViewController:categorySelector animated:YES];
                    
                }
                    break;
                    
                case 2:
                {
                    //Touched address cell
//                    [self addressCellSelected];
                }
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
            
        case 1:
        {
            //Touched map cell
            DDLogVerbose(@"Got a touch on map cell");
            ZAddPlaceLocationSelector *locationSelector = [[ZAddPlaceLocationSelector alloc] initWithNibName:nil bundle:nil];
            locationSelector.delegate = self;
            
            if (self.businessLocationSelected == YES)
            {
                [locationSelector setSelectedLocation:businessLocation];
                [locationSelector setLocationSelected:YES];
            }
            
            [self.navigationController pushViewController:locationSelector animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    [self.addBusinessTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addressCellSelected
{
    QRootElement *addressPageRootElement = [[QRootElement alloc] init];
//    addressPageRootElement.title = @"Add a Place";
    addressPageRootElement.grouped = YES;
    addressPageRootElement.controllerName = @"ZAddPlaceAddressPageViewController";
    
    QSection *mainAddressSection = [[QSection alloc] init];
    
    QElement *addressElement = [[QEntryElement alloc] initWithTitle:NSLocalizedString(@"Address","Address field name of add a place")
                                                              Value:[businessAddressInfo objectForKey:kAddPlaceStreetAddressFieldName]
                                                        Placeholder:NSLocalizedString(@"Optional",@"Optional Address place holder field name of add a place")];
    
    QElement *buildingElement = [[QEntryElement alloc] initWithTitle:NSLocalizedString(@"Building",@"Building field name of add a place")
                                                               Value:[businessAddressInfo objectForKey:kAddPlaceBuildingNameFieldName]
                                                         Placeholder:NSLocalizedString(@"e.g. CentralWorld - Optional",@"e.g. Building place holder filed name of add a place")];
    
    QElement *cityElement = [[QEntryElement alloc] initWithTitle:NSLocalizedString(@"City",@"City field name of add a place")
                                                           Value:[businessAddressInfo objectForKey:kAddPlaceCityFieldName]
                                                     Placeholder:NSLocalizedString(@"Optional",@"Optional City place holder field name of add a place")];
    
    QElement *postCodeElement = [[QEntryElement alloc] initWithTitle:NSLocalizedString(@"Postcode",@"Postcode field name of add a place")
                                                               Value:[businessAddressInfo objectForKey:kAddPlacePostcodeFieldName]
                                                         Placeholder:NSLocalizedString(@"Optional",@"Optional Postcode place holder field name of add a place")];
    
    QElement *phoneElement = [[QEntryElement alloc] initWithTitle:NSLocalizedString(@"Phone",@"Phone field name of add a place")
                                                            Value:[businessAddressInfo objectForKey:kAddPlaceContactTelephoneFieldName]
                                                      Placeholder:NSLocalizedString(@"Optional",@"Optional Phone place holder field name of add a place")];
    
    QSection *additionalInfoSection = [[QSection alloc] init];
    
    QElement *websiteElement = [[QEntryElement alloc] initWithTitle:NSLocalizedString(@"Website",@"Website title for add a place")
                                                              Value:[businessAddressInfo objectForKey:kAddPlaceContactWebsiteFieldName]
                                                        Placeholder:NSLocalizedString(@"Optional - www.example.com",@"website optional place holder field name of add a place")];
    
    [addressElement setKey:kAddPlaceStreetAddressFieldName];
    [buildingElement setKey:kAddPlaceBuildingNameFieldName];
    [cityElement setKey:kAddPlaceCityFieldName];
    [postCodeElement setKey:kAddPlacePostcodeFieldName];
    [phoneElement setKey:kAddPlaceContactTelephoneFieldName];
    [websiteElement setKey:kAddPlaceContactWebsiteFieldName];
    
    ((QEntryElement*)phoneElement).keyboardType = UIKeyboardTypePhonePad;
    ((QEntryElement*)websiteElement).keyboardType = UIKeyboardTypeURL;
    ((QEntryElement*)websiteElement).autocorrectionType = UITextAutocorrectionTypeNo;
    ((QEntryElement*)websiteElement).autocapitalizationType = UITextAutocapitalizationTypeNone;

    [mainAddressSection addElement:addressElement];
    [mainAddressSection addElement:buildingElement];
    [mainAddressSection addElement:cityElement];
    [mainAddressSection addElement:postCodeElement];
    [mainAddressSection addElement:phoneElement];
    
    [additionalInfoSection addElement:websiteElement];
    
    [addressPageRootElement addSection:mainAddressSection];
    [addressPageRootElement addSection:additionalInfoSection];
    
    ZAddPlaceAddressPageViewController *addressPageViewController = (ZAddPlaceAddressPageViewController *)[QuickDialogController controllerForRoot:addressPageRootElement];
    
    addressPageViewController.delegate = self;
    
    if (businessAddressEntered == YES || self.editingMode == kAddPlaceEditingModeEdit)
    {
        NSString *fullAddressString = [NSString string];
        
        for (NSString *address in self.business.displayAddress)
        {
            if (fullAddressString.length > 0)
            {
                fullAddressString = [fullAddressString stringByAppendingString:[NSString stringWithFormat:@", %@", address]];
            }
            else
            {
                fullAddressString = address;
            }
        }
        
        [self.businessAddressInfo setObject:fullAddressString forKey:kAddPlaceStreetAddressFieldName];
        addressPageViewController.businessAddress = self.businessAddressInfo;
        addressPageViewController.businessAddressDataExists = YES;

    }
    
    [self.navigationController pushViewController:addressPageViewController animated:YES];
}

- (IBAction)backgroundTap:(id)sender
{
    DDLogVerbose(@"Got background tap");
    [self.view endEditing:YES];
}

- (void)drawMapCell
{
//    self.addBusinessMapCellMap.layer.cornerRadius = 10.0;
    
    

    if (businessLocationSelected == NO)
    {
        self.addBusinessMapCellMap.region = MKCoordinateRegionMakeWithDistance([[ZLocationManager sharedZLocationManager] currentLocation].coordinate, 1000, 1000);
        
        self.addBusinessMapCellMap.centerCoordinate = [[ZLocationManager sharedZLocationManager] currentLocation].coordinate;
        self.addBusinessMapCellMap.showsUserLocation = YES;
        self.addBusinessMapCellMap.userInteractionEnabled = NO;
    }
    else
    {        
        self.addBusinessMapCellMap.region = MKCoordinateRegionMakeWithDistance(self.business.coordinate, 1000, 1000);

        self.addBusinessMapCellMap.centerCoordinate = self.businessLocation;
        self.addBusinessMapCellMap.showsUserLocation = YES;

    }
    
//    self.addBusinessTableViewMapCell.layer.masksToBounds = YES;
//    self.mapInstructionView.layer.cornerRadius = 5.0;
    
}

#pragma mark -
#pragma mark - Data Return Methods

- (void)categorySelected:(NSString *)category
{
    DDLogVerbose(@"Received category: %@", category);
    self.businessCategory = category;
    self.business.category = [[ZodioAPIClient sharedClient] categoryFullNameForKey:category];
    self.business.displayCategory = [[ZodioAPIClient sharedClient] categoryFullNameForKey:category];
    NSString *categoryDisplayName = [[ZodioAPIClient sharedClient] categoryFullNameForKey:category];
    [self.categoryCellCategoryLabel setText:categoryDisplayName];
    self.categorySelected = YES;
    [self.addBusinessTableView reloadData];
    
}

- (void)addressEntered:(NSMutableDictionary*)address
{
    DDLogVerbose(@"Received business address info: %@", address);
    self.businessAddressInfo = address;
    
    //Set new display address into business object, array style
    NSMutableArray *businessAddress = [NSMutableArray array];
    for (NSString *key in address)
    {
        [businessAddress addObject:[address objectForKey:key]];
    }
    self.business.displayAddress = businessAddress;
    
    if ([self.businessAddressInfo objectForKey:kAddPlaceStreetAddressFieldName] != nil)
    {
        [self.addressCellAddressLabel setText:[self.businessAddressInfo objectForKey:kAddPlaceStreetAddressFieldName]];
    }
    
    self.businessAddressEntered = YES;
    
    [self.addBusinessTableView reloadData];
}


- (void)locationSelected:(CLLocationCoordinate2D)location
{
    for (id <MKAnnotation> currentAnnotation in self.addBusinessMapCellMap.annotations)
    {
        if ([currentAnnotation isKindOfClass:[MKUserLocation class]])
        {
            
        }
        else
        {
            [self.addBusinessMapCellMap removeAnnotation:currentAnnotation];
        }
    }
    
    self.businessLocation = location;
    self.business.coordinate = location;
    
    self.addBusinessMapCellMap.centerCoordinate = self.businessLocation;
    self.addBusinessMapCellMap.userTrackingMode = MKUserTrackingModeNone;
    self.addBusinessMapCellMap.showsUserLocation = NO;
    
    MKPointAnnotation *selectedLocationAnnotation = [[MKPointAnnotation alloc] init];
    selectedLocationAnnotation.coordinate = self.businessLocation;
    [self.addBusinessMapCellMap addAnnotation:selectedLocationAnnotation];
    
    self.addBusinessMapCellMap.region = MKCoordinateRegionMakeWithDistance(self.businessLocation, 1000, 1000);
    
    self.businessLocationSelected = YES;
    [self reverseGeocodeBusinessLocation];

}

- (void)addPlace
{
    if ([nameCellTextField.text length] == 0 || categorySelected == NO || businessLocationSelected == NO || [self websiteValidationPassed] == NO)
    {
        NSString *alertViewTitle = NSLocalizedString(@"Missing Information", @"Alert view title in Add Business page when user has entered insufficient data");
        NSString *alertViewMessage;
        
        if ([nameCellTextField.text length] == 0)
        {
            alertViewMessage = NSLocalizedString(@"Please enter a name for this place", @"Alert view message in Add Business page when user has not entered a name");
        }
        else if (categorySelected == NO)
        {
            alertViewMessage = NSLocalizedString(@"Please select a category for this place", @"Alert view message in Add Business page when user has not selected a category");
        }
        else if (businessLocationSelected == NO)
        {
            alertViewMessage = NSLocalizedString(@"Please select a location for this place", @"Alert view message in Add Business page when user has not selected a location");
        }
        else if ([self websiteValidationPassed] == NO)
        {
            alertViewTitle = NSLocalizedString(@"Invalid URL", @"Alert view title in Add Business page when the website entered doesn't pass validation");
            alertViewMessage = NSLocalizedString(@"The website URL you entered doesn't seem to be valid", @"Alert view message in Add Business when website hasn't passed validation");
        }
        
        BlockAlertView *missingInformationAlertView = [BlockAlertView alertWithTitle:alertViewTitle message:alertViewMessage];
        [missingInformationAlertView setCancelButtonWithTitle:NSLocalizedString(@"OK", @"OK") block:nil];
        [missingInformationAlertView show];
    }
    
    else
    {
        //Go ahead and add business, info is sufficient
        NSString *latitudeAsString = [NSString stringWithFormat:@"%f", businessLocation.latitude];
        NSString *longitudeAsString = [NSString stringWithFormat:@"%f", businessLocation.longitude];
        
        NSString *categoryAsString = [[NSArray arrayWithObject:[[ZodioAPIClient sharedClient] categoryKeywordForFullName:self.business.displayCategory]] JSONString];
        
        NSMutableDictionary *businessInfoDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                       latitudeAsString, kAddPlaceLocationLatitudeFieldName,
                                                       longitudeAsString, kAddPlaceLocationLongitudeFieldName,
                                                       self.business.name, kAddPlaceNameFieldName,
                                                       categoryAsString, kAddPlaceCategoryFieldName,
                                                       nil];
        
        for (NSString *key in businessAddressInfo)
        {
            [businessInfoDictionary setObject:[businessAddressInfo objectForKey:key] forKey:key];
        }
        
        [businessInfoDictionary safeSetObject:businessLocationPlacemarkAsJSONString forKey:kAddPlacePlacemarkFieldName];
        
        DDLogVerbose(@"Business info being sent to ZodioAPIClient: %@", businessInfoDictionary);
        
        ///Change to regular HUD because 'Adding' isn't always applicable, this page can now be used to edit
//        [SVProgressHUD showWithStatus:svProgressHudAddingMessage];
        [SVProgressHUD show];
        
        if (self.editingMode == kAddPlaceEditingModeAdd)
        {
            [[ZodioAPIClient sharedClient] addNewBusinessWithInfo:businessInfoDictionary forOwner:self];
        }
        else
        {
            //Need API endpoint for editing business
            //POST to business ID path
//            - (void)editBusiness:(JGBusiness*)business withInfo:(NSDictionary*)info forOwner:(id)owner

            [[ZodioAPIClient sharedClient] editBusiness:self.business withInfo:businessInfoDictionary forOwner:self];

            
//            [SVProgressHUD showSuccessWithStatus:@"Coming Soon!"];
        }
    }
}

- (void)reverseGeocodeBusinessLocation
{
    if (osVersion() >= 5.0)
    {
        CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
        CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:businessLocation.latitude longitude:businessLocation.longitude];

        [reverseGeocoder reverseGeocodeLocation:myLocation completionHandler:^(NSArray *placemarks, NSError *error)
         {
             DDLogVerbose(@"reverseGeocodeLocation:completionHandler: Completion Handler called!");
             if (error){
                 DDLogVerbose(@"Geocode failed with error: %@", error);
                 return;
             }
             DDLogVerbose(@"Received placemarks: %@", placemarks);

             CLPlacemark *myPlacemark = [placemarks objectAtIndex:0];
             NSString *countryCode = myPlacemark.ISOcountryCode;
             NSString *countryName = myPlacemark.country;
             NSString *administrativeArea = myPlacemark.administrativeArea;
             NSString *subAdministrativeArea = myPlacemark.subAdministrativeArea;
             NSString *locality = myPlacemark.locality;
             NSString *subLocality = myPlacemark.subLocality;
             NSString *thoroughfare = myPlacemark.thoroughfare;
             NSString *subThoroughfare = myPlacemark.subThoroughfare;
             NSString *postalCode = myPlacemark.postalCode;
             
             DDLogVerbose(@"My thoroughfare: %@ - %@", thoroughfare, myPlacemark.thoroughfare);
             DDLogVerbose(@"My locality: %@ - %@", locality, myPlacemark.locality);
             
             NSMutableDictionary *placemarkDictionary = [[NSMutableDictionary alloc] init];
             
             [placemarkDictionary safeSetObject:countryCode forKey:@"cc"];
             [placemarkDictionary safeSetObject:countryName forKey:@"country"];
             [placemarkDictionary safeSetObject:postalCode forKey:kAddPlacePostcodeFieldName];
             [placemarkDictionary safeSetObject:administrativeArea forKey:@"administrative_area"];
             [placemarkDictionary safeSetObject:subAdministrativeArea forKey:@"sub_administrative_area"];
             [placemarkDictionary safeSetObject:locality forKey:@"locality"];
             [placemarkDictionary safeSetObject:subLocality forKey:@"sub_locality"];
             [placemarkDictionary safeSetObject:thoroughfare forKey:@"thoroughfare"];
             [placemarkDictionary safeSetObject:subThoroughfare forKey:@"sub_thoroughfare"];
             
             DDLogVerbose(@"Placemark dictionary: %@", placemarkDictionary);
             
             businessLocationPlacemarkAsJSONString = [placemarkDictionary JSONString];
             
             DDLogVerbose(@"JSON String: %@", businessLocationPlacemarkAsJSONString);
             
             DDLogVerbose(@"My country code: %@ and countryName: %@", countryCode, countryName);
             
             if (!self.businessAddressEntered && self.editingMode == kAddPlaceEditingModeAdd)
             {
                 self.businessAddressInfo = [NSMutableDictionary dictionary];
                 
                 [self.businessAddressInfo safeSetObject:myPlacemark.thoroughfare forKey:kAddPlaceStreetAddressFieldName];
                 [self.businessAddressInfo safeSetObject:myPlacemark.postalCode forKey:kAddPlacePostcodeFieldName];
                 [self.businessAddressInfo safeSetObject:myPlacemark.administrativeArea forKey:kAddPlaceCityFieldName];
                 [self.addressCellAddressLabel setText:myPlacemark.thoroughfare];
             }
             
         }];
    }

}

- (BOOL)websiteValidationPassed
{
    NSString *website = [businessAddressInfo objectForKey:kAddPlaceContactWebsiteFieldName];
    
    BOOL websiteIsValid = YES;
    
    DDLogVerbose(@"Validating %@", website);
    
    if (website != nil && [website length] > 0)
    {
        NSArray *websiteComponents = [website componentsSeparatedByString:@"."];
        
        if ([websiteComponents count] < 2 || [[websiteComponents objectAtIndex:[websiteComponents count] - 1] length] < 2)
        {
            websiteIsValid = NO;
        }
        
    }
    
    return websiteIsValid;
}


- (void)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
