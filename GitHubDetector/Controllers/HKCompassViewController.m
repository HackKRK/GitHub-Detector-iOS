//
//  HKCompassViewController.m
//  GitHubDetector
//
//  Created by Krzysztof Profic on 12-02-09.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKCompassViewController.h"
#import "HKCompassGeekPoint.h"
#import "HKGeek.h"
#import "HKCheckIn.h"
#import "HKCompassGeekView.h"
#import <QuartzCore/QuartzCore.h>

NSComparisonResult AngleSortASC(HKCompassGeekPoint *s1, HKCompassGeekPoint *s2, void *ignore);

@interface HKCompassViewController()
@property (nonatomic, readwrite, strong) UIView * pointsContainer;      /**< transparent view that is a container for geek views*/
@property (nonatomic, assign) int pointsIndex;                          /**< current element index */
@property (nonatomic, assign) double currentHeadingAngle;
@property (nonatomic, assign) double sonarRadius;                       /**< sonar radius in points */
@property (nonatomic, readwrite, strong)  CLLocation * currentLocation; /**< most up to date user location */
@property (nonatomic, readwrite, strong) CLLocationManager * locationManager;

@property (nonatomic, readwrite, strong) NSMutableArray * geekPoints;
@end

@implementation HKCompassViewController

@synthesize sonarRange=_sonarRange, pointsContainer=_pointsContainer, pointsIndex=_pointsIndex, currentHeadingAngle = _currentHeadingAngle, sonarRadius=_sonarRadius, currentLocation=_currentLocation, geekPoints=_geekPoints;

// TODO proper use of shared app location manager
-(CLLocationManager *)locationManager {
    return [[CLLocationManager alloc] init];
}

-(id)init {
    self = [super init];
    if (self != nil){
        self.geekPoints = [[NSMutableArray alloc] init];
        
        self.pointsIndex = 0;
        self.sonarRadius = 150;
        self.sonarRange = 2000; // 2 km
        self.currentHeadingAngle = 0;
        
        self.pointsContainer = [[UIView alloc] initWithFrame:self.view.frame];
        self.locationManager = [[CLLocationManager alloc] init];
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		self.locationManager.delegate = self;
		[self.locationManager startUpdatingLocation];
        [self.locationManager stopUpdatingHeading];
        self.currentLocation = nil;
        self.geekPoints = [[NSMutableArray alloc] init];
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];

	[self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
}

-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	[self.locationManager stopUpdatingLocation];    
    [self.locationManager startUpdatingHeading];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pointsContainer];
}

-(void)setLocations:(NSMutableArray *) geeks {
    @autoreleasepool {
        for (HKCompassGeekPoint * gp in self.geekPoints) {
            [gp.view removeFromSuperview];
        }
        [self.geekPoints removeAllObjects];
        
        for (HKGeek * geek in geeks) {
            //NSLog(@"set location...");
            CLLocation * l = [geek lastCheckIn].location;
            
            HKCompassGeekView * gv = [[HKCompassGeekView alloc] init]; //WithGeek: geek];
            
            HKCompassGeekPoint * p = [[HKCompassGeekPoint alloc] initWithLocation:l andPointView:gv andSonarRadius:self.sonarRadius];
            [self.geekPoints addObject:p];
            

            [self.pointsContainer addSubview: p.view];
            p.view.center = self.pointsContainer.center;

            if (self.currentLocation != nil) {
                NSLog(@"!= nil");
                [p calibrateUsingOrigin:self.currentLocation andSonarRange:self.sonarRange];
            }
        }
    }
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
NSComparisonResult AngleSortASC(HKCompassGeekPoint *s1, HKCompassGeekPoint *s2, void *ignore) {
    if (s1.azimuth < s2.azimuth) {
		return NSOrderedAscending;
	} else if (s1.azimuth > s2.azimuth) {
		return NSOrderedDescending;
	} else {
		return NSOrderedSame;
	}
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if (newLocation.horizontalAccuracy > 0 && newLocation != oldLocation) {
		self.currentLocation = newLocation;
        NSLog(@"new location %f %f", self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
        
        for (HKCompassGeekPoint* sp in self.geekPoints) {
            [sp calibrateUsingOrigin:self.currentLocation andSonarRange:self.sonarRange];
        }
        [self.geekPoints sortUsingFunction:AngleSortASC context:NULL];   /**< sortujemy elementy wmierze łukowej kąta */
	}
}

- (void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy > 0) {
        self.currentHeadingAngle = newHeading.trueHeading;
        [UIView beginAnimations:@"SonarScreenAnimation" context:NULL];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve: UIViewAnimationCurveLinear];
        [UIView setAnimationRepeatAutoreverses:NO];
        self.pointsContainer.transform = CGAffineTransformMakeRotation(degreesToRadians(-newHeading.trueHeading));
        [UIView commitAnimations];    
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Received Core Location error %@", error);
}



@end
