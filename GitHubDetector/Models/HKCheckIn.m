//
//  HKCheckIn.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKCheckIn.h"
#import <MapKit/MKAnnotation.h>
#import "HKGeek.h"

@interface HKCheckIn () // Private
//@property (nonatomic, readwrite, strong) HKGeek *geek;
//@property (nonatomic, readwrite, strong) CLLocation *location;
//@property (nonatomic, readwrite, strong) NSString *message;
@end

@implementation HKCheckIn

@synthesize coordinate = _coordinate;
@synthesize geek = _geek;
@synthesize location = _location;
@synthesize message = _message;

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

- (id)initFromJSON:(NSDictionary *)json
{
    if (self = [super init])
    {
        // geek
        HKGeek *geek = [HKGeek geekForLogin:[json objectForKey:@"login"]];
        geek.gravatarURL = [json objectForKey:@"avatar_url"];
        self.geek = geek;
        
        // msg
        self.message = [json objectForKey:@"text"];
        
        // geo
        CLLocationCoordinate2D location;
        location.latitude = [[json objectForKey:@"lat"] doubleValue];
        location.longitude = [[json objectForKey:@"lng"] doubleValue];
        NSDate *timestamp = [[NSDate alloc] initWithTimeIntervalSince1970:[[json objectForKey:@"date"] doubleValue]];
        self.location = [[CLLocation alloc] initWithCoordinate:location
                                                      altitude:0
                                            horizontalAccuracy:0
                                              verticalAccuracy:0
                                                     timestamp:timestamp];
    }
    return self;
}

- (NSComparisonResult)compareDate:(HKCheckIn *)aCheckIn
{
    return [self.location.timestamp compare:aCheckIn.location.timestamp];
}

@end
