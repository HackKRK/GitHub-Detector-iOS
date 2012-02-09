//
//  HKCompassViewController.m
//  GitHubDetector
//
//  Created by Krzysztof Profic on 12-02-09.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKCompassViewController.h"
#import "GeoCoordinate.h"
#import <QuartzCore/QuartzCore.h>

NSComparisonResult AngleSortASC(GeoCoordinate *s1, GeoCoordinate *s2, void *ignore);

@interface HKCompassViewController()
@property (nonatomic, readwrite, strong) UIView * pointsContainer;      /**< transparent view that is a container for geek views*/
@property (nonatomic, assign) int pointsIndex;                          /**< current element index */
@property (nonatomic, assign) double currentHeadingAngle;
@property (nonatomic, assign) double sonarRadius;                       /**< sonar radius in points */
@property (nonatomic, readwrite, strong)  CLLocation * currentLocation; /**< most up to date user location */
@property (nonatomic, readonly) CLLocationManager * locationManager;
@end

@implementation HKCompassViewController

@synthesize sonarRange=_sonarRange, pointsContainer=_pointsContainer, pointsIndex=_pointsIndex, currentHeadingAngle = _currentHeadingAngle, sonarRadius=_sonarRadius, currentLocation=_currentLocation;

// TODO proper use of shared app location manager
-(CLLocationManager *)locationManager {
    return [[CLLocationManager alloc] init];
}

-(void)setLocations:(NSMutableArray *) loc {
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];

}


#pragma mark CLLocationManager Delegate Methods

NSComparisonResult AngleSortASC(GeoCoordinate *s1, GeoCoordinate *s2, void *ignore) {
    if (s1.azimuth < s2.azimuth) {
		return NSOrderedAscending;
	} else if (s1.azimuth > s2.azimuth) {
		return NSOrderedDescending;
	} else {
		return NSOrderedSame;
	}
}

@end
