//
//  Venue.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-22.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import "Venue.h"
#import "Location.h"

@implementation Venue


////////////////////////////////////////////////////////////

- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = [self.location.lat doubleValue];
    coordinate.longitude = [self.location.lng doubleValue];
    
    return coordinate;
}

////////////////////////////////////////////////////////////

- (NSString *)title
{
    return self.name;
}

////////////////////////////////////////////////////////////

//- (NSString *)subtitle
//{
  // return [NSString stringWithFormat:@"%@ %@, %@",
         //self.location.address, self.location.city, self.location.state];
//}

@end
