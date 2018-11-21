//
//  MapViewLocationViewController.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-01-10.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import "MapViewLocationViewController.h"
#import "Venue.h"
#import "SVProgressHUD.h"



@interface MapViewLocationViewController () <MKMapViewDelegate>

@end

@implementation MapViewLocationViewController


- (void)updateAnnotations
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:@[self.venue]];
    [self.mapView showAnnotations:@[self.venue] animated:YES];
    
    //[self.mapView viewForAnnotation:self.venue];
}


- (void)setMapView:(MKMapView *)mapView
{
    
        _mapView = mapView;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    [self updateAnnotations];
    
    
    
    
    
}













#pragma mark - MKMapViewDelegate




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
        
        pinView.canShowCallout = YES;
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



- (IBAction)refresh:(id)sender {
     self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    [self updateAnnotations];

}



@end
