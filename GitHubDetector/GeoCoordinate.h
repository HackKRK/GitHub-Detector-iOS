//
//  GeoCoordinate.h
//
//  Created by Krzysztof Profic on 11-03-02.
//  Copyright 2011 Krzysztof Profic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "HKCheckIn.h"

@interface GeoCoordinate : HKCheckIn {
}

- (void)calibrateUsingOrigin:(CLLocation *)origin;
- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;

@property (nonatomic) double distance;
@property (nonatomic) double inclination;	
@property (nonatomic) double azimuth;	
@end
