//
//  HKCheckIn.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKCheckIn.h"
#import "MKAnnotetion"

@implementation HKCheckIn
@synthesize coordinate;

@synthesize location = _location;
@synthesize message = _message;


-(void) setLocation:(CLLocation *)_location {
    location = _location;
    coordinate = location.location;
    
    
}

@end
