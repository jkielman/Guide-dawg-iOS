//
//  GUDVenueAnnotation.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-23.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import "GUDVenueAnnotation.h"

@interface GUDVenueAnnotation ()
@property (nonatomic, strong) FSQVenue *venue;
@end

@implementation GUDVenueAnnotation

- (id)initWithVenue:(FSQVenue *)venue {
    self = [super init];
    if (self) {
        self.venue = venue;
    }
    return self;
}





- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.venue.latitude floatValue], [self.venue.longitude floatValue]);
}



- (NSString *)title {
    return self.venue.name;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return [[mapView annotations] count];
    
    return 20;}






@end