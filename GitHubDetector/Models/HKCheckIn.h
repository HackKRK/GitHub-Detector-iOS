//
//  HKCheckIn.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class HKGeek;

@interface HKCheckIn : NSObject {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readwrite, strong) HKGeek *geek;
@property (nonatomic, readwrite, strong) CLLocation *location;
@property (nonatomic, readwrite, strong) NSString *message;

- (id)initFromJSON:(NSDictionary *)json;
- (NSComparisonResult)compareDate:(HKCheckIn *)aCheckIn;

@end
