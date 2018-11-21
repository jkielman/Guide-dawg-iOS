//
//  VenueAnnotation.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-01-05.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface VenueAnnotation : NSObject <MKAnnotation>



@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, strong) Venue *venue;

@end
