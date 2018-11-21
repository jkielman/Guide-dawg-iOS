//
//  GUDMasterViewController.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-22.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import "GUDMasterViewController.h"
#import <RestKit/Restkit.h>
#import <CoreLocation/CoreLocation.h>
#import "Venue.h"
#import "Location.h"
#import "VenueCell.h"
#import "Stats.h"
#import "MSCellAccessory.h"
#import "MapViewLocationViewController.h"
#import "SVProgressHUD.h"


#define kCLIENTID @"YE0BBRBZORBLYRS0PDTZ1MFQMJOIFUNRDSQECGOCPMLRPQJO"
#define kCLIENTSECRET @"R3LCZOL0TITIONRMV5C5GGHCQ3RDKUQEFLVNEMYSNXAPZG3K"

@interface GUDMasterViewController ()
@property (nonatomic, strong) NSArray *venues;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation GUDMasterViewController

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        [_locationManager startUpdatingLocation];
    }
    return _locationManager;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureRestKit];
    [self loadVenues];
    //self.view.backgroundColor = [UIColor colorWithRed: 255.0 green: 127.0 blue: 10.0 alpha: 1.0];

    
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    
    
    
    
}

- (void)configureRestKit
{
    NSURL *baseURL = [NSURL URLWithString:@"https://api.foursquare.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    
    RKObjectMapping *venueMapping = [RKObjectMapping mappingForClass:[Venue class]];
    [venueMapping addAttributeMappingsFromArray:@[@"name"]];
    
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:venueMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/v2/venues/search"
                                                keyPath:@"response.venues"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    // define location object mapping
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[Location class]];
    [locationMapping addAttributeMappingsFromArray:@[@"address", @"city", @"country", @"crossStreet", @"postalCode", @"state", @"distance", @"lat", @"lng"]];
    
    // define relationship mapping
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:locationMapping]];
    
    RKObjectMapping *statsMapping = [RKObjectMapping mappingForClass:[Stats class]];
    [statsMapping addAttributeMappingsFromDictionary:@{@"checkinsCount": @"checkins", @"tipsCount": @"tips", @"ratingCount": @"rating", @"usersCount": @"users"}];
    
    [venueMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"stats" toKeyPath:@"stats" withMapping:statsMapping]];
}


- (void)loadVenues
{
    NSString *latLon = [NSString stringWithFormat:@"%f,%f",
                        self.locationManager.location.coordinate.latitude,
                        self.locationManager.location.coordinate.longitude];
    NSString *clientID = kCLIENTID;
    NSString *clientSecret = kCLIENTSECRET;
    NSString *radius =  @"2000";

    
    NSDictionary *queryParams = @{@"ll" : latLon,
                                  @"radius" : radius,
                                  @"client_id" : clientID,
                                  @"client_secret" : clientSecret,
                                  @"categoryId" : @"4bf58dd8d48988d16f941735",
                                  @"v" : @"20140118"};
    [SVProgressHUD show];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/v2/venues/search"
                                           parameters:queryParams
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  self.venues = [mappingResult.array sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"location.distance" ascending:YES]]];
                                                  [self.tableView reloadData];
                                              }
     
    
     
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  [SVProgressHUD showErrorWithStatus:@"No Hot Dawgs in this area."];
                                                   NSLog(@"No Hot dawgs?': %@", error);
                                              }];

    [self.locationManager stopUpdatingLocation];
    [SVProgressHUD dismiss];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _venues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    
    Venue *venue = _venues[indexPath.row];
    cell.nameLabel.text = venue.name;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.0fm", venue.location.distance.floatValue];
    cell.ratingLabel.text = [NSString stringWithFormat:@"%d of 10", venue.rating.intValue];
    
    
    
    
    
    


    UIColor *disclosureColor = [UIColor colorWithRed: 255.0 green: 255.0 blue: 255.0 alpha: 1.0];
    cell.accessoryView = [MSCellAccessory accessoryWithType:FLAT_DISCLOSURE_INDICATOR color:disclosureColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(233.0/255.0) green:(131.0/255.0) blue:(53.0/255.0) alpha:1.0];     bgColorView.layer.masksToBounds = YES;
    cell.selectedBackgroundView = bgColorView;
    
    return cell;

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Navigation

- (void)prepareViewController:(id)vc forSegue:(NSString *)segueIdentifier fromIndexPath:(NSIndexPath *)indexPath
{
    if ([vc isKindOfClass:[MapViewLocationViewController class]])
    {
        if (![segueIdentifier length] || [segueIdentifier isEqualToString:@"Show Location"])
        {
            MapViewLocationViewController *slvc = (MapViewLocationViewController *)vc;
            Venue *venue = self.venues[indexPath.row];
            slvc.venue = venue;
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = nil;
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        indexPath = [self.tableView indexPathForCell:sender];
    }
    [self prepareViewController:segue.destinationViewController
                       forSegue:segue.identifier
                  fromIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detailvc = [self.splitViewController.viewControllers lastObject];
    if ([detailvc isKindOfClass:[UINavigationController class]])
    {
        detailvc = [((UINavigationController *)detailvc).viewControllers firstObject];
        [self prepareViewController:detailvc
                           forSegue:nil
                      fromIndexPath:indexPath];
    }
}



- (IBAction)refresh:(id)sender {
    [super viewDidLoad];
    [self configureRestKit];

     [self loadVenues];
}


@end
