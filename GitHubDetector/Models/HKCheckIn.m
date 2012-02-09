//
//  HKCheckIn.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKCheckIn.h"
#import <MapKit/MKAnnotation.h>

@implementation HKCheckIn
@synthesize coordinate;

@synthesize location = _location;
@synthesize message = _message;


-(CLLocationCoordinate2D) coordinate {
     return _location.coordinate;
}

@end
