//
//  LocalVenueClass.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-12-07.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalVenueClass : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSNumber *distance;



+ (LocalVenueClass *)LocalVenueObjectwithName:(NSString *)name andStreetAddress:(NSString *)streetAddress andDistance:(NSNumber *)distance;

@end
