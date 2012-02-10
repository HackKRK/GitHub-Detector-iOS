//
//  GeoCoordinate.h
//
//  Created by Krzysztof Profic on 11-03-02.
//  Copyright 2011 Krzysztof Profic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HKCompassGeekPoint : NSObject;

@property (nonatomic) double distance;
@property (nonatomic) double inclination;
@property (nonatomic) double azimuth;
@property (nonatomic, readwrite, strong) CLLocation * location;
@property (nonatomic, readwrite, strong) UIView* view;

- (id) initWithLocation:(CLLocation *)loc andPointView: (UIView *) pointView andSonarRadius: (double) radiusInPoints;

- (void) calibrateUsingOrigin:(CLLocation *)origin andSonarRange: (double) sonarRange;
- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;
@end
