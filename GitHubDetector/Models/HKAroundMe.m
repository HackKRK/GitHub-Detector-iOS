//
//  HKAroundMe.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/10/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKAroundMe.h"
#import "HKDetectorClient.h"

@interface HKAroundMe () // Private
@property (nonatomic, readwrite, strong) CLLocation *myLocation;
@property (nonatomic, readwrite, strong) CLLocationManager *locationManager;
@end

@implementation HKAroundMe

@synthesize locationManager = _locationManager;
@synthesize myLocation = _myLocation;
@synthesize checkIns = _checkIns;

- (id)init
{
    if ((self = [super init]))
    {
        // start gps
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

#pragma mark -
#pragma mark <CLLocationManagerDelegate>
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.myLocation = newLocation;
    [[HKDetectorClient sharedInstance] findGeeksAtLatitude:self.myLocation.coordinate.latitude
                                                 longitude:self.myLocation.coordinate.longitude
                                           successCallback: ^ (NSArray *checkIns) {
                                               self.checkIns = checkIns;
                                           }
                                           failureCallback: ^ (NSError *error) {
                                               NSLog(@"%@", error);
                                           }];
}

@end
