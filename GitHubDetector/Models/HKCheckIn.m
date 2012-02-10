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
- (id)_initFromJSON:(NSDictionary *)json;
+ (NSMutableSet *)_checkIns;
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

- (NSString *)title
{
    return self.geek.login;
}

- (NSString *)subtitle
{
    return self.message;
}

+ (NSMutableSet *)_checkIns
{
    static NSMutableSet *checkIns = nil;
    if (checkIns == nil)
    {
        checkIns = [[NSMutableSet alloc] initWithCapacity:64];
    }
    return checkIns;
}

+ (HKCheckIn *)checkInFromJSON:(NSDictionary *)json
{
    HKCheckIn *newCheckIn = [[HKCheckIn alloc] _initFromJSON:json];
    HKCheckIn *existingCheckIn = [[self _checkIns] member:newCheckIn];
    
    if (existingCheckIn != nil)
    {
        return existingCheckIn;
    }
    else
    {
        [[self _checkIns] addObject:newCheckIn];
        return newCheckIn;
    }
}

- (id)initFromJSON:(NSDictionary *)json
{
    return [self _initFromJSON:json];
}

- (id)_initFromJSON:(NSDictionary *)json;
{
    if (self = [super init])
    {
        // geek
        self.geek = [HKGeek geekFromJSON:json];
        
        // msg
        self.message = HKReadJsonObject([json objectForKey:@"text"]);
        
        // geo
        CLLocationCoordinate2D location;
        location.latitude = [HKReadJsonObject([json objectForKey:@"lat"]) doubleValue];
        location.longitude = [HKReadJsonObject([json objectForKey:@"lng"]) doubleValue];
        NSDate *timestamp = [[NSDate alloc] initWithTimeIntervalSince1970:[HKReadJsonObject([json objectForKey:@"date"]) doubleValue]];
        self.location = [[CLLocation alloc] initWithCoordinate:location
                                                      altitude:0
                                            horizontalAccuracy:0
                                              verticalAccuracy:0
                                                     timestamp:timestamp];
    }
    return self;
}

- (BOOL)isEqual:(HKCheckIn *)otherCheckIn
{
    if ([otherCheckIn isKindOfClass:[HKCheckIn class]] && [otherCheckIn.location.timestamp isEqualToDate:self.location.timestamp] == NSOrderedSame)
    {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash
{
    return [self.location.timestamp timeIntervalSince1970];
}

- (NSComparisonResult)compareDate:(HKCheckIn *)aCheckIn
{
    return [self.location.timestamp compare:aCheckIn.location.timestamp];
}

@end
