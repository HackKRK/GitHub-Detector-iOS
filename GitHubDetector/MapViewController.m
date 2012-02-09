//
//  MapViewController.m
//  GitHubDetector
//
//  Created by test on 2/9/12.
//  Copyright 2012 HackKrk. All rights reserved.
//

#import "MapViewController.h"
#import "HKCheckIn.h"

@implementation MapViewController
@synthesize locations;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mapView];
}

-(void) setLocations:(NSArray *)_locations {
    
    locations = _locations;
    
    for (id<MKAnnotation> annotation  in mapView.annotations) {
        [mapView removeAnnotation:annotation];
    }
    
    [mapView addAnnotations:locations];
}

@end
