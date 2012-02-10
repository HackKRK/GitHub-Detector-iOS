//
//  HKCheckIn.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define HKReadJsonObject( obj ) (obj) != [NSNull null] ? (obj) : nil

@class HKGeek;

@interface HKCheckIn : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

@property (nonatomic, readwrite, strong) HKGeek *geek;
@property (nonatomic, readwrite, strong) CLLocation *location;
@property (nonatomic, readwrite, strong) NSString *message;

+ (HKCheckIn *)checkInFromJSON:(NSDictionary *)json;
- (id)initFromJSON:(NSDictionary *)json __attribute__((deprecated));
- (NSComparisonResult)compareDate:(HKCheckIn *)aCheckIn;

@end
