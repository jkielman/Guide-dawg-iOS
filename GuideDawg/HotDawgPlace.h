//
//  HotDawgPlace.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-01-07.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface HotDawgPlace : NSObject

@property MKMapItem *mapItem;
@property float milesDifference;
@property float coordinatesDifference;

@end
