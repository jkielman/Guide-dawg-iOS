//
//  CompassViewController.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2015-02-07.
//  Copyright (c) 2015 ___WORKPARTY___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define kCLIENTID @"YE0BBRBZORBLYRS0PDTZ1MFQMJOIFUNRDSQECGOCPMLRPQJO"
#define kCLIENTSECRET @"R3LCZOL0TITIONRMV5C5GGHCQ3RDKUQEFLVNEMYSNXAPZG3K"

@interface CompassViewController : UIViewController <CLLocationManagerDelegate>


-(IBAction) refresh:(id) sender;



@end
