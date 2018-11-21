//
//  Location.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-26.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Location : NSObject
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *crossStreet;
@property (nonatomic, strong) NSString *postalCode;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSNumber *distance;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lng;

@end
