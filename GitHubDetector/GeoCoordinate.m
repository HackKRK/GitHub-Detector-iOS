//
//  GeoCoordinate.m
//
//  Created by Krzysztof Profic on 11-03-02.
//  Copyright 2011 Krzysztof Profic. All rights reserved.
//

#import "GeoCoordinate.h"

@interface GeoCoordinate(Private)
- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;
@end


@implementation GeoCoordinate
@synthesize distance, inclination, azimuth;

// Override the azimuth accessor method
- (double)azimuth {
	if ( azimuth < 0.0 ) {
		azimuth = (M_PI * 2.0) + azimuth;
	} else if ( azimuth > (M_PI * 2.0) ) {
		azimuth = azimuth - (M_PI * 2.0);
	}
	return azimuth;
}

- (id)initWithLocation:(CLLocation *)loc { 
    self = [super init];
	if ( self != nil ) {
		self.location = loc;
	}
	return self;
}

- (id)initWithCoordiante:(CLLocation *)loc andOrigin:(CLLocation *)origin {
    self = [super init];
	if ( self != nil ) {
		self.location = loc;
		[self calibrateUsingOrigin:origin];
	}
	return self;
}

//returns the angle between north -> first <- second
- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second {
	float longitudinalDifference = second.longitude - first.longitude;
	float latitudinalDifference	= second.latitude  - first.latitude;
	float possibleAzimuth = (M_PI_2) - atan(latitudinalDifference / longitudinalDifference);	// arc ctan
	
	if (longitudinalDifference > 0) 
		return possibleAzimuth;
	else if (longitudinalDifference < 0) 
		return possibleAzimuth + M_PI;		// ?
	else if (latitudinalDifference < 0) 
		return M_PI;
	
	return 0.0f;
}

// calculating GeoCoordinate's distance
- (void)calibrateUsingOrigin:(CLLocation *)origin {
	double baseDistance = [origin distanceFromLocation:self.location];
	self.distance = baseDistance;// sqrt( pow(  [origin altitude] - [self.location altitude], 2) + pow(baseDistance, 2));
	
    //calculating GeoCoorginate's inclination
	float angle = asin( ABS([origin altitude] - [self.location altitude]) / self.distance);
	if ([origin altitude] > [self.location altitude]) {
		angle = -angle;
	}
	self.inclination = angle;
	
    // calculating GeoCoordinate's azimuth
	self.azimuth = [self angleFromCoordinate:[origin coordinate] toCoordinate:[self.location coordinate]];
}

@end
