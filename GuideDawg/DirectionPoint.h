//
//  DirectionPoint.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-02-16.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface DirectionPoint : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager* locationManager;

@property (nonatomic, retain) UIImageView *arrowImageView;

@property (nonatomic) CLLocationDegrees latitudeOfTargetedPoint;

@property (nonatomic) CLLocationDegrees longitudeOfTargetedPoint;

@end
