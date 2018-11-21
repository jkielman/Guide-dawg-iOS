//
//  VenueCell.h
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-26.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VenueCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@end
