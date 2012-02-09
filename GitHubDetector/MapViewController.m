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

<<<<<<< HEAD
=======
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
>>>>>>> 0c17294dc25750f9cd4a232521332e1267861cd3

#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mapView];
}

-(void) setLocations:(NSArray *)_locations {
    
    locations = _locations;
    
    for (HKCheckIn *check in _locations) {
        
    }
    
    for (id<MKAnnotation> annotation  in mapView.annotations) {
        [mapView removeAnnotation:annotation];
    }
    
    [mapView addAnnotations:locations];
}

@end
