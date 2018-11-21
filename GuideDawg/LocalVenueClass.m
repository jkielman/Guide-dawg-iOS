//
//  LocalVenueClass.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-12-07.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import "LocalVenueClass.h"

@implementation LocalVenueClass

+ (LocalVenueClass *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress andDistance:(NSNumber *)distance
{
    
    LocalVenueClass *localVenueClass = [[LocalVenueClass alloc]init];
    localVenueClass.name = name;
    localVenueClass.streetAddress = streetAddress;
    localVenueClass.distance = distance;
    
    return localVenueClass;
    
}

@end
