//
//  FSQVenue.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-23.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSQVenue : NSObject

@property (nonatomic, copy) NSString *venueId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *rating;
@property (nonatomic, strong) NSString *crossStreet;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lng;



+ (id)venueWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

