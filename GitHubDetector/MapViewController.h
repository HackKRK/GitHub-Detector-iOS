//
//  MapViewController.h
//  GitHubDetector
//
//  Created by test on 2/9/12.
//  Copyright 2012 HackKrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MKMapView.h>
#import <MapKit/MKAnnotation.h>

@interface MapViewController : UIViewController {
    MKMapView *mapView;
    NSArray *locations;
}

@property (strong, nonatomic) NSArray *locations;

@end
