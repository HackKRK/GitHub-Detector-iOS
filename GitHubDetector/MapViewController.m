//
//  MapViewController.m
//  GitHubDetector
//
//  Created by test on 2/9/12.
//  Copyright 2012 HackKrk. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController
@synthesize locations;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void) dealloc {
    [mapView release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:mapView];
}



@end
