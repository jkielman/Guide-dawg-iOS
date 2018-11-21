//
//  GUDMapViewController.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-23.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import "GUDMapViewController.h"
#import "FSQFoursquareAPIClient.h"
#import "GUDVenueAnnotation.h"
#import "Venue.h"
#import "SVProgressHUD.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)





@interface GUDMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>


@property (nonatomic, strong) NSArray *venues;

@end

@implementation GUDMapViewController


- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    
    
    //View Area
    MKCoordinateRegion region = { { 0.5, 0.5 }, { 0.5, 0.5 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [_mapView setRegion:region animated:YES];
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    [_mapView addAnnotation:myAnnotation];
    
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
    
    
    
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    self.locationManager = nil;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (void)updateLocation {
    [self.locationManager startUpdatingLocation];
}







- (void)zoomToLocation:(CLLocation *)location radius:(CGFloat)radius {
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius * 2, radius * 2);
    [self.mapView setRegion:region animated:YES];
}

- (void)fetchVenuesForLocation:(CLLocation *)location {
    [SVProgressHUD show];
    [[FSQFoursquareAPIClient sharedClient] fetchVenuesNear:location.coordinate
                                                searchTerm:@"hot dogs"
                                            radiusInMeters:2000
                                                completion:^(NSArray *venues, NSError *error) {
                                                    if (error) {
                                                        [SVProgressHUD showErrorWithStatus:@"No Hot Dawgs in this area."];
                                                    } else {
                                                        [SVProgressHUD dismiss];
                                                        self.venues = venues;
                                                        [self updateAnnotations];
                                                    }
                                                }];
}

- (void)updateAnnotations {
    for (FSQVenue *venue in self.venues) {
        GUDVenueAnnotation *annotation = [[GUDVenueAnnotation alloc] initWithVenue:venue];
        [self.mapView addAnnotation:annotation];
    }
}




#pragma mark Delegate Methods

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *pinView = nil;
    if(annotation != _mapView.userLocation)
    {
        static NSString *defaultPinID = @"com.invasivecode.pin";
        pinView = (MKAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        //pinView.pinColor = MKPinAnnotationColorGreen;
        pinView.canShowCallout = YES;
        //pinView.animatesDrop = YES;
        pinView.image = [UIImage imageNamed:@"hotdawg.png"];   
    }
    else {
        [_mapView.userLocation setTitle:@"I am here"];
    }
    return pinView;
}





- (IBAction)zoomtocurrentloc:(id)sender {
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.mapView.userLocation.coordinate.latitude;
    region.center.longitude = self.mapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.mapView setRegion:region animated:YES];
    //  [self.mapView setCenter:_mapView.userLocation.coordinate animated:YES];
}


//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
   /// if ([annotation isKindOfClass:[MKUserLocation class]])
////  return nil;
    
    ////static NSString *s = @"ann";
    //MKAnnotationView *pin = [mapView dequeueReusableAnnotationViewWithIdentifier:s];
    ////if (!pin) {
        ///pin = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:s];
        //pin.canShowCallout = YES;
        ///pin.image = [UIImage imageNamed:@"hotdawgicon.png"];
        //pin.calloutOffset = CGPointMake(0, 0);
        //UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //[button addTarget:self
          //         action:@selector(checkinButton) forControlEvents:UIControlEventTouchUpInside];
        //pin.rightCalloutAccessoryView = button;
        
   // }
    //return pin;
//}







#pragma mark - CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    [self fetchVenuesForLocation:location];
    [self zoomToLocation:location radius:1000];
    
    [self.locationManager stopUpdatingLocation];
}



- (IBAction)refresh:(id)sender {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
#endif
    
    //View Area
    MKCoordinateRegion region = { { 0.5, 0.5 }, { 0.5, 0.5 } };
    region.center.latitude = self.locationManager.location.coordinate.latitude;
    region.center.longitude = self.locationManager.location.coordinate.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
    [_mapView setRegion:region animated:YES];
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
    [_mapView addAnnotation:myAnnotation];
    
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    
  


    
}






@end
