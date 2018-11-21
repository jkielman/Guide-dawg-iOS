//
//  MapViewLocationViewController.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-01-10.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@class Venue;


@interface MapViewLocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)zoomtocurrentloc:(id)sender;
-(IBAction) refresh:(id) sender;


@property (weak, nonatomic) Venue *venue;

@end