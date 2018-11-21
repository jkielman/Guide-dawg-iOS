//
//  GUDMapViewController.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-23.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>
@class Venue;

@interface GUDMapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
- (IBAction)zoomtocurrentloc:(id)sender;
@property (weak, nonatomic) Venue *venue;

-(IBAction) refresh:(id) sender;


@end
