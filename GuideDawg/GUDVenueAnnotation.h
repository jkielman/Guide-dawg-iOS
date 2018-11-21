//
//  GUDVenueAnnotation.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-23.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "FSQVenue.h"

@interface GUDVenueAnnotation : NSObject <MKAnnotation>

- (id)initWithVenue:(FSQVenue *)venue;




@end
