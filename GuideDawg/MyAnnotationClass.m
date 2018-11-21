//
//  MyAnnotationClass.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-12-30.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import "MyAnnotationClass.h"


@implementation MyAnnotationClass


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.image = [UIImage imageNamed:@"hotdawgicon.png"];
    }
    return self;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end


