//
//  HotDawgList.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-01-07.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import "HotDawgList.h"
#import <MapKit/MapKit.h>
#import "HotDawgPlace.h"

@interface HotDawgList () <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>


@property NSMutableArray *pizzaPlacesArray;
@property (weak, nonatomic) IBOutlet UITableView *pizzaTableView;

@end

@implementation HotDawgList 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLocationManager = [[CLLocationManager alloc]init];
    self.myLocationManager.delegate = self;
    
    self.pizzaPlacesArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    [self.myLocationManager startUpdatingLocation];
    self.myLocationManager = [[CLLocationManager alloc] init];
    self.myLocationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.myLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.myLocationManager requestWhenInUseAuthorization];
    }
    [self.myLocationManager startUpdatingLocation];
}


#pragma mark - Helpers

-(void)findPizzaPlace:(CLLocation *)location
{
    // Retreives data for a local search
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"hot dog";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.05,.05));
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        NSArray *mapItems = response.mapItems;
        
        // Retrieves data for 5 closest Pizza Places
        for(int i = 0; i < 9; i++)
        {
            MKMapItem *mapItemWithData = [mapItems objectAtIndex:i];
            
            // Calculates how far user is from pizza place, in miles
            CLLocationDistance metersAway = [mapItemWithData.placemark.location distanceFromLocation:location];
            float milesDifference = metersAway / 1609.3430734;
            
            // Calculates average distance in coordinates from passed-in location
            float latDistance = fabsf( location.coordinate.latitude - mapItemWithData.placemark.location.coordinate.latitude );
            float longDistance = fabsf( location.coordinate.longitude - mapItemWithData.placemark.location.coordinate.longitude );
            float hypotenuseLength = latDistance + longDistance;
            
            // Creates new PizzaPlace reference
            HotDawgPlace *pizzaPlace = [[HotDawgPlace alloc]init];
            
            // Sets milesDistance property for PizzaPlace reference
            pizzaPlace.milesDifference = milesDifference;
            
            // Sets coordinateDifference property for PizzaPlace reference
            pizzaPlace.coordinatesDifference = hypotenuseLength;
            
            // Sets MKMapItem property for PizzaPlace reference
            pizzaPlace.mapItem = mapItemWithData;
            
            // Adds PizzaPlace reference to mutable array
            [self.pizzaPlacesArray addObject:pizzaPlace];
        }
        
        // Orders the array of PizzaPlaces by their milesAway property
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"coordinatesDifference" ascending:YES];
        NSArray *sortedArray = [self.pizzaPlacesArray sortedArrayUsingDescriptors:@[sortDescriptor]];
        
        //        for(PizzaPlace *pizzaPlace in self.pizzaPlacesArray)
        //        {
        //            NSLog(@"%@ is %f away",pizzaPlace.mapItem.name, pizzaPlace.milesDifference);
        //        }
        [self.pizzaTableView reloadData];
    }];
}

#pragma mark - Delegates

// TableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pizzaPlacesArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotDawgPlace *pizzaRef = [self.pizzaPlacesArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PizzaCellID"];
    cell.textLabel.text = pizzaRef.mapItem.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fm away",pizzaRef.milesDifference];
    
    return cell;
}

//CLLocationManager
-(void)reverseGeoCode:(CLLocation *)location
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks.firstObject;
        NSString *zaMessage = [NSString stringWithFormat:@"Eat Pizza at:\n%@ %@ \n%@",
                               placemark.subThoroughfare,
                               placemark.thoroughfare,
                               placemark.locality];
        //        NSLog(@"%@",zaMessage);
        [self findPizzaPlace:location];
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for(CLLocation *location in locations)
    {
        
        if (location.verticalAccuracy <1000 && location.horizontalAccuracy < 1000)
        {
            [self reverseGeoCode: location];
            [self.myLocationManager stopUpdatingLocation];
            break;
        }
    }
}

@end