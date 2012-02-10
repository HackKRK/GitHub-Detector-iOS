//
//  GeoCoordinate.m
//
//  Created by Krzysztof Profic on 11-03-02.
//  Copyright 2011 Krzysztof Profic. All rights reserved.
//

#import "HKCompassGeekPoint.h"

@interface HKCompassGeekPoint()
@property (nonatomic, strong) UIView *pointView;
- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;
@end


@implementation HKCompassGeekPoint
@synthesize distance, inclination, azimuth, view, pointView=_pointView, location=_location;

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
	}
	return self;
}
- (id) initWithLocation:(CLLocation *)loc andPointView: (UIView *) pointView andSonarRadius: (double) radiusInPoints {

    self = [super init];
    if (self != nil){
        self.location = loc;
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, radiusInPoints, radiusInPoints)];
        self.pointView = pointView;
        [self.view addSubview:pointView];
        self.view.backgroundColor = [UIColor blueColor];
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
		return possibleAzimuth + M_PI;
	else if (latitudinalDifference < 0) 
		return M_PI;
	
	return 0.0f;
}

// calculating GeoCoordinate's distance
- (void) calibrateUsingOrigin:(CLLocation *)origin andSonarRange: (double) sonarRange {
	double baseDistance = [origin distanceFromLocation:self.location];
	self.distance = baseDistance;   // sqrt( pow(  [origin altitude] - [self.location altitude], 2) + pow(baseDistance, 2));
	
    //calculating GeoCoorginate's inclination
	float angle = asin( ABS([origin altitude] - [self.location altitude]) / self.distance);
	if ([origin altitude] > [self.location altitude]) {
		angle = -angle;
	}
	self.inclination = angle;
	
    // calculating GeoCoordinate's azimuth
	self.azimuth = [self angleFromCoordinate:[origin coordinate] toCoordinate:[self.location coordinate]];
    
    //calibrate view
    dispatch_async(dispatch_get_main_queue(), ^{
        self.pointView.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2 - (view.bounds.size.height/2)*(self.distance/sonarRange));
        view.transform = CGAffineTransformMakeRotation(self.azimuth);
    });
}

@end
