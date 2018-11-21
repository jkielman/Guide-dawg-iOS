//
//  Venue.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-22.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Location;
@class Stats;

@interface Venue : NSObject <MKAnnotation>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *rating;

@property (nonatomic, strong) Location *location;
@property (nonatomic, strong) Stats *stats;
@end

