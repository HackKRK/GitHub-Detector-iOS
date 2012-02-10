//
//  HKMapViewController.m
//  Work From Cafe
//
//  Created by Błażej Biesiada on 1/12/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKMapViewController.h"
#import "HKMapView.h"
#import "HKAroundMe.h"

@interface HKMapViewController () // Private
@property (nonatomic, readwrite, strong) HKAroundMe *aroundMe;
@property (nonatomic, readwrite, strong) HKMapView *view;
@end

@implementation HKMapViewController

@synthesize aroundMe = _aroundMe;
@dynamic view; // supplied by UIViewController

- (id)init
{
    if ((self = [super init]))
    {
        self.aroundMe = [[HKAroundMe alloc] init];
        self.title = @"Map";
        
        [self.aroundMe addObserver:self
                        forKeyPath:@"checkIns"
                           options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionInitial
                           context:NULL];
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.view.mapView setCenterCoordinate:self.aroundMe.myLocation.coordinate
                                  animated:YES];
    
    MKCoordinateSpan span;
    span.latitudeDelta = 0.1;
    span.longitudeDelta = 0.1;
    
    MKCoordinateRegion region;
    region.center = self.aroundMe.myLocation.coordinate;
    region.span = span;
    
    [self.view.mapView addAnnotations:self.aroundMe.checkIns];
    [self.view.mapView setRegion:region animated:YES];
}


- (void)loadView
{
    self.view = [[HKMapView alloc] initWithFrame:CGRectZero];
    self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.view.mapView.delegate = self;
    self.view.mapView.mapType = MKMapTypeStandard;
}

#pragma mark -
#pragma mark <MKMapViewDelegate>


@end
