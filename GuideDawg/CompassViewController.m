//
//  CompassViewController.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-02-07.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import "CompassViewController.h"
#import <RestKit/RestKit.h>
#import "Venue.h"
#import "Location.h"
#import "DirectionPoint.h"
#import "SVProgressHUD.h"


@interface CompassViewController ()
{
    NSArray *venuesArray;
    CLLocationManager *locationManager;
    NSString *latLon;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *foodVenueLabel;
@property (strong, nonatomic) IBOutlet __block UILabel *currentLocationLabel;

@end

@implementation CompassViewController


DirectionPoint *geoPointCompass;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc] init];
    
    [self getCurrentLocation];
    [self configureRestKit];
    // Create the image for the compass
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40,80, 250, 250)];
    arrowImageView.image = [UIImage imageNamed:@"compass_needle.png"];
    [self.view addSubview:arrowImageView];
    
    geoPointCompass = [[DirectionPoint alloc] init];
    
    // Add the image to be used as the compass on the GUI
    [geoPointCompass setArrowImageView:arrowImageView];
    
    // Set the coordinates of the location to be used for calculating the angle
        // geoPointCompass.latitudeOfTargetedPoint = 27.3372;
        // geoPointCompass.longitudeOfTargetedPoint = 82.5353;
    
    
}



- (void)getCurrentLocation
{
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}


- (void)configureRestKit
{
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:baseURL];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:venueMapping method:RKRequestMethodGET pathPattern:@"/v2/venues/search" keyPath:@"response.venues" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
}


- (void)loadVenue
{
    ///NSString *clientID = kCLIENTID;
    ///NSString *clientSecret = kCLIENTSECRET;
    ///NSString *radius =  @"2000";
      NSString *clientID = kCLIENTID;
    NSString *clientSecret = kCLIENTSECRET;
    NSString *radius =  @"2000";
    
    
    NSDictionary *queryParams = @{@"ll" : latLon,
                                  @"radius" : radius,
                                  @"client_id" : clientID,
                                  @"client_secret" : clientSecret,
                                  @"categoryId" : @"4bf58dd8d48988d16f941735",
                                  @"v" : @"20140118"};
    
    
    
    
    [SVProgressHUD show];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         
         
           venuesArray =
         
         
         [mappingResult.array sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"location.distance" ascending:YES]]];
         
         
         
        [self updateUI];
        
     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         
         
         [SVProgressHUD showErrorWithStatus:@"No Hot Dawgs in this area."];
         NSLog(@"No Hot dawgs?': %@", error);
     
         
         
         
     }];
    
    
    [self->locationManager stopUpdatingLocation];
    [SVProgressHUD dismiss];

    
}

- (void)updateUI
{
    Venue *ven = [venuesArray objectAtIndex:1];
    self.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", ven.location.distance.floatValue]; ///"%.1f meters"
    self.foodVenueLabel.text = ven.name;
    NSLog(@"Food: %@ & location %.5f",ven.name, ven.location.distance.floatValue);
    
   
   }


- (void)updateUI:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
    // Create the image for the compass
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40,80, 250, 250)];
    arrowImageView.image = [UIImage imageNamed:@"compass_needle-error.png"];
    [self.view addSubview:arrowImageView];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location Delegate methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Failed with error: %@", error);
    
    // Create the image for the compass
    UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40,80, 250, 250)];
    arrowImageView.image = [UIImage imageNamed:@"compass_needle-error.png"];
    [self.view addSubview:arrowImageView];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    latLon = [NSString stringWithFormat:@"%.8f,%.8f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude];
    
    NSLog(@"LatLong: %@", latLon);
    [locationManager stopUpdatingLocation];
    
    
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            self.currentLocationLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                              placemark.subThoroughfare, placemark.thoroughfare,
                                              placemark.postalCode, placemark.locality,
                                              placemark.administrativeArea,
                                              placemark.country];
        } else {
            
            
            // Create the image for the compass
            UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40,80, 250, 250)];
            arrowImageView.image = [UIImage imageNamed:@"compass_needle-error.png"];
            [self.view addSubview:arrowImageView];

            
            
        }
    } ];
    
    
    
    
    
    [self loadVenue];
    
}


- (IBAction)refresh:(id)sender {
    [super viewDidLoad];
    [self configureRestKit];
    
    [self loadVenue];
}


@end
